
*** Settings ***
Documentation    Suite description
Library  RequestsLibrary
Library  JSONLibrary
Library  json
Library  ../libs/custom_selenium_library.py
Resource  custom_actions.robot
Resource  page_actions.robot

*** Variables ***

*** Keywords ***


Retrieve Response Json From Successful Post
    [Arguments]    ${URL}    ${endpoint}    ${inputjson}=${None}
    ${headers}=    Create Dictionary    Content-Type=application/json
    Create Session    my_session    ${URL}
    ${Response}=    POST On Session    my_session    ${endpoint}    headers=${headers}    json=${inputjson}
    Log    ${Response.content}
    should be equal as strings  ${Response.status_code}  200
    Log    ${Response.json()}
    ${json}=    Set Variable    ${Response.json()}
    Log    ${json}
    Log    ${Response.json()}
    RETURN    ${json}


Retrieve Response Json From Unsuccessful Post
    [Arguments]    ${URL}    ${endpoint}    ${inputjson}=${None}
    ${headers}=    Create Dictionary    Content-Type=application/json
    #Create Session    my_session    ${URL}
    ${response_json}  ${status_code}=    Post Request With Error Handling    ${URL}    ${endpoint}    ${headers}    ${inputjson}
        Log    ${status_code}
        Log    ${response_json}
        Should Be Equal As Strings    ${status_code}    401
        RETURN    ${response_json}


Retrieve Response Json From Get
    [Arguments]  ${URL}  ${endpoint}  ${inputjson}=${None}
   # ${accesstoken}=  Get Json Param  ${APP_VERSION}  ${URL}  ${apipathfortoken}  access_token
    ${headers}       Create Dictionary  Content-Type=application/json
    create session  my_session  ${URL}
    ${Response} =  Get On Session  my_session  ${endpoint}  headers=${headers}  json=${inputjson}
    Log  ${Response.content}
    should be equal as strings  ${Response.status_code}  200
    Log  ${Response.json()}
    ${json} =  Set variable  ${Response.json()}
    Log  ${json}
    Log  ${Response.json()}
   RETURN  ${json}

Retrieve Response Json From Put
    [Arguments]    ${URL}    ${endpoint}    ${inputjson}
    ${headers}=    Create Dictionary    Content-Type=application/json
    Create Session    my_session    ${URL}
    ${response}=    PUT On Session    my_session    ${endpoint}    headers=${headers}    json=${inputjson}
    Log    ${response.content}
    Should Be Equal As Strings    ${response.status_code}    200
    ${json}=    Set Variable    ${response.json()}
    RETURN    ${json}

Retrieve Response Json From Delete
    [Arguments]    ${URL}    ${endpoint}
    Create Session    my_session    ${URL}
    ${response}=    DELETE On Session    my_session    ${endpoint}
    Log    ${response.status_code}
    Should Be Equal As Strings    ${response.status_code}    200
    ${json}=    Set Variable    ${response.json()}
    RETURN    ${json}

Retrieve Error Response From Get
    [Arguments]    ${URL}    ${endpoint}
    Create Session    my_session    ${URL}
    ${response}=    GET On Session    my_session    ${endpoint}
    Log    ${response.status_code}
    Should Not Be Equal As Strings    ${response.status_code}    200
    RETURN    ${response.json()}

Retrieve Error Response From Put
    [Arguments]    ${URL}    ${endpoint}    ${inputjson}
    ${headers}=    Create Dictionary    Content-Type=application/json
    Create Session    my_session    ${URL}
    ${response}=    PUT On Session    my_session    ${endpoint}    headers=${headers}    json=${inputjson}
    Log    ${response.status_code}
    Should Not Be Equal As Strings    ${response.status_code}    200
    RETURN    ${response.json()}

Retrieve Error Response From Post
    [Arguments]    ${URL}    ${endpoint}    ${inputjson}
    ${headers}=    Create Dictionary    Content-Type=application/json
    Create Session    my_session    ${URL}
    ${response}=    POST On Session    my_session    ${endpoint}    headers=${headers}    json=${inputjson}
    Log    ${response.status_code}
    Should Not Be Equal As Strings    ${response.status_code}    200
    RETURN    ${response.json()}


Get Count From Json
    [Arguments]  ${URL}   ${endpoint}
    ${json}=    Retrieve Response Json From Get    ${URL}   ${endpoint}
    ${lenjson}  Get Length  ${json}
    RETURN   ${lenjson}



 Get Key Value
     [Arguments]  ${data1}  ${list_len}  ${key1}  ${keyvalue1}  ${keyToRetrieve}  ${key2}=${emptystring}   ${keyvalue2}=${emptystring}
     #Log  ${data1[0]['emailAddress']}
     Log  ${data1}
     #Log  ${data1[0][${value}]}
     ${key2length}=  get length  ${key2}
     ${valueRetrieved}=   Set Variable   ${None}
 #    ${list_len2}=  Set Variable  ${list_len2} - 1
     FOR    ${INDEX}  IN RANGE  0  ${list_len}
         Log  ${INDEX}
         Log  ${data1[${INDEX}]}
         Log  ${data1[${INDEX}]}.get(${key1})
         ${value}=  Evaluate   ${data1[${INDEX}]}.get(${key1})
       #should be equal | ${value} | ${None}
         Log  ${keyvalue1}
         Log  ${key1}
         ${my_string1}=  Run Keyword If  "${value}" is not "${None}"  convert to string  ${data1[${INDEX}][${key1}]}
         ${valueRetrieved}=  Set Variable If  ${key2length} == 0 and '${my_string1}' == '${keyvalue1}'  ${data1[${INDEX}][${keyToRetrieve}]}
         Log  ${valueRetrieved}
         ${valueRetrieved}=  Run Keyword If   ${key2length} > 0  Get Key Value Further  ${data1}  ${INDEX}  ${my_string1}  ${keyvalue1}  ${key2}  ${keyvalue2}  ${keyToRetrieve}  ELSE  Set Variable  ${valueRetrieved}
         Log  ${valueRetrieved}
         Exit For Loop IF    "${valueRetrieved}" is not "${None}" or ${INDEX} == ${list_len} - 1
     END
     RETURN ${valueRetrieved}


 Get Key Value Further
     [Arguments]  ${data}  ${INDEX}  ${my_string1}  ${keyvalue1}  ${key2}  ${keyvalue2}  ${keyToRetrieve}
     Log  ${key2}
     Log  ${keyvalue2}
     Log  ${data[${INDEX}]}.get(${key2})
     ${value}=  Evaluate   ${data[${INDEX}]}.get(${key2})
     ${my_string2}=  Run Keyword If  '${value}' is not '${None}'  convert to string  ${data[${INDEX}][${key2}]}
     ${valueRetrieved}=  Run Keyword If  '${my_string1}' == '${keyvalue1}' and '${my_string2}' == '${keyvalue2}'  Set Variable  ${data[${INDEX}][${keyToRetrieve}]}
    RETURN ${valueRetrieved}