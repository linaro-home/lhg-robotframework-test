*** Settings ***
Documentation     A resource file with reusable keywords and variables for xtest.
Library           SSHLibrary
Library           String

*** Variables ***
${TARGET}         192.168.29.143
${USERNAME}       linaro
${PASSWORD}       ${EMPTY}
${TIMEOUT}        4m
${TEST_PROGRAM}    /usr/bin/weston-simple-egl

*** Keywords ***
Open Connection And Log In
    Open Connection    ${TARGET}
    Login    ${USERNAME}    ${PASSWORD}
    Set Client Configuration    timeout=${TIMEOUT}
    Write    su

Run Test-1
    Write    ${TEST_PROGRAM} -f

Run Test-2
    Write    ${TEST_PROGRAM} -f -b

Terminate The Program
    ${ctrl_c}    Evaluate    chr(int(3))
    Write Bare    ${ctrl_c}
