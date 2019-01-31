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
    Set Client Configuration    timeout=${TIMEOUT}

Run Tee Supplicant
    Start Command    /usr/bin/tee-supplicant

Terminate Tee Supplicant
    Start Command    pkill tee-supplicant

Run Regression Test
    ${stdout}      ${rc}=      Execute Command     xtest -t regression     return_rc=True
    Log To Console      ${stdout}
    Should Be Equal As Integers	    ${rc}	    0

Run Benchmark Test
    ${stdout}      ${rc}=      Execute Command     xtest -t benchmark      return_rc=True
    Log To Console      ${stdout}
    Should Be Equal As Integers	    ${rc}	    0
