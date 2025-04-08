*** Settings ***
Documentation  This is a test suite for twilio API Testing
Resource  ../data/global_variables.robot
Resource    ../resources/page_actions.robot
Resource    ../resources/custom_actions.robot
Resource    ../resources/api_utils.robot
Suite Setup    Log    Starting Twilio API Mock Tests
Suite Teardown    Log    Finished Twilio API Mock Tests


*** Variables ***
# This will be passed from command line. Here just adding a default value to get rid of 'Undefined variable' error
${TEST_URL}    https://default-url.com

*** Test Cases ***

Get All Accounts (Mock)
    [Tags]    account
    ${endpoint}=  Set Variable    /2010-04-01/Accounts.json
    ${length}=  Get Count From Json  ${TEST_URL}  ${endpoint}
    Should Be True    ${length} > 0


Get Specific Account by SID (Mock)
    [Tags]    sid
    ${endpoint}=    Set Variable    /2010-04-01/Accounts/ACA8F7398B8db11a6c6b3cA6e96Bd0FdCe.json
    ${responseJson}=    Retrieve Response Json From Get    ${TEST_URL}    ${endpoint}
        ${length}=  Get Count From Json  ${TEST_URL}  ${endpoint}
        Should Be True    ${length} > 0

Mock SMS Send via Twilio
    [Tags]    post    sms
    ${endpoint}=  Set Variable  /Accounts/AC47e51EB6bAa26ab33eFBA0bDAf3Ba1D5/Messages.json
    ${payload}=    Create Dictionary    from=+1234567890    to=+1987654321    body=My Robot Framework SMS test!
    ${responseJson}=    Retrieve Response Json From Successful Post    ${TEST_URL}   ${endpoint}   ${payload}
    Dictionary Should Contain Key    ${responseJson}    sid
    Dictionary Should Contain Key    ${responseJson}    status






#Get Twilio Message List
#    [Tags]    get
#    ${json}=    Retrieve Response Json From Get    ${TEST_URL}    /messages
#    Log    ${json}
#
#
#Update SMS Status (PUT)
#    [Tags]     put
#    ${data}=    Create Dictionary    status=delivered
#    ${json}=    Retrieve Response Json From Put    ${TEST_URL}    /messages/12345    ${data}
#    Log    ${json}
#
#Delete a Message
#    [Tags]    twilio    delete
#    ${json}=    Retrieve Response Json From Delete    ${TEST_URL}    /messages/12345
#    Log    ${json}
#
#Negative Test - Invalid GET Endpoint
#    [Tags]    twilio    negative    get
#    ${error}=    Retrieve Error Response From Get    ${TEST_URL}    /invalid
#    Log    ${error}
#
#Negative Test - Invalid POST Payload
#    [Tags]    twilio    negative    post
#    ${body}=    Create Dictionary    invalidField=value
#    ${error}=    Retrieve Error Response From Post    ${TEST_URL}    /messages    ${body}
#    Log    ${error}
#
#Negative Test - Invalid PUT Payload
#    [Tags]    twilio    negative    put
#    ${data}=    Create Dictionary    wrong=field
#    ${error}=    Retrieve Error Response From Put    ${TEST_URL}    /messages/99999    ${data}
#    Log    ${error}

