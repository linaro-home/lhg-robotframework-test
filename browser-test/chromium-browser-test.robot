*** Settings ***
Suite Setup       Open SSH Connection And Login
Suite Teardown    Close Connection and Browser
Resource          lhg-robot-config.robot

*** Test Cases ***
Start-Chromedriver
    Run Chromedriver

Run-Chromium-Browser-test
    Open Browser To Test Page    ${TESTPAGE}
    Page Should Contain    Google
