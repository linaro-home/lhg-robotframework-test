*** Settings ***
Suite Setup       Open SSH Connection And Login
Suite Teardown    Close Connection and Browser
Resource          lhg-robot-config.robot

*** Test Cases ***
Start-Chromedriver
    Run Chromedriver

Run-Webgl-Morphtargets-Horse-test
    Open Browser To Test Page    ${TESTPAGE}
    Sleep       15s
    Capture Page Screenshot    filename=Screenshot.png
    Crop Fps Portion And Enlarge it     screenshot=Screenshot.png       processed_img=Enlarged-FPS.png
    ${string}=         Recognize Characters From The Image     image=Enlarged-FPS.png
    Log To Console    ${string}
    Should Contain      ${string}       FPS    
