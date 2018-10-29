*** Settings ***
Documentation     A resource file with reusable keywords and variables.
...
...               The system specific keywords created here form our own
...               domain specific language.
Library           SeleniumLibrary    timeout=180s    run_on_failure=Nothing
Library           SSHLibrary    timeout=30s
Library           Collections
Library           lhg-robot-libs.py
Resource          ../lib/robotframework-test-lib.robot

*** Variables ***
${TARGET}                   192.168.29.144
${USER}                     linaro
${PASSWORD}                 ${EMPTY}
${TARGET_CD}                http://${TARGET}:9515
${CK_TESTPAGE}              http://people.linaro.org/~peter.griffin/chrome/eme_player.html
${PR_TESTPAGE}              http://people.linaro.org/~arthur.she/playready_test/dash.js/samples/dash-if-reference-player/index.html
${PR_VIDEO_URL}             http://profficialsite.origin.mediaservices.windows.net/c51358ea-9a5e-4322-8951-897d640fdfd7/tearsofsteel_4k.ism/manifest(format=mpd-time-csf)
${CHROMEDRIVER_DEF_DIR}     /usr/bin/chromium/chromedriver
${CHROMEDRIVER_OPTS}        --verbose --whitelisted-ips --log-path=/home/linaro/chromedriver.log &

*** Keywords ***
Check rpcbind
    write       rpcbind=`ps|grep rpcbin[d]`; [ -n "$rpcbind" ] || rpcbind
    Read        delay=2s

Run Cdmiservice
    ${stdout}=    write    cdmiservice &
    #Log To Console      ${stdout}
    ${output}=    Read    delay=4s
    #Log To Console      ${output}
    ${stdout}=      write       ps|grep cdmis
    #Log To Console      ${stdout}
    ${output}       Read    delay=2s
    #Log To Console      ${output}
    Should Match Regexp     ${output}       ^\\ +\\d+.*cdmiservice

Run Cdmiservice For EME Clearkey Test
    Run Cdmiservice

Run Cdmiservice For EME Playready Test
    ${stdout}=    write    cd /usr/share/playready
    ${output}=    Read    delay=1s
    Should Not Contain    ${output}    No such file or directory
    Run Cdmiservice

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
