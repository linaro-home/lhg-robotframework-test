*** Settings ***
Documentation     A resource file with reusable keywords and variables for xtest.
Library           SSHLibrary
Library           String
Resource          ../lib/robotframework-test-lib.robot

*** Variables ***
${TARGET}         192.168.29.143
${USER}           linaro
${PASSWORD}       ${EMPTY}
${TIMEOUT}        4m
${TEST_PROGRAM}    /usr/bin/weston-simple-egl

*** Keywords ***
Run Test-1
    Write    ${TEST_PROGRAM} -f

Run Test-2
    Write    ${TEST_PROGRAM} -f -b

Terminate The Program
    ${ctrl_c}    Evaluate    chr(int(3))
    Write Bare    ${ctrl_c}
