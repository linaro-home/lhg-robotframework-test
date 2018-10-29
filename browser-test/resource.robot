*** Settings ***
Documentation     A resource file with reusable keywords and variables.
...
...               The system specific keywords created here form our own
...               domain specific language.
Library           SeleniumLibrary    timeout=90s    run_on_failure=Nothing
Library           SSHLibrary    timeout=30s
Library           Collections
Resource          ../lib/robotframework-test-lib.robot

*** Variables ***
${TARGET}         192.168.29.143
${USER}           linaro
${PASSWORD}       ${EMPTY}
${TARGET_CD}      http://${TARGET}:9515
${TESTPAGE}       http://www.google.com

*** Keywords ***
Scroll Page Down To Bottom
    Execute Javascript    window.scrollTo(0,document.body.scrollHeight);
