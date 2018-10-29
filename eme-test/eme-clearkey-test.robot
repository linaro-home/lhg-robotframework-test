*** Settings ***
Suite Setup       Open SSH Connection And Login      ${TARGET}   ${USER}     ${PASSWORD}
Suite Teardown    Close Connection and Browser
Resource          resource.robot

*** Test Cases ***
Check-rpcbind
    Check rpcbind

Start-Chromedriver
    Run Chromedriver

Start-cdmiservice
    Run Cdmiservice For EME Clearkey Test

Run-EME-ClearKey-test
    Open Browser To Test Page    ${TARGET_CD}   ${CK_TESTPAGE}
    Select Key System    External Clearkey
    Sleep    5s
    Scroll Page Down To Bottom
    Play Video    Play
    Sleep    3s
    Click Button    Play
    Sleep    10s
    Capture Page Screenshot    filename=After.png
    There should be face in image    After.png
