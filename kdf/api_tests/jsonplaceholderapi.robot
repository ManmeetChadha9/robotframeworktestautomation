*** Settings ***
Documentation  This is a test suite for Qurasense GUI Testing
Resource  ../data/global_variables.robot
Resource    ../resources/page_actions.robot
Resource    ../resources/custom_actions.robot
Resource    ../resources/api_utils.robot
*** Variables ***


*** Test Cases ***
ROBOT_API Check Company
    #Get count of total companies
    ${endpoint}=    Set Variable    /companies
    ${companyCount}=  Get Count From Json  ${TEST_URL}  ${endpoint}
    # Adding a deliberate failure to check the ChatGPT provided suggestions
    Should Be Equal As Numbers    ${companyCount}    2

    # Get details of a specific company id and check the response
    ${company_id}=    Set Variable    1    # Example company ID
    ${endpoint}=    Set Variable    /companies/${company_id}
    ${responseJson}=    Retrieve Response Json From Get    ${TEST_URL}    ${endpoint}
    Should Be Equal As Numbers    ${responseJson}[id]    ${company_id}

ROBOT_API Successfull Login
    # Try logging in using the POST method.
     ${endpoint}=    Set Variable    /login
      &{payload}=    Create Dictionary
         ...    username=your_username
         ...    password=your_password
     ${response_json}=    Retrieve Response Json From Successful Post    ${TEST_URL}    ${endpoint}    ${payload}
     Should Be True    ${response_json}[success]

ROBOT_API UnSuccessfull Login
    # Try logging in using the POST method.
     ${endpoint}=    Set Variable    /login
      &{payload}=    Create Dictionary
         ...    username=user123
         ...    password=failed_password
     ${response_json}=    Retrieve Response Json From Unsuccessful Post    ${TEST_URL}    ${endpoint}    ${payload}
     Should Not Be True    ${response_json}[success]
     Should Contain    ${response_json}[error][code]    invalid_credentials









