*** Settings ***
Documentation     A resource file with reusable keywords and variables for xtest.
...
Library           SSHLibrary
Library           String

*** Variables ***
${TARGET}         192.168.29.140
${USERNAME}       root
${PASSWORD}       ${EMPTY}
${TIMEOUT}        4m

*** Keywords ***
Open Connection And Log In
    Open Connection    ${TARGET}
    Login    ${USERNAME}    ${PASSWORD}
    Set Client Configuration    timeout=${TIMEOUT}    prompt=root@hikey:~#

Run Tee Supplicant
    Start Command    /usr/bin/tee-supplicant

Terminate Tee Supplicant
    Start Command    pkill tee-supplicant

Run Regression Test
    write    xtest -t regression
    ${result}    Read Until Prompt
    Should Contain    ${result}    TEE test application done!

Run Benchmark Test
    write    xtest -t benchmark
    ${result}    Read Until Prompt
    Should Contain    ${result}    TEE test application done!
