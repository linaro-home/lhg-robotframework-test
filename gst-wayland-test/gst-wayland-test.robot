*** Settings ***
Documentation     This test plays a video with "gst-launch-1.0" on a remote machine
...               and getting the test result.
Suite Setup       Open Connection And Log In
Suite Teardown    Close All Connections
Resource          resource.robot

*** Test Cases ***
Download-Video-File
    [Documentation]    Download ${VIDEO_FILE} from ${VIDEO_FILE_URL}
    Download Video File

Run gst-wayland-test
    [Documentation]    Play ${VIDEO_FILE} with ${TEST_PROGRAM} and check the output message
    ${output}    Execute Command    ${TEST_PROGRAM} playbin uri=file:///home/linaro/${VIDEO_FILE} video-sink=waylandsink audio-sink=fakesink 2>/dev/null
    Log To Console      ${output}
    Should Not Contain    ${output}    A lot of buffers are being dropped
    Should Contain    ${output}    Execution ended after 0:02:00

