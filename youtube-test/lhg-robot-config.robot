*** Settings ***
Documentation     A resource file with reusable keywords and variables.
...
...               The system specific keywords created here form our own
...               domain specific language.
Library           ExtendedSelenium2Library    timeout=90s    run_on_failure=Nothing
Library           SSHLibrary    timeout=30s    prompt=hikey:~$
Library           Collections
Library           lhg-robot-libs.py

*** Variables ***
${TARGET}         192.168.29.144
${USERNAME}       linaro
${PASSWORD}       ${EMPTY}
${TARGET_CD}      http://${TARGET}:9515
${TESTPAGE}       https://www.youtube.com/watch?v=_eklI09Vmi8

*** Keywords ***
Open SSH Connection And Login
    Open Connection    ${TARGET}
    Login    ${USERNAME}    ${PASSWORD}

Run Chromedriver
    ${written}=    write    su
    ${stdout}=    write    /usr/bin/chromium/chromedriver --verbose --whitelisted-ips --log-path=/home/linaro/chromedriver.log &
    ${output}    Read    delay=2s
    Sleep    3s

Prepare Browser
    ${capabilities}=    Create Dictionary
    ${extension_list}=    Create List
    ${args_list}=    Create List    --no-sandbox    --register-pepper-plugins=/usr/lib64/chromium/libopencdmadapter.so;application/x-ppapi-open-cdm    --in-process-gpu    --enable-logging=/home/root/chromium_browser.log    --v=0
    Set To Dictionary    ${capabilities}    extensions    ${extension_list}
    Set To Dictionary    ${capabilities}    args    ${args_list}
    ${desired_capabilities}=    Create Dictionary    chromeOptions=${capabilities}
    ${executor}=    Evaluate    str('${TARGET_CD}')
    Create WebDriver    Remote    desired_capabilities=${desired_capabilities}    command_executor=${executor}
    Maximize Browser Window

Open Browser To Test Page
    [Arguments]    ${testpage}
    Prepare Browser
    Go To    ${testpage}

Scroll Page Down To Bottom
    Execute Javascript    window.scrollTo(0,document.body.scrollHeight);

Close Connection and Browser
    Close Browser
    Close All Connections
