*** Settings ***
Suite Setup       Open SSH Connection And Login
Suite Teardown    Close Connection and Browser
Resource          lhg-robot-config.robot

*** Test Cases ***
Start-Chromedriver
    Run Chromedriver

Start-cdmiservice
    Run Cdmiservice For EME Playready Test

Run-EME-Playready-test
    Open Browser To Test Page    ${PR_TESTPAGE}
    Input text    model=selectedItem.url    ${PR_VIDEO_URL}
    Play Video    Load
    Sleep    10s
    Capture Page Screenshot    filename=After.png
    There should be face in image    After.png
