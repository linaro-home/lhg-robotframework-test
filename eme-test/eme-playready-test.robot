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
    Run Cdmiservice For EME Playready Test

Run-EME-Playready-test
    Open Browser To Test Page    ${TARGET_CD}       ${PR_TESTPAGE}
    Click Button        xpath=//button[@data-toggle='dropdown']
    Sleep       5s
    Mouse Over          xpath=//a[text()='Microsoft Test Content']
    Wait Until Element Is Visible   xpath=//a[text()='Microsoft AZURE MEDIA SERVICES ON DEMAND H264 AAC 4K CENC PLAYREADY 2.0']
    Click Element          xpath=//a[text()='Microsoft AZURE MEDIA SERVICES ON DEMAND H264 AAC 4K CENC PLAYREADY 2.0']
    Click Element          id=enableVideoStartTime
    Input Text          id=videoStartTime       28
    Play Video    Load
    Wait Until Element Contains     id=videoStatus      Playing
    Capture Page Screenshot    filename=After.png
    There should be face in image    After.png
