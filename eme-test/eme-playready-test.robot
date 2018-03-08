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
    #Input text    xpath=//input[@ng-model='selectedItem.url']    ${PR_VIDEO_URL}
    Click Button        xpath=//button[@data-toggle='dropdown']
    Sleep       5s
    #Wait Until Element Is Visible   xpath=//a[text()='Microsoft Test Content']
    Mouse Over          xpath=//a[text()='Microsoft Test Content']
    #Sleep       5s
    Wait Until Element Is Visible   xpath=//a[text()='Microsoft AZURE MEDIA SERVICES ON DEMAND H264 AAC 4K CENC PLAYREADY 2.0']
    Click Element          xpath=//a[text()='Microsoft AZURE MEDIA SERVICES ON DEMAND H264 AAC 4K CENC PLAYREADY 2.0']
    #Click Element          xpath=//a[text()='Microsoft #1']
    #Sleep       2s
    Play Video    Load
    Sleep    40s
    Capture Page Screenshot    filename=After.png
    There should be face in image    After.png
