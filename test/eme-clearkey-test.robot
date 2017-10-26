*** Settings ***
Suite Setup       Open SSH Connection And Login
Suite Teardown    Close Connection and Browser
Resource          lhg-robot-config.robot

*** Test Cases ***
Start-Chromedriver
    Run Chromedriver

Start-cdmiservice
    Run Cdmiservice For EME Clearkey Test

Run-wget-test
    Run wget test page

Run-EME-ClearKey-test
    Open Browser To Test Page    ${CK_TESTPAGE}
    Select Key System    External Clearkey
    Sleep    5s
    Scroll Page Down To Bottom
    Play Video    Play
    Sleep    10s
    Capture Page Screenshot    filename=After.png
    There should be face in image    After.png
