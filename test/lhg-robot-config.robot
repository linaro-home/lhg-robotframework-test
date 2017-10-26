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
${TARGET}         192.168.29.143
${USERNAME}       linaro
${PASSWORD}       ${EMPTY}
${TARGET_CD}      http://${TARGET}:9515
${CK_TESTPAGE}    http://people.linaro.org/~peter.griffin/chrome/eme_player.html
${PR_TESTPAGE}    http://people.linaro.org/~peter.griffin/dash.js.mainline/samples/dash-if-reference-player/index.html
${PR_VIDEO_URL}    http://wams.edgesuite.net/media/SintelTrailer_Smooth_from_WAME_CENC/CENC/sintel_trailer-1080p.ism/manifest(format=mpd-time-csf)

*** Keywords ***
Open SSH Connection And Login
    Open Connection    ${TARGET}
    Login    ${USERNAME}    ${PASSWORD}

Run Chromedriver
    ${written}=    write    su
    ${stdout}=    write    /usr/bin/chromium/chromedriver --verbose --whitelisted-ips --log-path=/home/linaro/chromedriver.log &
    ${output}    Read    delay=2s
    Sleep    3s

Run Cdmiservice For EME Clearkey Test
    ${stdout}=    write    cdmiservice &
    ${output}=    Read    delay=1s
    Sleep    4s

Run Cdmiservice For EME Playready Test
    ${stdout}=    write    cd /usr/share/playready
    ${output}=    Read    delay=1s
    Should Contain    ${output}    ‘eme_player.html’ saved
    ${stdout}    write    cdmiservice &
    Sleep    3s

Run wget test page
    write    rm -f *.html
    ${stdout}=    write    wget ${CK_TESTPAGE}
    Sleep    5s
    ${output}=    Read    delay=1s
    Should Contain    ${output}    eme_player.html

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

Input Video URL
    [Arguments]    ${video_url}
    Input Text    id=mediaFile    ${video_url}

Select Key System
    [Arguments]    ${key_system}
    Select From List By Label    id=keySystemList    ${key_system}

Scroll Page Down To Bottom
    Execute Javascript    window.scrollTo(0,document.body.scrollHeight);

Play Video
    [Arguments]    ${Play_Btn}
    Click Button    ${Play_Btn}

Close Connection and Browser
    Close Browser
    Close All Connections
