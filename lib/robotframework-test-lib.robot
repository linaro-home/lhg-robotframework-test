*** Settings ***
Documentation     A resource file with reusable keywords
...
...               The system specific keywords created here form our own
...               domain specific language.
Library           SeleniumLibrary    timeout=90s    run_on_failure=Nothing
Library           SSHLibrary    timeout=30s
Library           Collections

*** Keywords ***
Run Chromedriver
    Start Command        find /usr/bin -name chromedriver
    ${chromedriver}      Read Command Output
    Log To Console          chromedriver located at ${chromedriver}
    write     ${chromedriver} --verbose --whitelisted-ips --log-path=/home/linaro/chromedriver.log &
    ${output}=    Read    delay=2s
    Should Contain      ${output}       All remote connections are allowed. Use a whitelist instead

Prepare Browser
    [Arguments]     ${target_webdriver}
    ${capabilities}=    Create Dictionary
    ${extension_list}=    Create List
    ${args_list}=    Create List    --no-sandbox    --register-pepper-plugins=/usr/lib64/chromium/libopencdmadapter.so;application/x-ppapi-open-cdm    --in-process-gpu    --enable-logging=/home/root/chromium_browser.log    --v=0
    Set To Dictionary    ${capabilities}    extensions    ${extension_list}
    Set To Dictionary    ${capabilities}    args    ${args_list}
    ${desired_capabilities}=    Create Dictionary    chromeOptions=${capabilities}
    ${executor}=    Evaluate    str('${target_webdriver}')
    Create WebDriver    Remote    desired_capabilities=${desired_capabilities}    command_executor=${executor}
    Maximize Browser Window

Open Browser To Test Page
    [Arguments]    ${target_webdriver}  ${testpage}
    Prepare Browser     ${target_webdriver}
    Go To    ${testpage}

Open SSH Connection And Login
    [Arguments]    ${target}    ${user}     ${password}
    Open Connection    ${target}
    Login    ${user}    ${password}
    Write     su

Close Connection and Browser
    Close All Browsers
    Close All Connections

