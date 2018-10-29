*** Settings ***
Documentation     A resource file with reusable keywords and variables.
...
...               The system specific keywords created here form our own
...               domain specific language.
Library           SeleniumLibrary    timeout=90s    run_on_failure=Nothing
Library           SSHLibrary    timeout=30s
Library           Collections
Library           lhg-robot-libs.py
Resource          ../lib/robotframework-test-lib.robot

*** Variables ***
${TARGET}         192.168.29.144
${USER}           linaro
${PASSWORD}       ${EMPTY}
${TARGET_CD}      http://${TARGET}:9515
#${TESTPAGE}       https://www.youtube.com/watch?v=_eklI09Vmi8&t=0m10s
${TESTPAGE}       https://www.youtube.com/results?search_query=Linaro+shows+Video+Playback+Verification+with+Robot+framework+and+OpenCV

*** Keywords ***
Scroll Page Down To Bottom
    Execute Javascript    window.scrollTo(0,document.body.scrollHeight);
