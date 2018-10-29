*** Settings ***
Suite Setup       Open SSH Connection And Login      ${TARGET}   ${USER}     ${PASSWORD}
Suite Teardown    Close Connection and Browser
Resource          resource.robot

*** Test Cases ***
Start-Chromedriver
    Run Chromedriver

Run-Chromium-Browser-test
    Open Browser To Test Page    ${TARGET_CD}   ${TESTPAGE}
    Page Should Contain    Google
