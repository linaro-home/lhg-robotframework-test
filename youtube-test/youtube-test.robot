*** Settings ***
Suite Setup       Open SSH Connection And Login
Suite Teardown    Close Connection and Browser
Resource          lhg-robot-config.robot

*** Test Cases ***
Start-Chromedriver
    Run Chromedriver

Run-youtube-test
    Open Browser To Test Page    ${TESTPAGE}
    Sleep    10s
    Capture Page Screenshot    filename=After.png
    There should be face in image    After.png
