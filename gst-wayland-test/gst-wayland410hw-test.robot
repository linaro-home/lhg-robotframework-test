*** Settings ***
Documentation     This test plays a video with "gst-launch-1.0" by using venus engine for hw decoding
...               on a remote machine and getting the test result.
Suite Setup       Open Connection And Log In
Suite Teardown    Close All Connections
Resource          resource.robot

*** Test Cases ***
Download-Video-File
    [Documentation]    Download ${VIDEO_FILE} from ${VIDEO_FILE_URL}
    Download Video File

Run gst-wayland410hw-test
    [Documentation]    Play ${VIDEO_FILE} with ${TEST_PROGRAM} by using venus engine for hw decoding
    ${output}    Execute Command    ${TEST_PROGRAM} -v filesrc location=/home/linaro/${VIDEO_FILE} ! qtdemux name=d d. ! h264parse ! v4l2video0dec capture-io-mode=dmabuf ! videoconvert ! waylandsink d. ! queue ! aacparse ! avdec_aac ! audioconvert ! audio/x-raw,format=S16LE ! alsasink 2>/dev/null
    Log To Console        ${output}
    Should Not Contain    ${output}    A lot of buffers are being dropped
    Should Contain        ${output}    Execution ended after 0:02:00

