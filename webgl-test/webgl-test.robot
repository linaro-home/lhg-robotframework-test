*** Settings ***
Suite Setup       Open SSH Connection And Login     ${TARGET}   ${USER}     ${PASSWORD}
Suite Teardown    Close Connection and Browser
Resource          resource.robot

*** Test Cases ***
Start-Chromedriver
    Run Chromedriver

Run-Webgl-Morphtargets-Horse-test
    Open Browser To Test Page    ${TARGET_CD}       ${TESTPAGE}
    Sleep       15s
    Capture Page Screenshot    filename=Screenshot.png
    Crop Fps Portion And Enlarge it     screenshot=Screenshot.png       processed_img=Enlarged-FPS.png
    ${string}=         Recognize Characters From The Image     image=Enlarged-FPS.png
    Log To Console    ${string}
    Should Contain      ${string}       FPS    
