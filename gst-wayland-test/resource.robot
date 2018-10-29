*** Settings ***
Documentation     A resource file with reusable keywords and variables for the test.
Library           SSHLibrary
Library           String
Resource          ../lib/robotframework-test-lib.robot

*** Variables ***
${TARGET}         192.168.29.143
${USER}           linaro
${PASSWORD}       ${EMPTY}
${TIMEOUT}        4m
${TEST_PROGRAM}    /usr/bin/gst-launch-1.0
${VIDEO_FILE}     ToS-4k-1920.mp4
${VIDEO_FILE_URL}    http://people.linaro.org/~arthur.she/test-materials

*** Keywords ***
Download Video File
    Execute Command    wget -O /home/linaro/${VIDEO_FILE} ${VIDEO_FILE_URL}/${VIDEO_FILE}
    ${output}    Execute Command    ls -l /home/linaro
    Should Contain    ${output}    ${VIDEO_FILE}
