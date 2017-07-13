*** Settings ***
Suite Setup       Open SSH Connection And Login
Suite Teardown    Close Connection and Browser
Resource          lhg-robot-config.robot

*** Test Cases ***
Start Chromedriver
    Run Chromedriver

Run EME test
    Open Browser To Test Page
    Input Video URL    ${TEST_VIDEO_URL}
    Select Key System    ${KEY_SYSTEM}
    Sleep    5s
    Scroll Page Down To Bottom
    Play Video
    Sleep    30s
    Capture Page Screenshot    filename=After.png
    There should be face in image    After.png
