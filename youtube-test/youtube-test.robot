*** Settings ***
Suite Setup       Open SSH Connection And Login      ${TARGET}      ${USER}     ${PASSWORD}
Suite Teardown    Close Connection and Browser
Resource          resource.robot

*** Test Cases ***
Start-Chromedriver
    Run Chromedriver

Run-youtube-test
    Open Browser To Test Page    ${TARGET_CD}       ${TESTPAGE}
    Sleep    1s
    Click Link      Linaro shows Video Playback Verification with Robot framework and OpenCV
    Sleep   10s
    Capture Page Screenshot    filename=After.png
    There should be face in image    After.png
    Close All Browsers
