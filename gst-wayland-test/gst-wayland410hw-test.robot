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
    ${output}    Execute Command    ${TEST_PROGRAM} -v filesrc location=/home/linaro/${VIDEO_FILE} ! qtdemux name=d d. ! h264parse ! v4l2video0dec capture-io-mode=dmabuf ! videoconvert ! waylandsink d. ! queue ! aacparse ! avdec_aac ! audioconvert ! audio/x-raw,format=S16LE ! alsasink 2>/dev/null
    Log To Console      ${output}
    Should Contain    ${output}    Execution ended after 0:02:00

