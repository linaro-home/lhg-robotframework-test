*** Settings ***
Documentation     This test executing OPTEE "xtestx" on a remote machine
...               and getting the test result.
Suite Setup       Open Connection And Log In
Suite Teardown    Close All Connections
Resource          resource-xtest.robot

*** Test Cases ***
Execute-xtest-benchmark-test
    [Documentation]    Execute "xtest -t benchmark"
    Run Benchmark Test
