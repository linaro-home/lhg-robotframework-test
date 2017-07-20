*** Settings ***
Documentation     A resource file with reusable keywords and variables.
...
...               The system specific keywords created here form our own
...               domain specific language.
Library           Selenium2Library    timeout=90s    run_on_failure=Nothing
Library           SSHLibrary    timeout=30s    prompt=hikey:~$
Library           Collections
Library           lhg-robot-libs.py

*** Variables ***
${TARGET}         192.168.29.107
${USERNAME}       linaro
${PASSWORD}       ${EMPTY}
${TARGET_CD}      http://${TARGET}:9515
${CK_TESTPAGE}    http://people.linaro.org/~naresh.kamboju/chrome/eme_player.html
${CK_TEST_VIDEO_URL}    http://people.linaro.org/~arthur.she/chrome/Chrome_44-enc_av.webm

*** Keywords ***
Open SSH Connection And Login
    Open Connection    ${TARGET}
    Login    ${USERNAME}    ${PASSWORD}

Run Chromedriver
    ${written}=    write    su
    ${stdout}=    write    /usr/bin/chromium/chromedriver --verbose --whitelisted-ips --log-path=/home/linaro/chromedriver.log &
    Sleep    5s

Prepare Browser
    ${capabilities}=    Create Dictionary
    ${extension_list}=    Create List
    ${args_list}=    Create List    --no-sandbox    --register-pepper-plugins=/usr/lib/chromium/libopencdmadapter.so;application/x-ppapi-open-cdm    --in-process-gpu    --enable-logging=/home/root/chromium_browser.log    --v=0
    Set To Dictionary    ${capabilities}    extensions    ${extension_list}
    Set To Dictionary    ${capabilities}    args    ${args_list}
    ${desired_capabilities}=    Create Dictionary    chromeOptions=${capabilities}
    ${executor}=    Evaluate    str('${TARGET_CD}')
    Create WebDriver    Remote    desired_capabilities=${desired_capabilities}    command_executor=${executor}
    Maximize Browser Window

Open Browser To Test Page
    Prepare Browser
    Go To    ${CK_TESTPAGE}
    Wait Until Element Is Visible    id=keySystemList

Input Video URL
    [Arguments]    ${video_url}
    Input Text    id=mediaFile    ${video_url}

Select Key System
    [Arguments]    ${key_system}
    Select From List By Label    id=keySystemList    ${key_system}

Scroll Page Down To Bottom
    Execute Javascript    window.scrollTo(0,document.body.scrollHeight);

Play Video
    Click Button    Play

Close Connection and Browser
    Close Browser
    Close All Connections
