*** Settings ***
Documentation     This test executing "weston-simple-test" on a remote machine
...               and getting the test result.
Suite Setup       Open Connection And Log In
Suite Teardown    Close All Connections
Resource          resource.robot

*** Test Cases ***
Run-weston-simple-test-1
    [Documentation]    Run test "weston-simple-egl -f"
    Run Test-1
    Sleep       18s
    Terminate The Program
    ${output}       Read
    Log To Console    ${output}
    Should Contain      ${output}       frames in 5 seconds

Run-weston-simple-test-2
    [Documentation]    Run test "weston-simple-egl -f -b"
    Run Test-2
    Sleep       18s
    Terminate The Program
    ${output}       Read
    Log To Console    ${output}
    Should Contain      ${output}       frames in 5 seconds