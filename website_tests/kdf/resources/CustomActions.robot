*** Settings ***
Documentation  layer is for creating custom keywords
Library  DateTime
Library  RequestsLibrary
Library  Requests
Library  JSONLibrary
Library  OperatingSystem
Library  json
Library  Collections
Library  String
Library  ../libs/CustomSeleniumLibrary.py
Resource  PageActions.robot


*** Variables ***

*** Keywords ***

Todays Date
    ${date} =  Get Current Date  exclude_millis=TRUE
    Return    ${date}

Get Date After Adding Days
    [Arguments]  ${date}    ${number}  ${outputDateFormat}
    ${date} =  Add Time To Date	${date}	 ${number} days
    log to console  ${date}
    ${datetime} =	 Convert Date	${date}	 result_format=${outputDateFormat}
    Return    ${datetime}

Get Day From Date
    [Arguments]  ${dateandtime}
    ${datetime} =	Convert Date	${dateandtime}	 datetime
    Return    ${datetime.day}


Convert String To Date
    [Arguments]  ${dateandtime}  ${inputdateformat}
    ${datetime} =	Convert Date  ${dateandtime}  date_format=${inputdateformat}   exclude_millis=yes
    Return    ${datetime}

Get Date From Date
    [Arguments]  ${dateandtime}
    ${datetime} =	Convert Date  ${dateandtime}  result_format=%m/%d/%Y
    Return    ${datetime}

Get Time From Date
    [Arguments]  ${dateandtime}
    Log to console  ${dateandtime}
    ${datetime} =	Convert Date	${dateandtime}	 datetime
    Log to console  ${datetime}
    ${hours}=  set variable  ${datetime.hour}
    Log to console  ${hours}
    ${minutes}=  set variable  ${datetime.minute}
    Log to console  ${minutes}
    ${time}=    Run Keyword If  ${hours} >= 12  Get PM Time  ${hours}  ${minutes}  ELSE  Get AM Time  ${hours}  ${minutes}
    #${time}=    Set Variable If  ${hours} < 12  ${hours}:${minutes} AM
    #${time}=    Set Variable If  ${hours} == 12  ${hours}:${minutes} PM
    Log to console  ${time}
    Return    ${time}

Get PM Time
    [Arguments]  ${hourspm}  ${minutespm}
    ${hourspm}=  run keyword if  ${hourspm} > 12  Evaluate  ${hourspm}-12  ELSE  Set Variable  ${hourspm}
    ${timepm}=   Set variable  ${hourspm}:${minutespm} PM
    Return    ${timepm}

Get AM Time
    [Arguments]  ${hoursam}  ${minutesam}
    ${timeam}=   Set variable  ${hoursam}:${minutesam} AM
    Return    ${timeam}

Create Admin Authentication Endpoint
    [Arguments]  ${username}  ${password}  ${2facode}  ${channel}
#    ${account_api_oauthadmin}=  Set Variable  /account_api/oauth/token?username=${username}&password=${password}&grant_type=password&2fa_code=${2facode}&verify_channel=${channel}
    ${account_api_oauthadmin}  Create Dictionary   username=${username}  password=${password}   2fa_code=${2facode}   verify_channel=${channel}
    Set Global variable  ${account_api_oauthadmin}
    Log  ${account_api_oauthadmin}

Create Customer Authentication Endpoint
    [Arguments]  ${username}  ${password}  ${2facode}  ${channel}
    ${account_api_oauthcustomer}=  Create Dictionary   username=${username}  password=${password}   2fa_code=${2facode}   verify_channel=${channel}
#    Set Variable  /account_api/oauth/token?username=${username}&password=${password}&grant_type=password&2fa_code=${2facode}&verify_channel=${channel}
    log  ${account_api_oauthcustomer}
    Return  ${account_api_oauthcustomer}

Create Lab Authentication Endpoint
    [Arguments]  ${username}  ${password}  ${2facode}  ${channel}
    ${account_api_oauthlab}=   Create Dictionary   username=${username}  password=${password}   2fa_code=${2facode}   verify_channel=${channel}
#    Set Variable  /account_api/oauth/token?username=${username}&password=${password}&grant_type=password&2fa_code=${2facode}&verify_channel=${channel}
    Set Global variable  ${account_api_oauthlab}
    Log  ${account_api_oauthlab}

Create Logistics Authentication Endpoint
    [Arguments]  ${username}  ${password}  ${2facode}  ${channel}
    ${account_api_oauthlogistics}=   Create Dictionary   username=${username}  password=${password}   2fa_code=${2facode}   verify_channel=${channel}
#    Set Variable  /account_api/oauth/token?username=${username}&password=${password}&grant_type=password&2fa_code=${2facode}&verify_channel=${channel}
    Set Global variable  ${account_api_oauthlogistics}
    Log  ${account_api_oauthlogistics}

Create Doctor Authentication Endpoint
    [Arguments]  ${username}  ${password}  ${2facode}  ${channel}
    ${account_api_oauthdoctor}=  Create Dictionary   username=${username}  password=${password}   2fa_code=${2facode}   verify_channel=${channel}
#    Set Variable  /account_api/oauth/token?username=${username}&password=${password}&grant_type=password&2fa_code=${2facode}&verify_channel=${channel}
    Set Global variable  ${account_api_oauthdoctor}
    Log  ${account_api_oauthdoctor}

Create Fulfillment Authentication Endpoint
    [Arguments]  ${username}  ${password}  ${2facode}  ${channel}
    ${account_api_oauthfulfillment}=  Create Dictionary   username=${username}  password=${password}   2fa_code=${2facode}   verify_channel=${channel}
#    Set Variable  /account_api/oauth/token?username=${username}&password=${password}&grant_type=password&2fa_code=${2facode}&verify_channel=${channel}
    Set Global variable  ${account_api_oauthfulfillment}
    Log  ${account_api_oauthfulfillment}

Create Receiving Authentication Endpoint
    [Arguments]  ${username}  ${password}  ${2facode}  ${channel}
    ${account_api_oauthreceiving}=   Create Dictionary   username=${username}  password=${password}   2fa_code=${2facode}   verify_channel=${channel}
#    Set Variable  /account_api/oauth/token  #?username=${username}&password=${password}&grant_type=password&2fa_code=${2facode}&verify_channel=${channel}
    Set Global variable  ${account_api_oauthreceiving}
    Log  ${account_api_oauthreceiving}

Get Json Param
    [Arguments]  ${APP_VERSION}  ${URL}  ${apipath}  ${jsonparam}
    ${accept}=   Catenate    SEPARATOR=  application/v  ${APP_VERSION}  +json
    # ${headers}    Create Dictionary  Authorization=Basic bW9iaWxlOm1vYmlsZXNlY3JldA==  Content-Type=application/x-www-form-urlencoded  Accept=application/v4.0.0+json
    ${headers}    Create Dictionary  Authorization=Basic bW9iaWxlOm1vYmlsZXNlY3JldA==  Content-Type=application/x-www-form-urlencoded  Accept=${accept}
    Create Session  my_session  ${URL}
    ${Response} =  Post on Session  my_session  ${account_api_token}   data=${apipath}   headers=${headers}
    Log  ${Response.content}
    should be equal as strings  ${Response.status_code}  200
    ${json} =  Set variable  ${Response.json()}
    Log  ${json}
    Return  ${json['${jsonparam}']}


Get Json
    [Arguments]  ${APP_VERSION}  ${URL}  ${apipath}  ${apipathfortoken}  ${inputjson}=${None}
    ${accesstoken}=  Get Json Param  ${APP_VERSION}  ${URL}  ${apipathfortoken}  access_token
    ${headers}       Create Dictionary  Authorization=Bearer ${accesstoken}
    create session  my_session  ${URL}
    ${Response} =  Get On Session  my_session  ${apipath}  headers=${headers}  json=${inputjson}
    Log  ${Response.content}
    should be equal as strings  ${Response.status_code}  200
    Log  ${Response.json()}
    ${json} =  Set variable  ${Response.json()}
    Log  ${json}
    Log  ${Response.json()}
    Return  ${json}


Get Legal ID
    [Arguments]  ${APP_VERSION}  ${URL}  ${emailid}
    ${json}=  get json  ${APP_VERSION}  ${URL}  ${account_api_users}  ${account_api_oauthadmin}
    log to console  ${json}
    ${json_list}=   Set Variable   ${json['list']}
    log to console  ${json_list}
    ${list_len}=  get length  ${json_list}
    FOR    ${INDEX}  IN RANGE    0    ${list_len}
        ${data}=  Get From List  ${json_list}  ${INDEX}
        ${len}  Get Length  ${data['emailAddresses']}
        Log  ${data['emailAddresses']}
     #   ${legalid}=  run keyword if  ${len}>0  Get Key Value  ${data['emailAddresses'][0]}  'emailAddress'  ${emailid}  'legalEntityId'
        ${legalid}=  run keyword if  ${len}>0  Get Key Value  ${data['emailAddresses']}  ${len}  'emailAddress'  ${emailid}  'legalEntityId'
        Log  ${legalid}
        Exit For Loop IF    '${legalid}' is not '${None}'
    END
    Return  ${legalid}

Get Customer ID
     [Arguments]  ${APP_VERSION}  ${URL}  ${emailid}
     ${json}=  get json  ${APP_VERSION}  ${URL}  ${account_api_users}  ${account_api_oauthadmin}
     ${json_list}=   Set Variable   ${json['list']}
     ${list_len}=  get length  ${json_list}
     FOR    ${INDEX}  IN RANGE    0    ${list_len}
         ${data}=  Get From List  ${json_list}  ${INDEX}
         ${len}  Get Length  ${data['emailAddresses']}
         Log  ${data['emailAddresses']}
      #   ${legalid}=  run keyword if  ${len}>0  Get Key Value  ${data['emailAddresses'][0]}  'emailAddress'  ${emailid}  'legalEntityId'
         ${legalid}=  run keyword if  ${len}>0  Get Key Value  ${data['emailAddresses']}  ${len}  'emailAddress'  ${emailid}  'legalEntityId'
         Log  ${legalid}
         Exit For Loop IF    '${legalid}' is not '${None}'
     END
     Return  ${legalid}

Get Emailid
    [Arguments]  ${APP_VERSION}  ${URL}  ${legalid}
    ${json}=  get json  ${APP_VERSION}  ${URL}  ${account_api_users}  ${account_api_oauthadmin}
    ${json_list}=   Set Variable   ${json['list']}
    ${list_len}=  get length  ${json_list}
    FOR    ${INDEX}  IN RANGE    0    ${list_len}
        ${data}=  Get From List  ${json_list}  ${INDEX}
        ${len}  Get Length  ${data['emailAddresses']}
        Log  ${data['emailAddresses']}
     #  ${legalid}=  run keyword if  ${len}>0  Get Key Value  ${data['emailAddresses'][0]}  'emailAddress'  ${emailid}  'legalEntityId'
       ${emailid}=  run keyword if  ${len}>0  Get Key Value  ${data['emailAddresses']}  ${len}  'legalEntityId'  ${legalid}   'emailAddress'
        Log  ${emailid}
        Exit For Loop IF    '${emailid}' is not '${None}'
    END
    Return  ${emailid}

Get Human ID
    [Arguments]  ${APP_VERSION}  ${URL}  ${legalid}
    ${json}=  get json  ${APP_VERSION}  ${URL}  ${account_api_users}  ${account_api_oauthadmin}
    ${json_list}=   Set Variable   ${json['list']}
    ${list_len}=  get length  ${json_list}
    FOR    ${INDEX}  IN RANGE    0    ${list_len}
      ${data1}=  Get From List  ${json_list}  ${INDEX}
      ${data}=  create list
      append to list  ${data}  ${data1}
      ${len}  Get Length  ${data}
      Log  ${data}
      ${humanId}=  Get Key Value  ${data}  ${len}  'id'  ${legalid}   'humanId'
      Log  ${humanId}
      Exit For Loop IF    '${humanId}' is not '${None}'
    END
    Return  ${humanId}

Get Legal ID List
    [Arguments]  ${APP_VERSION}  ${URL}
    ${json}=  get json  ${APP_VERSION}  ${URL}  ${account_api_users}  ${account_api_oauthadmin}
    ${json_list}=   Set Variable   ${json['list']}
    ${list_len}=  get length  ${json_list}
    ${Id_list}=     create list
    FOR    ${INDEX}  IN RANGE    0    ${list_len}
     ${data}=  Get From List  ${json_list}  ${INDEX}
     ${legal_id}=  set variable  ${data['id']}
      Run keyword   Append To List  ${Id_list}  ${legal_id}
      Log     ${Id_list}
     END
     Return  ${Id_list}

Get Consent Id

    [Arguments]    ${APP_VERSION}   ${URL}  ${names}
    ${json}=    get json  ${APP_VERSION}  ${URL}  ${account_api_consent}  ${account_api_oauthadmin}
#    ${json_list}=   Set Variable   ${json['list']}
    ${list_len}=  get length  ${json}
#    : FOR    ${INDEX}  IN RANGE    0    ${list_len}
#     ${data}=  Get From List  ${json_list}  ${INDEX}
#     #\   ${len}  Get Length  ${data}
#     Log  ${data}
#     #\   ${legalid}=  run keyword if  ${len}>0  Get Key Value  ${data['emailAddresses'][0]}  'emailAddress'  ${emailid}  'legalEntityId'
    ${consentid}=  run keyword if  ${list_len}>0  Get Key Value  ${json}  ${list_len}  'name'  ${names}  'id'
    Log  ${consentid}
    Return  ${consentid}

Get Consent Version

    [Arguments]    ${APP_VERSION}   ${URL}  ${names}
    ${json}=    get json  ${APP_VERSION}  ${URL}  ${account_api_consent}  ${account_api_oauthadmin}
    ${list_len}=  get length  ${json}
    ${consentversion}=  run keyword if  ${list_len}>0  Get Key Value  ${json}  ${list_len}  'name'  ${names}  'version'
    Log  ${consentversion}
    ${consentversion}=  Set Variable  ${consentversion['version']}
    Return  ${consentversion}

Get Consent Content
    [Arguments]    ${APP_VERSION}   ${URL}  ${names}
    ${json}=    get json  ${APP_VERSION}  ${URL}  ${account_api_consent}  ${account_api_oauthadmin}
    ${list_len}=  get length  ${json}
    ${consentversion}=  run keyword if  ${list_len}>0  Get Key Value  ${json}  ${list_len}  'name'  ${names}  'version'
    Log  ${consentversion}
    ${consent_content}=  Set Variable  ${consentversion['content']}
    Log  ${consent_content}
    Return  ${consent_content}


Change Consent Data
    [Arguments]      ${APP_VERSION}   ${URL}  ${names}  ${forceupdate}  ${versionchange}
    ${adminaccesstoken}=  Get Json Param  ${APP_VERSION}  ${URL}  ${account_api_oauthadmin}  access_token
    ${headers}  Create Dictionary  Authorization=Bearer ${adminaccesstoken}  Content-Type=application/json
    ${consentId}=  Get Consent Id  ${APP_VERSION}   ${URL}  ${names}
    ${account_api_consent_change}=  Set Variable  /account_api/consentForm/${consentId}/version?
    ${verion}=  Get Consent Version  ${APP_VERSION}   ${URL}  ${names}
    ${content}=  Get Consent Content  ${APP_VERSION}   ${URL}  ${names}
    ${newVersion}=  Evaluate  ${verion} + ${versionchange}
    ${createdjson}=  Prepare Json   version=${newVersion}  content=${content}  forceUpdate=${forceupdate}
    ${createdjson}=  Replace string  ${createdjson}  "${forceupdate}"  ${forceupdate}
    Log  ${createdjson}
    ${Response} =  Post On Session  my_session  ${account_api_consent_change}  headers=${headers}  data=${createdjson}
    Log  ${Response.content}
    should be equal as strings  ${Response.status_code}  200
    Return  ${Response.text}







Get Wizard ID
    [Arguments]    ${APP_VERSION}   ${URL}  ${names}
    ${json}=    get json  ${APP_VERSION}  ${URL}  ${product_api_wizards}  ${account_api_oauthadmin}
    ${json_list}=   Set Variable   ${json['list']}
    ${list_len}=  get length  ${json_list}
#    : FOR    ${INDEX}  IN RANGE    0    ${list_len}
#     ${data}=  Get From List  ${json_list}  ${INDEX}
#     #\   ${len}  Get Length  ${data}
#     Log  ${data}
#     #\   ${legalid}=  run keyword if  ${len}>0  Get Key Value  ${data['emailAddresses'][0]}  'emailAddress'  ${emailid}  'legalEntityId'
    ${wizid}=  run keyword if  ${list_len}>0  Get Key Value  ${json_list}  ${list_len}  'name'  ${names}  'id'
    Log  ${wizid}
    Return  ${wizid}

Get Upcoming Event Value
    [Arguments]  ${APP_Version}  ${URL}   ${upcomingEventId}   ${seqNumValue}   ${getvalue}
    ${json}=    get json  ${APP_Version}    ${URL}   ${communication_api_upcomingmetas}     ${account_api_oauthadmin}
    ${lenjson}  Get Length  ${json}
    #${json_list}=   Set Variable   ${json['list']}
#    ${list_len}=  get length  ${json}
#    : FOR    ${INDEX}  IN RANGE    0    ${list_len}
#     ${data}=  Get From List  ${json}  ${INDEX}
#     ${len}  Get Length  ${data}
#     Log  ${data}
#     #\   ${legalid}=  run keyword if  ${len}>0  Get Key Value  ${data['emailAddresses'][0]}  'emailAddress'  ${emailid}  'legalEntityId'
#     ${upcomingid}=  run keyword if  ${len}>0  Get Key Value  ${data}  ${len}  'upcomingEventType'  ${upcomingEventId}   'id'    'seqNum'    ${seqNumValue}
#     Log  ${upcomingid}
#     Exit For Loop IF    '${upcomingid}' is not '${None}'
     ${upcomingid}=  run keyword if  ${lenjson}>0  Get Key Value  ${json}  ${lenjson}  'upcomingEventType'  ${upcomingEventId}   '${getvalue}'    'seqNum'    ${seqNumValue}
     Log  ${upcomingid}
     Return    ${upcomingid}


Register QPad
    [Arguments]  ${APP_VERSION}  ${URL}  ${account_api_oauthcustomer}  ${padid}  ${emailid}
    ${legalid}=  Get Legal ID  ${APP_VERSION}  ${URL}  ${emailid}
    ${product_api_register_qpad}=  Set Variable    /product_api/kit/qpad/${padid}/customer/${legalid}/register
    ${customeraccesstoken}=  Get Json Param  ${APP_VERSION}  ${URL}  ${account_api_oauthcustomer}  access_token
    ${headers}  Create Dictionary  Authorization=Bearer ${customeraccesstoken}
    create session  my_session  ${URL}
    ${Response} =  Post On Session  my_session  ${product_api_register_qpad}  headers=${headers}
    Log  ${Response.content}
    should be equal as strings  ${Response.status_code}  200
    Log  ${Response}


Ship Kit
    [Arguments]  ${APP_VERSION}  ${URL}  ${account_api_oauthcustomer}  ${kitid}
    ${kit_id}=  Get Kit ID  ${APP_VERSION}  ${URL}  ${kitid}  IN_USE
    ${product_api_kit_ship}=  Set Variable    product_api/kit/${kit_id}/confirmShipment
    ${customeraccesstoken}=  Get Json Param  ${APP_VERSION}  ${URL}  ${account_api_oauthcustomer}  access_token
    ${headers}  Create Dictionary  Authorization=Bearer ${customeraccesstoken}
    create session  my_session  ${URL}
    ${Response} =  Post On Session  my_session  ${product_api_kit_ship}  headers=${headers}
    Log  ${Response.content}
    should be equal as strings  ${Response.status_code}  200
    Log  ${Response}

Get Kit ID
    [Arguments]  ${APP_VERSION}  ${URL}  ${kitid}  ${kitstatus}
    ${product_api_kits_status}=   Catenate    SEPARATOR=  ${product_api_kits}  ${kitstatus}
    ${json}=  get json  ${APP_VERSION}  ${URL}  ${product_api_kits_status}  ${account_api_oauthlogistics}
    ${json_list}=   Set Variable   ${json['list']}
    Log  ${json_list}
    ${list_len}=  get length  ${json_list}
    FOR    ${INDEX}  IN RANGE    0    ${list_len}
     ${data}=  Get From List  ${json_list}  ${INDEX}
     ${id}=  run keyword if  '${data['hid']}' == '${kitid}'  Set Variable   ${data['id']}
     Exit For Loop IF    '${id}' is not '${None}'
    END
    Return  ${id}


Get Lab ID
    [Arguments]  ${APP_VERSION}  ${URL}  ${name}  ${organizationType}
    ${json}=  get json  ${APP_VERSION}  ${URL}  ${account_api_organisation}  ${account_api_oauthadmin}
    Log  ${json}
    ${lenjson}=  get length  ${json}
    ${labid}=  run keyword if  ${lenjson}>0  Get Key Value  ${json}  ${lenjson}  'name'  ${name}   'id'  'organizationType'  ${organizationType}
    Log  ${labid}
    Return    ${labid}




Get Kits Count
    [Arguments]  ${APP_VERSION}  ${URL}  ${kitstatus}
    ${product_api_kits_status}=   Catenate    SEPARATOR=  ${product_api_kits}  ${kitstatus}
    ${json}=  get json  ${APP_VERSION}  ${URL}  ${product_api_kits_status}  ${account_api_oauthlogistics}
    ${kits_total}=   Set Variable   ${json['total']}
    Return  ${kits_total}

Get Lab Kits Count
    [Arguments]  ${APP_VERSION}  ${URL}  ${AnalysisStatus}  ${labid}
    ${product_api_analysisRequestStatusType}=   Catenate    SEPARATOR=  ${product_api_analysisRequestStatusType}  ${AnalysisStatus}&labId=${labid}
    ${json}=  get json  ${APP_VERSION}  ${URL}  ${product_api_analysisRequestStatusType}  ${account_api_oauthlab}
    ${kits_total}=   Set Variable   ${json['total']}
    Return  ${kits_total}

Get Analysis Request ID
    [Arguments]  ${APP_VERSION}  ${URL}  ${kitid}  ${kitStatus}
    ${kitid}=  Get Kit ID  ${APP_VERSION}  ${URL}  ${kitid}  ${kitStatus}
    ${product_api_analysisRequestKit}=   Catenate    SEPARATOR=  ${product_api_analysisRequestKit}  ${kitid}
    ${json}=  get json  ${APP_VERSION}  ${URL}  ${product_api_analysisRequestKit}  ${account_api_oauthlab}
    #${json_list}=   Set Variable   ${json['list']}
    #Log  ${json_list}
    log  ${json['id']}
    ${id}=  Set Variable  ${json['id']}
    Return  ${id}

Get Order ID
    [Arguments]  ${APP_VERSION}  ${URL}  ${emailid}  ${orderstatus}
    ${legalid}=  Get Legal ID  ${APP_VERSION}  ${URL}  ${emailid}
    ${product_api_customer_orders}=  Set Variable    /product_api/orders/customer/${legalid}?limit=30&offset=0&sort=-createTime
    ${json}=  get json  ${APP_VERSION}  ${URL}  ${product_api_customer_orders}  ${account_api_oauthlogistics}
    ${json_list}=   Set Variable   ${json['list']}
    Log  ${json_list}
    ${list_len}=  get length  ${json_list}
    FOR    ${INDEX}  IN RANGE    0    ${list_len}
     ${data}=  Get From List  ${json_list}  ${INDEX}
     Log  ${data['status']['type']}
     ${order-id}=  Set Variable If  '${data['status']['type']}' == ${orderstatus}  ${data['id']}
     Exit For Loop IF    '${order-id}' is not '${None}'
    END
    Return  ${order-id}

Get Order Line ID
    [Arguments]  ${APP_VERSION}  ${URL}  ${orderid}
    ${product_api_customer_orderlines}=  Set Variable    /product_api/order/${orderid}?limit=10&offset=0&sort=-createTime
    ${json}=  get json  ${APP_VERSION}  ${URL}  ${product_api_customer_orderlines}  ${account_api_oauthlogistics}
    ${dataorderlines}=  Set Variable  ${json['orderLines']}
    @{OrderLinelist}=  Create List
    ${list_len}=  get length  ${dataorderlines}
    FOR    ${INDEX}  IN RANGE    0    ${list_len}
     ${data}=  Get From List  ${dataorderlines}  ${INDEX}
     Log  ${data['id']}
      ${orderline-id}=  Set Variable  ${data['id']}
      Run keyword   Append To List  ${OrderLinelist}  ${orderline-id}
      Log  ${OrderLinelist}
    END
     Return  @{OrderLinelist}



Create Kit Import XL Rows
    [Arguments]  ${APP_VERSION}  ${URL}  ${KitID}  ${LotNumber}  ${Pad1ID}  ${Pad1LotNumber}  ${Pad2ID}  ${Pad2LotNumber}  ${product}  ${orderid}  ${LabTrackNumberID}
    ${storeProductTypeId}=  Get Product Type ID  ${APP_VERSION}  ${URL}  ${product}
    ${Customertracknumber}=  Set Variable  ${EMPTY}
    #${LabTrackNumber}=  Set Variable  ${LabTrackNumberID}
    ${Returntracknumber}=  Set Variable  ${EMPTY}
    ${ReceivalDateTime}=  Todays Date
    ${ExpirationDateTime} =  Add Time To Date	 ${ReceivalDateTime}  365 days
    ${ExpirationDate}=  Convert Date	 ${ExpirationDateTime}	 result_format=%d/%m/%Y
    @{OrderLinelist}=  Get Order Line ID  ${APP_VERSION}  ${URL}  ${orderid}
    ${len}=  get length  ${OrderLinelist}
    ${kitIdlist}=  Set Variable  ${EMPTY}
    Log   ${OrderLinelist}
    @{listoflist}=  Create List
    @{listForJson}=  Create List
    FOR    ${INDEX}  IN RANGE    0    ${len}
     ${Kit}=   run keyword if  ${len}>1  Catenate    SEPARATOR=-  ${KitID}  ${INDEX}  ELSE  Set Variable  ${KitID}
     ${Pad1}=   run keyword if  ${len}>1  Catenate    SEPARATOR=-  ${Pad1ID}  ${INDEX}  ELSE  Set Variable  ${Pad1ID}
     ${Pad2}=   run keyword if  ${len}>1  Catenate    SEPARATOR=-  ${Pad2ID}  ${INDEX}  ELSE  Set Variable  ${Pad2ID}
     ${LabTrackNumber}=   run keyword if  ${len}>1  Catenate    SEPARATOR=  ${LabTrackNumberID}  ${INDEX}  ELSE  Set Variable  ${LabTrackNumberID}
    #\  @{list} =	Create List	${Kit}  ${LotNumber}  ${ExpirationDate}  ${Pad1}  ${Pad1LotNumber}  ${Pad2}  ${Pad2LotNumber}  ${trial}  ${product}  ${OrderLinelist}[${INDEX}]  ${orderid}
     @{list} =	Create List	${Kit}  ${LotNumber}  ${ExpirationDate}  ${Pad1}  ${Pad1LotNumber}  ${Pad2}  ${Pad2LotNumber}  ${product}  ${OrderLinelist}[${INDEX}]  ${orderid}  ${Customertracknumber}  ${LabTrackNumber}  ${Returntracknumber}
     Log  ${list}
     Append To List  ${listoflist}  ${list}
     Log  ${listoflist}
     ${kitIdeq}=  Catenate    SEPARATOR=  kitId=  ${Kit}
     ${kitIdlist}=  Run Keyword If  "${kitIdlist}"!="${EMPTY}"  Catenate  SEPARATOR=&  ${kitIdlist}  ${kitIdeq}  ELSE  Set Variable  ${kitIdeq}
     Append To List  ${listForJson}  ${Kit}=${storeProductTypeId}
    END
    ${kitimportfile}=   Catenate    SEPARATOR=  data/  ${kitimportfilename}
    ${kitOrderJson}=  Prepare Json  @{listForJson}
    Write_To_KitImportXL  ${listoflist}  ${kitimportfile}
    Return  ${kitIdlist}  ${kitOrderJson}

Import Kits to Stock
    [Arguments]  ${APP_VERSION}  ${URL}
    ${logisticsaccesstoken}=  Get Json Param  ${APP_VERSION}  ${URL}  ${account_api_oauthlogistics}  access_token
    ${headers}  Create Dictionary  Authorization=Bearer ${logisticsaccesstoken}
    ${product_api_importkits}=   Catenate    SEPARATOR=  ${product_api_importkits}  ${kitimportfilename}
    ${URL}=   Catenate    SEPARATOR=  ${URL}  ${product_api_importkits}
    ${kitimportfile}=   Catenate    SEPARATOR=  data/  ${kitimportfilename}
    ${Response}=  Post Form Data Request  ${URL}  ${headers}  ${kitimportfile}
    Log  ${Response}
    should be equal as strings  ${Response.status_code}  200

Fulfill Order
    [Arguments]  ${APP_VERSION}  ${URL}  ${orderid}  ${kitIdsConcatenated}  ${kitOrderJson}
    ${accept}=   Catenate    SEPARATOR=  application/v  ${APP_VERSION}  +json
    ${logisticsaccesstoken}=  Get Json Param  ${APP_VERSION}  ${URL}  ${account_api_oauthlogistics}  access_token
    ${headers}  Create Dictionary  Authorization=Bearer ${logisticsaccesstoken}  Content-Type=application/json    Accept=${accept}
    ${product_api_validateorderwithkits}=  Set Variable  /product_api/order/${orderid}/validateKits?${kitIdsConcatenated}
    ${account_api_fulfillorder}=  Set Variable  /product_api/order/${orderid}/fulfilled?
   # ${kitIdsConcatenated}=  Catenate  SEPARATOR=  validateKits?  ${kitIdsConcatenated}
   # ${product_api_validateorderwithkits}=  Catenate  SEPARATOR=/  ${product_api_validateorderwithkits}  ${orderid}
   # ${product_api_validateorderwithkits}=  Catenate  SEPARATOR=/  ${product_api_validateorderwithkits}  ${kitIdsConcatenated}
    create session  my_session  ${URL}
    ${Response} =  Post On Session  my_session  ${product_api_validateorderwithkits}  headers=${headers}
    Log  ${Response}
    should be equal as strings  ${Response.status_code}  200
    Log  ${kitOrderJson}
    ${Response} =  Post On Session  my_session  ${account_api_fulfillorder}  headers=${headers}  data=${kitOrderJson}
    Log  ${Response}
    should be equal as strings  ${Response.status_code}  200

Export Assay Result XL For Kit
    [Arguments]  ${APP_VERSION}  ${URL}  ${kitID}  ${kitStatus}
    ${analyisRequestID}=  Get Analysis Request ID  ${APP_VERSION}  ${URL}  ${kitID}  ${kitStatus}
    ${accept}=   Catenate    SEPARATOR=  application/v  ${APP_VERSION}  +json
    ${labaccesstoken}=  Get Json Param  ${APP_VERSION}  ${URL}  ${account_api_oauthlab}  access_token
    ${headers}  Create Dictionary  Authorization=Bearer ${labaccesstoken}  Content-Type=application/json    Accept=${accept}
    create session  my_session  ${URL}
    @{analyisRequestIDList}=  Create List
    Log  ${analyisRequestIDList}
    Append to List  ${analyisRequestIDList}  ${analyisRequestID}
    ${Response}=  Post On Session  my_session  ${product_api_createassayresultstemplate}  data=${analyisRequestIDList}  headers=${headers}
    Should Be Equal As Numbers     ${response.status_code}    200
    ${todaysdate}=  Todays Date
    ${todaysdate}=  Get Day From Date  ${todaysdate}
    ${assayresultfilename}=  Catenate  SEPARATOR=  ${todaysdate}  ${assayresultfilename}
    Log  ${Response.content}
    Create Binary File     ${EXECDIR}/data/${assayresultfilename}     ${Response.content}
    Return  ${EXECDIR}/data/${assayresultfilename}





Create Assay Result Import XL Rows
    [Arguments]  ${APP_VERSION}  ${URL}  ${lastName}  ${firstName}  ${humanId}   ${DOB}  ${Age}  ${Gender}   ${KitID}  ${DeviceID}   ${InternalLabID}  ${DayOfPeriod}  ${CollectionDate}   ${CollectionDate}  ${ReceivalDate}  ${Assay}  ${Status}  ${SpecimenType}  ${Result}  ${Unit}  ${Failure}  ${Comments}
    ${DateTimeanalysed}=  Add Time to Date   ${ReceivalDate}   15 minute   exclude_millis=yes
    log to console  ${DateTimeanalysed}
    ${Dateanalysed}=  Convert Date  ${DateTimeanalysed}   result_format=%m/%d/%Y
    ${AnalyzebeforeDateTime} =  Add Time To Date	 ${ReceivalDate}  2 days
    ${AnalyzebeforeDate}=  Convert Date	 ${AnalyzebeforeDateTime}	 result_format=%m/%d/%Y %I:%M:%S
    log to console  ${AnalyzebeforeDate}
    ${Timeanalysed}=  Get substring  ${DateTimeanalysed}   11
    log to console  ${Timeanalysed}
    ${ReceivalDate}=  Convert Date  ${ReceivalDate}  result_format=%m/%d/%Y %I:%M:%S
    ${CollectionDate}=  Convert Date  ${CollectionDate}  result_format=%m/%d/%Y %I:%M:%S
    @{list} =	Create List  ${lastName}  ${firstName}  ${humanId}   ${DOB}  ${Age}	${Gender}  ${KitID}  ${DeviceID}  ${InternalLabID}  ${DayOfPeriod}  ${CollectionDate}   ${CollectionDate}  ${ReceivalDate}  ${Assay}  ${Status}  ${AnalyzebeforeDate}  ${Dateanalysed}  ${Timeanalysed}  ${SpecimenType}  ${Result}  ${Unit}  ${Failure}  ${Comments}
    log to console  ${list}
    ${assayresultfile}=   Catenate    SEPARATOR=  data/  ${assayresultfilename}
    Write_To_AssayResultXL  ${list}  ${assayresultfile}

Verify Text In Excel
    [Arguments]   ${file}  ${textToSearch}
    ${readResult}=    Read_XL  ${file}  ${textToSearch}
    should be equal as strings  ${readResult}  true

Get Data From Excel
    [Arguments]   ${file}    ${Column_Data}
    ${readResult}=  Fetch XL  ${file}    ${Column_Data}
    Return  ${readResult}

Verify Text Not In Excel
    [Arguments]   ${file}  ${textToSearch}
    ${readResult}=    Read_XL  ${file}  ${textToSearch}
    should be equal as strings  ${readResult}  false

Import Assay Results
    [Arguments]  ${APP_VERSION}  ${URL}
    ${labaccesstoken}=  Get Json Param  ${APP_VERSION}  ${URL}  ${account_api_oauthlab}  access_token
    ${headers}  Create Dictionary  Authorization=Bearer ${labaccesstoken}
    ${product_api_assayresults}=   Catenate    SEPARATOR=  ${product_api_assayresults}  ${assayresultfilename}
    ${URL}=   Catenate    SEPARATOR=  ${URL}  ${product_api_assayresults}
    ${assayresultfile}=   Catenate    SEPARATOR=  data/  ${assayresultfilename}
    #${Response}=  Post On Session  ${URL}  ${headers}  ${assayresultfile}
    ${Response}=  Post Form Data Request  ${URL}  ${headers}  ${assayresultfile}
    Log  ${Response}
    should be equal as strings  ${Response.status_code}  200
    Log  ${Response.text}
    ${AssayResultSpreadsheetid}=  Get Substring  ${Response.text}  0  8
    Return  ${AssayResultSpreadsheetid}


Ship Order
    [Arguments]  ${APP_VERSION}  ${URL}  ${orderid}
    ${logisticsaccesstoken}=  Get Json Param  ${APP_VERSION}  ${URL}  ${account_api_oauthlogistics}  access_token
    ${headers}  Create Dictionary  Authorization=Bearer ${logisticsaccesstoken}
    ${product_api_shipkits}=   Catenate    SEPARATOR=  ${product_api_shipkits}  ${orderid}
    create session  my_session  ${URL}
    ${Response} =  Post On Session  my_session  ${product_api_shipkits}  headers=${headers}
    Log  ${Response.content}
    should be equal as strings  ${Response.status_code}  200
    Return  ${Response.text}



Post Form Data Request
     [Arguments]  ${URL}  ${headers}  ${file}
     ${Response} =  Post File  ${URL}  ${headers}  ${file}
     Return  ${Response}


Get Product Type ID
    [Arguments]  ${APP_VERSION}  ${URL}  ${producttype}
    ${json_list}=  get json  ${APP_VERSION}  ${URL}  ${product_api_bundle}  ${account_api_oauthadmin}
    ${list_len}=  get length  ${json_list}
    FOR    ${INDEX}  IN RANGE    0    ${list_len}
    ${data}=  Get From List  ${json_list}  ${INDEX}
    Log  ${data['id']}
    Log  ${data['name']}
    Log  ${producttype}
    ${producttype_id}=  Set Variable If   "${data['name']}" == "${producttype}"   ${data['id']}
    Exit For Loop IF    '${producttype_id}' is not '${None}'
    END
    log  ${producttype_id}
    Return  ${producttype_id}

Get Bundle Kit Type ID
    [Arguments]  ${APP_VERSION}  ${URL}  ${producttype}
    ${json_list}=  get json  ${APP_VERSION}  ${URL}  ${product_api_bundle}  ${account_api_oauthadmin}
    ${list_len}=  get length  ${json_list}
    FOR    ${INDEX}  IN RANGE    0    ${list_len}
    ${data}=  Get From List  ${json_list}  ${INDEX}
    Log  ${data['id']}
    Log  ${data['name']}
    Log  ${producttype}
    ${producttype_id}=  Set Variable If  "${data['name']}" == "${producttype}"  ${data['kits']}
    Exit For Loop IF    ${producttype_id} is not ${None}
    END
    ${bundleKIt}=  set variable  ${producttype_id[0]}
    ${bundleKItId}=  set variable  ${bundleKIt['id']}
    log  ${bundleKItId}
    Return  ${bundleKItId}


Create Order
    [Arguments]  ${APP_VERSION}  ${URL}  ${emailid}  ${producttype}  ${noofkits}
    ${legalid}=  Get Legal ID  ${APP_VERSION}  ${URL}  ${emailid}
    ${storeProductTypeId}=  Get Product Type ID  ${APP_VERSION}  ${URL}  ${producttype}
    ${kitTypeid}=  Get Bundle Kit Type ID  ${APP_VERSION}  ${URL}  ${producttype}
    ${doctoraccesstoken}=  Get Json Param  ${APP_VERSION}  ${URL}  ${account_api_oauthdoctor}  access_token
    ${headers}  Create Dictionary  Authorization=Bearer ${doctoraccesstoken}  Content-Type=application/json

    @{kitlineslist}=  Create List
    ${kitlinejson}=  Prepare Json  bundleKitId=${kitTypeid}   fulfillByQvin=true
    Log  ${kitlinejson}
    Append to List  ${kitlineslist}  ${kitlinejson}
    Log  ${kitlineslist}
    Log  ${kitlineslist}

    @{orderlineslist}=  Create List
    FOR     ${INDEX}  IN RANGE    0    ${noofkits}
      ${orderlinejson}=  Prepare Json  bundleId=${storeProductTypeId}   @type=bundle   kits=${kitlineslist}
      Log  ${orderlinejson}
      ${str} =	Remove String	 ${orderlinejson}	 '
      ${str} =	Replace String	 ${str}	 "[{  [{
      ${str} =	Replace String	 ${str}	 }]"  }]
      ${orderlinefinaljson} =	Translate Char In String  ${str}  92
      Append to List  ${orderlineslist}  ${orderlinefinaljson}
      Log  ${orderlineslist}
     END
     Log  ${orderlineslist}

    ${createorderjson}=  Prepare Json  customerId=${legalid}  orderLines=${orderlineslist}
    #@{orderlineslist}
    ${str} =	Remove String	 ${createorderjson}	 '
    ${str} =	Replace String	 ${str}	 "[{  [{
    ${str} =	Replace String	 ${str}	 }]"  }]
    ${createorderfinaljson} =	Translate Char In String  ${str}  92
    Log  ${createorderfinaljson}
    ${Response} =  Post On Session  my_session  ${product_api_createorder}  headers=${headers}  data=${createorderfinaljson}
    Log  ${Response.content}
    should be equal as strings  ${Response.status_code}  200
    Return  ${Response.text}


Validate Address
    [Arguments]    ${APP_VERSION}  ${URL}   ${emailid}  ${street}   ${ZIP}  ${State}    ${Country}  ${City}  ${typeofAddress}
    ${legalid}=    Get Legal ID  ${APP_VERSION}  ${URL}  ${emailid}
    ${doctoraccesstoken}=  Get Json Param  ${APP_VERSION}  ${URL}  ${account_api_oauthdoctor}  access_token
    ${headers}  Create Dictionary  Authorization=Bearer ${doctoraccesstoken}  Content-Type=application/json
    ${addressjson}=  Prepare Json  id=${emptystring}  addressLine=${street}  state=${State}   country=${Country}  zip=${ZIP}   city=${City}    type=${typeofAddress}   legalEntityId=${legalid}    isPrimary=false
    ${Response} =  Post On Session  my_session  ${account_api_validateaddress}  headers=${headers}  data=${addressjson}
    Log  ${Response.content}
    should be equal as strings  ${Response.status_code}  200
    Return  ${Response.text}


Shipment Order
    [Arguments]    ${APP_VERSION}  ${URL}   ${orderid}   ${address}
    Log  ${address}
    ${data}=    Evaluate    json.loads($address)    json
    ${address}=   Set Variable  ${data['address']}
    ${doctoraccesstoken}=  Get Json Param  ${APP_VERSION}  ${URL}  ${account_api_oauthdoctor}  access_token
    ${headers}  Create Dictionary  Authorization=Bearer ${doctoraccesstoken}  Content-Type=application/json
    ${shipment}=    Prepare Json  shipmentType=TO_CUSTOMER  orderId=${orderid}  status={"type":"CREATED"}   shippingAddress=${address}
    ${str}=   Remove String  ${shipment}  \\
    ${str}=   Replace String  ${str}  '  "
    ${str}=   Replace String  ${str}  }"  }
    ${str}=   Replace String  ${str}  False  "False"
    ${shipmentfinal}=  Replace String  ${str}  "{  {
    Log  ${shipmentfinal}
    ${Response} =  Post On Session  my_session  ${account_api_shipment}  headers=${headers}  data=${shipmentfinal}
    Log  ${Response.content}
    should be equal as strings  ${Response.status_code}  200
    Return  ${Response.text}

Get Order Number
    [Arguments]    ${APP_VERSION}  ${URL}   ${orderid}
    ${product_api_ordernumber}=   Catenate    SEPARATOR=  ${product_api_orderNumber}  ${orderid}
    ${json}=  get json  ${APP_VERSION}  ${URL}  ${product_api_ordernumber}  ${account_api_oauthfulfillment}
    log   ${json['orderNumber']}
    Return  ${json['orderNumber']}

Get Tracking Number
    [Arguments]    ${APP_VERSION}  ${URL}   ${kitid}
    ${product_api_kit}=   Catenate    SEPARATOR=  ${product_api_kitdetails}  ${kitid}
    ${json}=  get json  ${APP_VERSION}  ${URL}  ${product_api_kit}  ${account_api_oauthlogistics}
    log   ${json['labTrackNum']}
    Return  ${json['labTrackNum']}




Prepare Json
    [Arguments]    @{args}
    ${req_dict}    Create Dictionary
    FOR     ${pair}    IN     @{args}
      ${key}    ${value}=     Split String    ${pair}    =
      Set To Dictionary    ${req_dict}    ${key}=${value}
      Log  ${req_dict}
    ${req_json}    Json.Dumps    ${req_dict}
    END
    Return    ${req_json}


Get Pad Id
    [Arguments]  ${APP_VERSION}  ${URL}  ${padid}  ${kitstatus}
    ${product_api_kits_status}=   Catenate    SEPARATOR=  ${product_api_kits}  ${kitstatus}
    ${json}=  get json  ${APP_VERSION}  ${URL}  ${product_api_kits_status}  ${account_api_oauthlogistics}
    ${json_list}=   Set Variable   ${json['list']}
    Log  ${json_list}
    ${list_len}=  get length  ${json_list}
    FOR    ${INDEX}  IN RANGE    0    ${list_len}
     ${data}=  Get From List  ${json_list}  ${INDEX}
     ${len}  Get Length  ${data['pads']}
     #\   ${pad-id}=  run keyword if  ${len}>0  Get Key Value  ${data['pads'][0]}  'padId'  ${padid}  'id'
     ${pad-id}=  run keyword if  ${len}>0  Get Key Value  ${data['pads']}  ${len}  'hid'  ${padid}  'id'
     Log  ${pad-id}
     Exit For Loop IF    '${pad-id}' is not '${None}'
    END
    Return  ${pad-id}


Get Kit Status Create Time
    [Arguments]  ${APP_VERSION}  ${URL}  ${kitid}  ${kitstatus}
    ${product_api_kits_status}=   Catenate    SEPARATOR=  ${product_api_kits}  ${kitstatus}
    ${json}=  get json  ${APP_VERSION}  ${URL}  ${product_api_kits_status}  ${account_api_oauthlogistics}
    ${json_list}=   Set Variable   ${json['list']}
    Log  ${json_list}
    ${list_len}=  get length  ${json_list}
    FOR    ${INDEX}  IN RANGE    0    ${list_len}
     ${data}=  Get From List  ${json_list}  ${INDEX}
     ${lenstatusHistory}=  run keyword if  '${data['kitId']}' == '${kitid}'  Get Length  ${data['statusHistory']}  ELSE  Set Variable  0
     Log  ${lenstatusHistory}
     ${createTime}=  run keyword if  ${lenstatusHistory}>0  Get Key Value  ${data['statusHistory']}  ${lenstatusHistory}  'type'  ${kitstatus}  'createTime'
     Log  ${createTime}
     Exit For Loop IF    '${createTime}' is not '${None}'
    END
    Return  ${createTime}


Get Pad Status Create Time
    [Arguments]  ${APP_VERSION}  ${URL}  ${kitid}  ${kitstatus}  ${padid}  ${padstatus}
    ${product_api_kits_status}=   Catenate    SEPARATOR=  ${product_api_kits}  ${kitstatus}
    ${json}=  get json  ${APP_VERSION}  ${URL}  ${product_api_kits_status}  ${account_api_oauthlogistics}
    ${json_list}=   Set Variable   ${json['list']}
    Log  ${json_list}
    ${list_len}=  get length  ${json_list}
    FOR    ${INDEX}  IN RANGE    0    ${list_len}
     ${data}=  Get From List  ${json_list}  ${INDEX}
     ${lenPads}=  run keyword if  '${data['kitId']}' == '${kitid}'  Get Length  ${data['pads']}  ELSE  Set Variable  0
     Log  ${lenPads}
     ${statusHistory}=  run keyword if  ${lenPads}>0  Get Key Value  ${data['pads']}  ${lenPads}  'padId'  ${padid}  'statusHistory'  ELSE  Set Variable   ${None}
     ${lenStatusHistory}=  run keyword if  ${statusHistory} != ${None}  Get Length  ${statusHistory}  ELSE  Set Variable  0
     ${createTime}=  run keyword if  ${lenstatusHistory}>0  Get Key Value  ${statusHistory}  ${lenstatusHistory}  'type'  ${padstatus}  'createTime'
     Log  ${createTime}
     Exit For Loop IF    '${createTime}' is not '${None}'
    END
    Return  ${createTime}

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
     Return  ${valueRetrieved}


Get Key Value Further
    [Arguments]  ${data}  ${INDEX}  ${my_string1}  ${keyvalue1}  ${key2}  ${keyvalue2}  ${keyToRetrieve}
    Log  ${key2}
    Log  ${keyvalue2}
    Log  ${data[${INDEX}]}.get(${key2})
    ${value}=  Evaluate   ${data[${INDEX}]}.get(${key2})
    ${my_string2}=  Run Keyword If  '${value}' is not '${None}'  convert to string  ${data[${INDEX}][${key2}]}
    ${valueRetrieved}=  Run Keyword If  '${my_string1}' == '${keyvalue1}' and '${my_string2}' == '${keyvalue2}'  Set Variable  ${data[${INDEX}][${keyToRetrieve}]}
    Return  ${valueRetrieved}



Get Time Of Event From MessageLog
    [Arguments]  ${APP_VERSION}  ${URL}  ${emailid}  ${event}   ${messagelog_api}   ${valueid}  ${channelType}=${emptystring}   ${channelValue}=${emptystring}
    #${legalid}=  Get Legal ID   ${APP_VERSION}  ${URL}  ${emailid}
    ${data}=   Catenate    SEPARATOR=  ${messagelog_api}   ${valueid}
    ${json}=  get json  ${APP_VERSION}  ${URL}  ${data}  ${account_api_oauthadmin}
    ${json_list}=   Set Variable   ${json['list']}
    ${list_len}=  get length  ${json_list}
    ${eventtime}=   Set Variable   ${None}
    ${eventtime}=  Run keyword if  ${list_len}>0  Get Key Value  ${json_list}  ${list_len}  'messageType'  ${event}  'time'   ${channelType}  ${channelValue}
    run keyword if  '${eventtime}' is '${None}'  fail  No Message Log Available for event ${event}
    #: FOR    ${INDEX}  IN RANGE    0    ${list_len}
    #\   ${data}=  Get From List  ${json_list}  ${INDEX}
    ##\   ${len}  Get Length  ${data}
    #\   ${len}  Get Length  ${json_list}
    ##\   ${eventtime}=  Run keyword if  ${len}>0  Get Key Value  ${data}  ${len}  'messageType'  ${event}  'time'
    #\   ${eventtime}=  Run keyword if  ${len}>0  Get Key Value  ${json_list}  ${len}  'messageType'  ${event}  'time'
    #\   Log  ${eventtime}
    #\   Exit For Loop IF    '${eventtime}' is not '${None}'
    Return  ${eventtime}

Check Upcoming Event Message
    [Arguments]  ${APP_VERSION}  ${URL}   ${event}   ${eventvalue}  ${key}  ${Keyvalue}   ${Sequence}  ${tobeCheckedKey}  ${tobeCheckedValue}
    ${new_json}=  Extract Messages From Upcoming Event  ${APP_VERSION}  ${URL}   ${event}   ${eventvalue}    ${key}  ${Keyvalue}
    ${new_len}=  get length  ${new_json}
    FOR    ${INDEX}  IN RANGE  0  ${new_len}
     ${data1}=  Get From List  ${new_json}  ${INDEX}
     ${data}=    create list
     append to list   ${data}    ${data1}
     ${valueRetrieved}=  run keyword if  ${new_len}>0  Get Key Value  ${data}  ${new_len}  ${event}  ${eventvalue}  ${tobeCheckedKey}
     ${new2}=   convert to string   ${valueRetrieved}
     log   ${new2}
     exit for loop if  ${INDEX}+1 == ${Sequence}
    END
    should be equal  ${valueRetrieved}  ${tobeCheckedValue}

Extract Messages From Upcoming Event
    [Arguments]  ${APP_VERSION}  ${URL}   ${event}   ${eventvalue}  ${key}  ${keyValue}
    ${data}=   Catenate    SEPARATOR=  ${communication_api_upcomingEvent}   ${eventvalue}
    ${json}=  get json  ${APP_VERSION}  ${URL}  ${data}  ${account_api_oauthadmin}
    ${json_list}=   Set Variable   ${json['list']}
    log  ${json_list}
    ${list_len}=  get length  ${json_list}
    ${new_json}=   create list
    FOR    ${INDEX}  IN RANGE    0    ${list_len}
     ${data1}=  Get From List  ${json_list}  ${INDEX}
     ${data}=    create list
     append to list   ${data}    ${data1}
     ${len1}=  Get Length  ${data}
     ${new1}=  set variable  ${None}
     ${new1}=  run keyword if  ${len1}>0  Get Key Value  ${data}  ${len1}   ${key}  ${keyValue}  ${key}
     ${new1}=   convert to string   ${new1}
      run keyword if  '${new1}' == '${keyValue}'   append to list   ${new_json}    ${json_list [${INDEX}]}
    END
    log   ${new_json}
    Return  ${new_json}

Get Variable Value
    [Arguments]  ${APP_VERSION}  ${URL}  ${variable}
    ${json}=  get json  ${APP_VERSION}  ${URL}  ${communication_api_variables}  ${account_api_oauthadmin}
    ${json_len}=  get length  ${json}
    ${valuevalue}=  Run keyword if  ${json_len}>0  Get Key Value  ${json}  ${json_len}  'key'  ${variable}  'value'
    Log   ${valuevalue}
    Return  ${valuevalue}

Set Variable Value
    [Arguments]  ${APP_VERSION}  ${URL}  ${variable}  ${variableValue}  ${variableDesc}
    Log  ${account_api_oauthadmin}
    ${adminaccesstoken}=  Get Json Param  ${APP_VERSION}  ${URL}  ${account_api_oauthadmin}  access_token
    ${headers}  Create Dictionary  Authorization=Bearer ${adminaccesstoken}  Content-Type=application/json
    ${data}=  set variable  {"key":"${variable}","value":"${variableValue}","description":"${variableDesc}"}
    create session  my_session  ${URL}
    ${Response} =  Post On Session  my_session  ${communication_api_variables}  data=${data}  headers=${headers}
    Log  ${Response.content}
    should be equal as strings  ${Response.status_code}  200
    Return  ${Response}

Set Upcoming Event
    [Arguments]  ${APP_VERSION}  ${URL}  ${eventid}  ${seqNum}  ${sourceEventType}  ${upcomingEventType}  ${timeoutDuration}
    Log  ${account_api_oauthadmin}
    ${adminaccesstoken}=  Get Json Param  ${APP_VERSION}  ${URL}  ${account_api_oauthadmin}  access_token
    ${headers}  Create Dictionary  Authorization=Bearer ${adminaccesstoken}  Content-Type=application/json
    ${data}=  set variable  {"id":"${eventid}","seqNum":"${seqNum}","sourceEventType":"${sourceEventType}","upcomingEventType":"${upcomingEventType}","timeoutDuration":"${timeoutDuration}"}
    create session  my_session  ${URL}
    ${Response} =  Post On Session  my_session  ${communication_api_upcomingmeta}  data=${data}  headers=${headers}
    Log  ${Response.content}
    should be equal as strings  ${Response.status_code}  200
    Return  ${Response}

Calculate Event Time
    [Arguments]  ${basedatetime}  ${variablemins}
    ${datetime}=  Extract DateTime From EventTime  ${basedatetime}
    ${derivedtime}=  Add Time To Date  ${datetime}  ${variablemins} minutes
    Log  ${derivedtime}
    Return  ${derivedtime}

Extract DateTime From EventTime
    [Arguments]  ${basedatetime}
    Log  ${basedatetime}
    ${timesubstring}=  Get Substring  ${basedatetime}  0  23
    #${timesubstring}=  Get Substring  2019-09-19T09:29:36.511+0000  0  23
    ${timesubstring}=  Replace String  ${timesubstring}  T  ' '
    Log  ${timesubstring}
    ${datetime}=  Convert Date  ${timesubstring}
    Return  ${datetime}

Get Product Type Value
     [Arguments]  ${APP_VERSION}  ${URL}  ${producttype}  ${getvalue}
     ${json}=  get json  ${APP_VERSION}  ${URL}  ${product_api_producttypes}  ${account_api_oauthadmin}
     ${json_len}=  get length  ${json}
     ${producttype_value}=  Run keyword if  ${json_len}>0  Get Key Value  ${json}  ${json_len}  'name'  ${producttype}  '${getvalue}'
     Log  ${producttype_value}
     Return  ${producttype_value}


Check Message Log Time After KitUseStart
    [Arguments]  ${APP_VERSION}  ${URL}  ${emailid}  ${eventtocheck}  ${SeqNum}  ${kitid}   ${messagelog_api}   ${valueid}  ${channelType}=${emptystring}   ${channelValue}=${emptystring}
    ${eventtime}=  Get Time Of Event From MessageLog  ${APP_VERSION}  ${URL}  ${emailid}  ${eventtocheck}   ${messagelog_api}   ${valueid}  ${channelType}  ${channelValue}
    ${eventtime}=  Extract DateTime From EventTime  ${eventtime}
    ${kitstarttime}=  Get Kit Status Create Time  ${APP_VERSION}  ${URL}  ${kitid}  IN_USE
    ${calculatedeventtime}=  Calculate Event Time  ${kitstarttime}  0
    ${time}=  Subtract Date From Date  ${eventtime}  ${calculatedeventtime}  result_format=number  exclude_millis=True
    Log  ${time}
    Should be true  ${time}<360.000

Check Message Log Time After KitRegisteredStart
    [Arguments]  ${APP_VERSION}  ${URL}  ${emailid}  ${eventtocheck}  ${SeqNum}  ${kitid}
    ${eventtime}=  Get Time Of Event From MessageLog  ${APP_VERSION}  ${URL}  ${emailid}  ${eventtocheck}
    ${eventtime}=  Extract DateTime From EventTime  ${eventtime}
    ${kitregisteredtime}=  Get Kit Status Create Time  ${APP_VERSION}  ${URL}  ${kitid}  REGISTERED
    ${time_value}=  Get Upcoming Event Value  ${APP_VERSION}  ${URL}  ${eventtocheck}    ${SeqNum}    timeoutDuration
    ${variablemins}=    Get Substring    ${time_value}   2  -1
    ${calculatedeventtime}=  Calculate Event Time  ${kitregisteredtime}  ${variablemins}
    ${time}=  Subtract Date From Date  ${eventtime}  ${calculatedeventtime}  result_format=number
    Log  ${time}
    Should be true  ${time}<360.000

Check Message Log Time After PadEvent
    [Arguments]  ${APP_VERSION}  ${URL}  ${emailid}  ${eventtocheck}  ${SeqNum}  ${kitid}  ${kitstatus}  ${padId}  ${padstatus}   ${messagelog_api}   ${valueid}    ${channelType}=${emptystring}   ${channelValue}=${emptystring}
    ${eventtime}=  Get Time Of Event From MessageLog  ${APP_VERSION}  ${URL}  ${emailid}  ${eventtocheck}   ${messagelog_api}   ${valueid}  ${channelType}  ${channelValue}
    ${eventtime}=  Extract DateTime From EventTime  ${eventtime}
    ${padstatustime}=  Get Pad Status Create Time  ${APP_VERSION}  ${URL}  ${kitid}  ${kitstatus}  ${padId}  ${padstatus}
    Log  ${padstatustime}
    ${time_value}=  Get Upcoming Event Value  ${APP_VERSION}  ${URL}  ${eventtocheck}    ${SeqNum}    timeoutDuration
    ${variablemins}=    Get Substring    ${time_value}   2  -1
    ${calculatedeventtime}=  Calculate Event Time  ${padstatustime}  ${variablemins}
    ${time}=  Subtract Date From Date  ${eventtime}  ${calculatedeventtime}  result_format=number
    Log  ${time}
    Should be true  ${time}<360.000

Check Message Log Time After Event
    [Arguments]  ${APP_VERSION}  ${URL}  ${emailid}  ${eventtocheck}    ${messagelog_api}   ${valueid}    ${channelType}=${emptystring}   ${channelValue}=${emptystring}
    ${eventtime}=  Get Time Of Event From MessageLog  ${APP_VERSION}  ${URL}  ${emailid}  ${eventtocheck}   ${messagelog_api}   ${valueid}  ${channelType}  ${channelValue}
    Log  ${eventtime}
    ${eventdate}=  Get Substring    ${eventtime}    0  10
    ${currenttime}=  Todays Date
    ${currentdate}=  Get Substring  ${currenttime}  0  10
    run keyword if  '${eventdate}' == '${currentdate}'  Log  True




Verify Messages Count From Messagelog
    [Arguments]  ${APP_VERSION}  ${URL}  ${messagelog_api}   ${valueid}  ${key}  ${keyValue}  ${datalength}
    ${data}=   Catenate    SEPARATOR=  ${messagelog_api}   ${valueid}
    ${json}=  get json  ${APP_VERSION}  ${URL}  ${data}  ${account_api_oauthadmin}
    ${json_list}=   Set Variable   ${json['list']}
    log  ${json_list}
    ${list_len}=  get length  ${json_list}
    ${new_json}=   create list
    FOR    ${INDEX}  IN RANGE    0    ${list_len}
     ${data1}=  Get From List  ${json_list}  ${INDEX}
     ${data}=    create list
     append to list   ${data}    ${data1}
     ${len1}=  Get Length  ${data}
     ${new1}=  set variable  ${None}
     ${new1}=  run keyword if  ${len1}>0  Get Key Value  ${data}  ${len1}   ${key}  ${keyValue}  ${key}
     ${new2}=   set variable  ${emptystring}
     ${new2}=   convert to string   ${new1}
      run keyword if  '${new2}' == '${keyValue}'   append to list   ${new_json}    ${json_list [${INDEX}]}
    END
    log   ${new_json}
    ${len_new_json}=  get length  ${new_json}
    run keyword if  ${len_new_json} == ${datalength}  log  ${len_new_json}


Pad Start Collection
    [Arguments]  ${APP_VERSION}  ${URL}  ${account_api_oauthcustomer}  ${padid}  ${emailid}  ${kitstatus}
    ${legalid}=  Get Legal ID  ${APP_VERSION}  ${URL}  ${emailid}
    ${customeraccesstoken}=  Get Json Param  ${APP_VERSION}  ${URL}  ${account_api_oauthcustomer}  access_token
    ${headers}  Create Dictionary  Authorization=Bearer ${customeraccesstoken}  Content-Type=application/v4.0.0+json
    ${pad-id}=  Get Pad Id   ${APP_VERSION}  ${URL}  ${padid}  ${kitstatus}
    ${pad-id}=  convert to string  ${pad-id}
    #Log  ${pad-id}
    create session  my_session  ${URL}
    ${Response} =  Post On Session  my_session  product_api/device/user/${legalid}/updateStatuses  data={"${pad-id}":"START_COLLECTION"}  headers=${headers}
    Log  ${Response.content}
    should be equal as strings  ${Response.status_code}  200
    Log  ${Response}

Pad End Collection
    [Arguments]  ${APP_VERSION}  ${URL}  ${account_api_oauthcustomer}  ${padid}  ${emailid}  ${kitstatus}
    ${legalid}=  Get Legal ID  ${APP_VERSION}  ${URL}  ${emailid}
    ${customeraccesstoken}=  Get Json Param  ${APP_VERSION}  ${URL}  ${account_api_oauthcustomer}  access_token
    ${headers}  Create Dictionary  Authorization=Bearer ${customeraccesstoken}  Content-Type=application/v4.0.0+json
    ${pad-id}=  Get Pad Id   ${APP_VERSION}  ${URL}  ${padid}  ${kitstatus}
    ${pad-id}=  convert to string  ${pad-id}
    #Log  ${pad-id}
    create session  my_session  ${URL}
    ${Response} =  Post On Session  my_session  product_api/device/user/${legalid}/updateStatuses  data={"${pad-id}":"END_COLLECTION"}  headers=${headers}
    Log  ${Response.content}
    should be equal as strings  ${Response.status_code}  200
    Log  ${Response}


Post Method
    [Arguments]  ${URL}  ${data}
    create session  my_session  ${URL}
    ${Response} =  Post On Session  my_session  ${data}
    Log  ${Response.content}
    #should be equal as strings  ${Response.status_code}  200
    ${json} =  Set variable  ${Response.json()}
    Log  ${json}

Get Table Row Count
    [Arguments]  ${Locator_Type}  ${Row_Locator_Value}
    ${rowCount}=   Get Element Count  tag:tr
    Return  ${rowCount}

Get Table Col Count
    [Arguments]  ${Locator_Type}  ${Col_Locator_Value}
    ${colCount}=   Get Element Count  tag:td
    Return  ${colCount}


Get Product Type ID From Kit
    [Arguments]  ${APP_VERSION}  ${URL}  ${kitid}
    ${product_api_kits_status}=   Catenate    SEPARATOR=  ${product_api_kitdetails}  ${kitid}
    ${json}=  get json  ${APP_VERSION}  ${URL}  ${product_api_kits_status}  ${account_api_oauthlab}
    Log  ${json}
    Log  ${json['productTypeId']}
    ${productTypeId}=  set variable  ${json['productTypeId']}
    Return  ${productTypeId}

Get Kit Status
    [Arguments]      ${APP_VERSION}  ${URL}  ${kitid}
    ${product_api_kit_details}=  Catenate    SEPARATOR=  ${product_api_kitdetails}  ${kitid}
    ${json}=  get json  ${APP_VERSION}  ${URL}  ${product_api_kit_details}  ${account_api_oauthadmin}
    ${status}=  run keyword if  '${json['hid']}' == '${kitid}'  Set variable  ${json['status']}
    ${kitstatus}=  run keyword if  ${status} is not ${None}  set variable  ${status['type']}
    Return  ${kitstatus}

Get Assay Name
    [Arguments]      ${APP_VERSION}  ${URL}  ${Assayid}
    ${json}=  get json  ${APP_VERSION}  ${URL}  ${product_api_assay}  ${account_api_oauthlab}
    ${json_len}=  get length  ${json}
    ${assayname}=  Run keyword if  ${json_len}>0  Get Key Value  ${json}  ${json_len}  'id'  ${Assayid}  'name'
    Return  ${assayname}

Get Product Type Name
    [Arguments]  ${APP_VERSION}  ${URL}  ${producttypeid}
    ${json_list}=  get json  ${APP_VERSION}  ${URL}  ${product_api_bundle}  ${account_api_oauthadmin}
    ${list_len}=  get length  ${json_list}
    FOR    ${INDEX}  IN RANGE    0    ${list_len}
    ${data}=  Get From List  ${json_list}  ${INDEX}
    Log  ${data['name']}
    Log  ${data['id']}
    Log  ${producttypeid}
    ${producttype_name}=  Set Variable If  '${data['id']}' == '${producttypeid}'  ${data['name']}
    Exit For Loop IF    '${producttype_name}' is not '${None}'
    END
    Return  ${producttype_name}


Get Assay List from Product
    [Arguments]  ${APP_VERSION}  ${URL}  ${producttypeid}
    ${producttype_name}=  Get Product Type Name  ${APP_VERSION}  ${URL}  ${producttypeid}
    ${json_list}=  get json  ${APP_VERSION}  ${URL}  ${product_api_bundle}  ${account_api_oauthadmin}
    ${list_len}=  get length  ${json_list}
    FOR    ${INDEX}  IN RANGE    0    ${list_len}
    ${data}=  Get From List  ${json_list}  ${INDEX}
    Log  ${data['name']}
    Log  ${data['panelIds']}
    Log  ${producttype_name}
    ${assays_list}=  Set Variable If  '${data['name']}' == '${producttype_name}'  ${data['panelIds']}
    Exit For Loop IF    ${assays_list} != ${None}
    END
    Return  ${assays_list}

Get Assay List From Panel Id
    [Arguments]  ${APP_VERSION}  ${URL}  ${panelId}
    ${json_list}=  get json  ${APP_VERSION}  ${URL}  ${product_api_panel}  ${account_api_oauthadmin}
    ${list_len}=  get length  ${json_list}
    FOR    ${INDEX}  IN RANGE    0    ${list_len}
    ${data}=  Get From List  ${json_list}  ${INDEX}
    Log  ${data['name']}
    Log  ${data['id']}
    Log  ${panelId}
    ${assays_list}=  Set Variable If  '${data['name']}' == '${producttype_name}'  ${data['tests']}
    Exit For Loop IF    ${assays_list} != ${None}
    END
    Return  ${assays_list}


Create Assay Name List
    [Arguments]    ${APP_VERSION}  ${URL}   ${Assayidlist}
    ${assaynamelist}=  create list
    ${list_len}=  Get Length  ${Assayidlist}
    FOR    ${INDEX}  IN RANGE    0    ${list_len}
     ${data}=  Get From List    ${Assayidlist}  ${INDEX}
     ${Assayname}=  Get Assay Name  ${APP_VERSION}  ${URL}  ${data}
      Run keyword   Append To List  ${assaynamelist}  ${Assayname}
      Log  ${assaynamelist}
    END
     Return  ${assaynamelist}

Check Assay For Kits
    [Arguments]  ${APP_VERSION}  ${URL}  ${table_locator}  ${rows}  ${kit_col}  ${assay_col}  ${Jump}
    log  ${rows}
    FOR    ${INDEX}  IN RANGE  1  ${rows}  ${Jump}
     Log  ${INDEX}
#      ${kitid}=  Get Text From Xpath  ${table_locator}/tbody/tr[${INDEX}]/td[${kit_col}]
      ${kitid}=  Get Text  ${table_locator}/tbody/tr[${INDEX}]/td[${kit_col}]
      ${kitid}=  Fetch Kit id from UI  ${kitid}
#      ${assay}=  Get Text From Xpath  ${table_locator}/tbody/tr[${INDEX}]/td[${assay_col}]
      ${assay}=  Get Text  ${table_locator}/tbody/tr[${INDEX}]/td[${assay_col}]
      ${assay}=  replace string  ${assay}  ,  ${SPACE}${SPACE}
      ${assay_list}=  Split string  ${assay}   ${SPACE}${SPACE}
      Compare Assay List  ${APP_VERSION}  ${URL}  ${kitid}  ${assay_list}
    END

Compare Assay List
    [Arguments]  ${APP_VERSION}  ${URL}  ${kitid}  ${assay_list}
    Sort List  ${assay_list}
    Log  ${assay_list}
    ${product_id}=  Get Product Type ID From Kit  ${APP_VERSION}  ${URL}  ${kitid}
    ${assayid_list}=  Get Assay List from Product  ${APP_VERSION}  ${URL}  ${productid}
    ${assaynamelist}=  Create Assay Name List  ${APP_VERSION}  ${URL}  ${assayid_list}
    Sort list  ${assaynamelist}
    Log  ${assaynamelist}
    lists should be equal  ${assaynamelist}  ${assay_list}

Fetch Kit id from UI
    [Arguments]  ${String}
    ${index}=  Get_character_index_in_string  ${String}  (
    ${kitid}=  get substring  ${String}  ${index}  -1
    Return  ${kitid}

Check UI Kit Status
    [Arguments]  ${APP_VERSION}  ${URL}   ${kit_list}   ${lookup_text1}  ${lookup_text2}=${None}  ${lookup_text3}=${None}
    #Log  ${Status}
    ${list_len}=  Get Length  ${kit_list}
    FOR    ${INDEX}  IN RANGE    0    ${list_len}
      ${Kitid}=  Get From List    ${kit_list}  ${INDEX}
      ${Kitid}=  Fetch Kit id from UI  ${Kitid}
      ${Status}=  Get Kit Status  ${APP_VERSION}  ${URL}  ${Kitid}
      should contain any  ${Status}  ${lookup_text1}  ${lookup_text2}  ${lookup_text3}
    END

Get Group Id
    [Arguments]  ${APP_VERSION}  ${URL}  ${title_name}
    ${json}=  get json  ${APP_VERSION}  ${URL}  ${account_api_group}  ${account_api_oauthadmin}
    ${list_len}=  get length  ${json}
    ${groupid}=  run keyword if  ${list_len}>0  Get Key Value  ${json}  ${list_len}  'title'  ${title_name}  'id'
    log  ${groupid}
    Return  ${groupid}


Get Group Participant Id
    [Arguments]  ${APP_VERSION}  ${URL}    ${groupid}   ${legalid}
    ${json}=  get json  ${APP_VERSION}  ${URL}  /account_api/group/${groupid}/participants?limit=10&offset=0&sort=-createTime  ${account_api_oauthdoctor}
    ${json_list}=   Set Variable   ${json['list']}
    log  ${json_list}
    ${list_len}=  get length  ${json_list}
    ${participantid}=  run keyword if  ${list_len}>0  Get Key Value  ${json_list}  ${list_len}  'customerId'   ${legalid}   'id'
    Log   ${participantid}
    Return  ${participantid}

Get Group Participant Status
    [Arguments]  ${APP_VERSION}  ${URL}    ${groupid}   ${legalid}
    ${json}=  get json  ${APP_VERSION}  ${URL}  /account_api/group/${groupid}/participants?limit=10&offset=0&sort=-createTime  ${account_api_oauthdoctor}
    ${json_list}=   Set Variable   ${json['list']}
    log  ${json_list}
    ${list_len}=  get length  ${json_list}
    ${participantstatus}=  run keyword if  ${list_len}>0  Get Key Value  ${json_list}  ${list_len}  'customerId'   ${legalid}   'status'
    Log   ${participantstatus}
    ${participantstatustype}=  Set Variable  ${participantstatus['type']}
    Log  ${participantstatustype}
    Return  ${participantstatustype}



Approve User
    [Arguments]  ${APP_VERSION}  ${URL}    ${paticipantid}
    ${adminaccesstoken}=  Get Json Param  ${APP_VERSION}  ${URL}  ${account_api_oauthadmin}  access_token
    ${headers}  Create Dictionary  Authorization=Bearer ${adminaccesstoken}  Content-Type=application/json
    create session  my_session  ${URL}
    ${Response} =  Post On Session  my_session  /account_api/group/participants/${paticipantid}/status/APPROVED?      headers=${headers}
    Log  ${Response.content}
    should be equal as strings  ${Response.status_code}  200
    Log  ${Response}

Get Wizard step details
     [Arguments]    ${APP_VERSION}   ${URL}  ${wizid}
     ${product_api_wizard_details}=  catenate  SEPARATOR=   ${product_api_wizard_details}  ${wizid}
     ${json}=    get json  ${APP_VERSION}  ${URL}  ${product_api_wizard_details}  ${account_api_oauthadmin}
     ${steps}=  run keyword if  '${json['id']}' == '${wizid}'  Set variable  ${json['steps']}
     Log  ${steps}
     Return  ${steps}

Get step id
    [Arguments]   ${steps}  ${step_name}
    ${list_len}=  get length  ${steps}
    ${step_id}=  run keyword if  ${list_len}>0  Get Key Value  ${steps}  ${list_len}  'name'  ${step_name}  'id'
    Log  ${step_id}
    Return  ${step_id}


Create new User
    [Arguments]  ${APP_VERSION}  ${URL}    ${first_name}   ${Last_name}    ${Email}    ${Password}
    ${Email}=   Replace string  ${Email}    @   %40
    ${Password}=       Replace string  ${Password}  @   %40
    ${Request_url}=  set variable   firstName=${first_name}&lastName=${Last_name}&email=${Email}&password=${Password}&scope=browser
    ${accout_api_create_user}=   Catenate   SEPARATOR=  ${accout_api_create_user}  ${Request_url}
    create session  my_session  ${URL}
    ${Response} =  Post On Session  my_session  ${accout_api_create_user}
    Log  ${Response.content}
    should be equal as strings  ${Response.status_code}  200
    Return  ${Response.text}

Submit Survey
    [Arguments]    ${APP_VERSION}  ${URL}   ${legalid}  ${wizid}
    ${adminaccesstoken}=  Get Json Param  ${APP_VERSION}  ${URL}  ${account_api_oauthadmin}  access_token
    ${headers}  Create Dictionary  Authorization=Bearer ${adminaccesstoken}  Content-Type=application/json
    ${request_url}=  set variable  ${product_api_survey}
    ${Surveyjson}=  Prepare Json  customerId=${legalid}  encounterId=${emptystring}  wizardId=${wizid}  status={"type": "COMPLETED", "createUserId": ""}
    ${Surveyjson}=  Replace String  ${Surveyjson}  "{   {
    ${Surveyjson}=  Replace String  ${Surveyjson}  }"   }
    ${Surveyjson}=  Replace String  ${Surveyjson}   \\   ${emptystring}
    Create session     my_session  ${URL}
    ${Response} =  Post On Session  my_session  ${request_url}   headers=${headers}   data=${Surveyjson}
    Log  ${Response.content}
    should be equal as strings  ${Response.status_code}  200
    Return  ${Response.text}


Submit Account Steps
     [Arguments]    ${APP_VERSION}  ${URL}   ${surveyid}    ${legalid}  ${account_api_oauthcustomer}   ${steps}  ${addressLine}   ${ZIP}  ${State}    ${Country}  ${City}  ${DOB}
     ${step_id_address}=  Get step id   ${steps}    AddressStep
     ${step_id_dob}=  Get step id  ${steps}   BirthdateStep
     ${customeraccesstoken}=  Get Json Param  ${APP_VERSION}  ${URL}  ${account_api_oauthcustomer}  access_token
     ${headers}  Create Dictionary  Authorization=Bearer ${customeraccesstoken}   Content-Type=application/json
     ${Request_URL}=   set variable     ${account_api_survey}
     ${account_api_survey}=   Catenate   SEPARATOR=    ${request_url}    ${surveyid}
     ${Submit_Account_Steps1}=  Prepare Json  country=${Country}   state=${State}  city=${City}  addressLine=${addressLine}    zip=${ZIP}    legalEntityId=${legalid}
     ${Submit_Account_Steps2}=  Prepare Json  dateOfBirth=${DOB}   stepId=${step_id_dob}
     ${Submit_Account_Steps3}=  Prepare Json    address=${Submit_Account_Steps1}   stepId=${step_id_address}
     ${Submit_Account_Steps3}=  Replace String  ${Submit_Account_Steps3}  "{   {
     ${Submit_Account_Steps3}=  Replace String  ${Submit_Account_Steps3}  }"   }
     ${Submit_Account_Steps3}=  Replace String  ${Submit_Account_Steps3}   \\   ${emptystring}
     ${Submit_Account_Steps4}=  Prepare Json   address=${Submit_Account_Steps3}    dateOfBirth=${Submit_Account_Steps2}
     ${Submit_Account_Steps4}=  Replace String  ${Submit_Account_Steps4}  "{   {
     ${Submit_Account_Steps4}=  Replace String  ${Submit_Account_Steps4}  }"   }
     ${Submit_Account_Steps4}=  Replace String  ${Submit_Account_Steps4}   \\   ${emptystring}
     Create session     my_session  ${URL}
     ${Response} =  Post On Session  my_session  ${account_api_survey}   headers=${headers}   data=${Submit_Account_Steps4}
     Log  ${Response.content}
     should be equal as strings  ${Response.status_code}  200
     Return  ${Response.text}

Enroll in Group
    [Arguments]  ${APP_VERSION}  ${URL}  ${title_name}  ${customer_legalid}
    ${adminaccesstoken}=  Get Json Param  ${APP_VERSION}  ${URL}  ${account_api_oauthadmin}  access_token
    ${headers}  Create Dictionary  Authorization=Bearer ${adminaccesstoken}  Content-Type=application/json
    ${group_id}=  get group id  ${APP_VERSION}   ${URL}  ${title_name}
    ${request_url}=  set variable  ${group_id}/participants/customer/${customer_legalid}
    ${account_api_enrollgroup}=   Catenate   SEPARATOR=   ${account_api_enrollgroup}    ${request_url}
    create session  my_session  ${URL}
    ${Response}=  Post On Session  my_session  ${account_api_enrollgroup}  headers=${headers}
    Log  ${Response.content}
    should be equal as strings  ${Response.status_code}  200
    Return  ${Response.text}

Get Assay Result Id
    [Arguments]  ${APP_VERSION}  ${URL}  ${kitId}   ${kitStatus}
    ${analysisreqId}=   Get Analysis Request ID   ${APP_VERSION}  ${URL}  ${kitid}  ${kitStatus}
    ${kitid}=  Get Kit ID  ${APP_VERSION}  ${URL}  ${kitId}   ${kitStatus}
    ${product_api_analysisRequestDetails}=   Catenate    SEPARATOR=  ${analysisreqdetails}  ${analysisreqId}
    ${json}=  get json  ${APP_VERSION}  ${URL}  ${product_api_analysisRequestDetails}  ${account_api_oauthdoctor}
    ${json}=  Set Variable  ${json[0]}
    ${list_len}=  Get length   ${json}
    ${assayResults}=  run keyword if  '${json['kitId']}' == '${kitid}'   Set Variable   ${json['assayResults']}
    ${assayResults}=  Set Variable  ${assayResults[0]}
    ${assayResultsid}=  Set Variable  ${assayResults['id']}
    Return  ${assayResultsid}

Set Physician Approval
    [Arguments]  ${APP_VERSION}  ${URL}  ${analysisReqId}   ${StatusToUpdate}
    ${doctoraccesstoken}=  Get Json Param  ${APP_VERSION}  ${URL}  ${account_api_oauthdoctor}  access_token
    ${headers}  Create Dictionary  Authorization=Bearer ${doctoraccesstoken}  Content-Type=application/json
    ${physicianApprovalURL}=   Set Variable   /product_api/assayResult/${analysisReqId}?statusType=${StatusToUpdate}
    create session  my_session  ${URL}
    ${Response}=  Post On Session  my_session  ${physicianApprovalURL}  headers=${headers}
    Log  ${Response.content}
    should be equal as strings  ${Response.status_code}  200
    Return  ${Response.text}

Get Assay Details
    [Arguments]     ${APP_VERSION}  ${URL}  ${name}  ${title}
    ${json}=  get json  ${APP_VERSION}  ${URL}  ${product_api_assay}  ${account_api_oauthadmin}
    ${json_len}=  get length  ${json}
    ${titlename}=  Run keyword if  ${json_len}>0  Get Key Value  ${json}  ${json_len}  'name'  ${name}  '${title}'
    Return  ${titlename}

Update Assay details
    [Arguments]     ${APP_VERSION}  ${URL}  ${name}   ${time}
    ${adminaccesstoken}=  Get Json Param  ${APP_VERSION}  ${URL}  ${account_api_oauthadmin}  access_token
    ${headers}  Create Dictionary  Authorization=Bearer ${adminaccesstoken}  Content-Type=application/json
    ${request_url}=  set variable  ${product_api_assay}
    # Get Assay Details  ${APP_VERSION}  ${TEST_ENV}  CRP   id
    ${id}  Get Assay Details    ${APP_VERSION}  ${URL}  ${name}  id
    ${name}  Get Assay Details    ${APP_VERSION}  ${URL}  ${name}  name
    ##${ranges}  Get Assay Details    ${APP_VERSION}  ${URL}  ${name}  ranges
    ${unit}  Get Assay Details    ${APP_VERSION}  ${URL}  ${name}  unit
    ${releaseToCustomer}  Get Assay Details    ${APP_VERSION}  ${URL}  ${name}  releaseToCustomer
    ##${expirationHours}  Get Assay Details    ${APP_VERSION}  ${URL}  ${name}  expirationHours
    ${fasting}  Get Assay Details    ${APP_VERSION}  ${URL}  ${name}  fasting
    ${approver}  Get Assay Details    ${APP_VERSION}  ${URL}  ${name}  approver
    ##${acceptablePercentDelta}=  Get Assay Details    ${APP_VERSION}  ${URL}  ${name}    acceptablePercentDelta
    ${specimenType}  Get Assay Details    ${APP_VERSION}  ${URL}  ${name}  specimenType
    ##${displayConfig}  Get Assay Details    ${APP_VERSION}  ${URL}  ${name}  displayConfig
    ${referenceType}  Get Assay Details    ${APP_VERSION}  ${URL}  ${name}  referenceType
    ${referenceExpirationHours}  Get Assay Details    ${APP_VERSION}  ${URL}  ${name}  referenceExpirationHours
    ${Assayupdatejson}=  Prepare Json  id=${id}  name=${name}  unit=${unit}  releaseToCustomer=${releaseToCustomer}  expirationHours=${time}   fasting=${fasting}  approver=${approver}  specimenType=${specimenType}  referenceType=${referenceType}  referenceExpirationHours=${referenceExpirationHours}
    #${Surveyjson}=  Replace String  ${Surveyjson}  "{   {
    #${Surveyjson}=  Replace String  ${Surveyjson}  }"   }
    #${Surveyjson}=  Replace String  ${Surveyjson}   \\   ${emptystring}
    Create session     my_session  ${URL}
    ${Response} =  Post On Session  my_session  ${request_url}   headers=${headers}   data=${Assayupdatejson}
    Log  ${Response.content}
    should be equal as strings  ${Response.status_code}  201
    Return  ${Response.text}

Get total Analysis Request Per Customer
    [Arguments]  ${APP_VERSION}  ${URL}
    ${legal_id_list}=  Get Legal ID List  ${APP_VERSION}  ${URL}
    ${legal_id_list_len}=  get length  ${legal_id_list}
    ${count_list}=   Create list
    FOR    ${INDEX}  IN RANGE    0    ${legal_id_list_len}
     ${legal id}=  Get From List  ${legal_id_list}  ${INDEX}
     ${analysisRequests_url}=   Catenate    SEPARATOR=  ${analysisRequests}   ${legal id}    ?limit=10&offset=0&sort=-createTime&search
     ${json}=  get json  ${APP_VERSION}  ${URL}  ${analysisRequests_url}   ${account_api_oauthadmin}
     ${json_list}=   Set Variable   ${json['list']}
     ${list_len}=  get length  ${json_list}
      Run keyword   Append To List  ${count_list}  ${list_len}
      Log     ${count_list}
    END
     ${len}=  Get length   ${count_list}

    ${max_num}=  Evaluate  max(${count_list})
    log   ${max_num}

    For  ${INDEX}  IN RANGE    0    ${len}
    ${count}=  Get From List  ${count_list}  ${INDEX}
    Run Keyword If  '${count}'=='${max_num}'   log  ${INDEX}
    Exit For Loop IF    '${count}'=='${max_num}'
    END
    Log  ${INDEX}
    ${legal_id}=  Get From List  ${legal_id_list}  ${INDEX}
    Log  ${legal_id}
   Return  ${legal_id}

Get Dendi Order Code
    [Arguments]  ${APP_VERSION}  ${URL}  ${kitId}
    ${kitStatus}=  get kit status  ${APP_VERSION}  ${URL}  ${kitId}
    ${kitId}=  Get Kit ID  ${APP_VERSION}  ${URL}  ${kitId}  ${kitstatus}
    ${product_api_analysisRequestKit}=   Catenate    SEPARATOR=  ${product_api_analysisRequestKit}  ${kitid}
    ${json}=  get json  ${APP_VERSION}  ${URL}  ${product_api_analysisRequestKit}  ${account_api_oauthdoctor}
    #${json_list}=   Set Variable   ${json['list']}
    #Log  ${json_list}
    log  ${json['id']}
    ${externalOrderCode}=  Set Variable  ${json['externalOrderCode']}
    Return  ${externalOrderCode}

#
#Get Dendi UUID
#    [Arguments]  ${URL}  ${externalOrderCode}  ${token}
##    ${product_api_test_results}=   Catenate    SEPARATOR=  ${product_api_test_results}  ${externalOrderCode}
#    Create Session    test_session    ${url}
#    ${params}=   Create Dictionary   order_code=${externalOrderCode}
#    ${default_headers}    Create Dictionary  Authorization=Token ${token}   Content-Type=application/json    Accept=application/json
#    ${response}    Get On Session   test_session   v2/orders/test_results    headers=${default_headers}     params=${params}
#    Should Be Equal As Strings    ${response.status_code}    200
#    ${body}=  Set Variable  ${response.content}



Get Json Param Dendi
    [Arguments]  ${URL}  ${jsonparam}
    ${accept}=   Set Variable  */*
    ${headers}    Create Dictionary  Cookie=csrftoken=DLBc8XwRMosyjBpoxgz5kk5ZtE5wsWF1IxjZllkjbbAZ0uBul34BcaQCJmlXOwe0  Content-Type=application/x-www-form-urlencoded  Accept=${accept}
    Create Session  my_session  ${URL}
    ${formURLEncodedBody}=    Create Dictionary    username=sa-dendi-sandbox@qvin.com   password=object5MOOD_spittoon2baseball*clack
    ${Response}=    Post On Session    my_session   ${dendi_api_auth}   headers=${headers}  data=${formURLEncodedBody}
    Log  ${Response.content}
    should be equal as strings  ${Response.status_code}  200
    ${json} =  Set variable  ${Response.json()}
    Log  ${json}
    Return  ${json['${jsonparam}']}


Get Json Dendi
    [Arguments]  ${URL}  ${apipath}  ${inputjson}=${None}
    ${accesstoken}=  Get Json Param Dendi  ${URL}  token
    ${headers}       Create Dictionary  Authorization=token ${accesstoken}
    create session  my_session  ${URL}
    ${Response} =  Get On Session  my_session  ${apipath}  headers=${headers}  json=${inputjson}
    Log  ${Response.content}
    should be equal as strings  ${Response.status_code}  200
    Log  ${Response.json()}
    ${json} =  Set variable  ${Response.json()}
    Log  ${json}
    Log  ${Response.json()}
    Return  ${json}

Get Dendi Order UUID
    [Arguments]  ${URL}  ${OrderID}
    ${dendi_api_order_orderid}=   Catenate    SEPARATOR=  ${dendi_api_order}  ${OrderID}
    ${json}=  Get Json Dendi  ${URL}  ${dendi_api_order_orderid}  ${dendi_api_auth}
    ${json_results_list}  Set Variable  ${json['results']}
    ${list_len}=  get length  ${json_results_list}
    FOR    ${INDEX}  IN RANGE    0    ${list_len}
        ${dendiOrderUuid}=  Evaluate   ${json_results_list[${INDEX}]}.get('uuid')
    END
    Return  ${dendiOrderUuid}

Get Dendi Order Tests
    [Arguments]  ${URL}  ${OrderID}
    ${dendi_api_order_orderid}=   Catenate    SEPARATOR=  ${dendi_api_order}  ${OrderID}
    ${json}=  Get Json Dendi  ${URL}  ${dendi_api_order_orderid}  ${dendi_api_auth}
    ${dendiOrderTest}  Set Variable  ${json['results']}
    log  ${dendiOrderTest}
    Return  ${dendiOrderTest}


Receive Dendi Order
    [Arguments]  ${URL}  ${dendiOrderCode}  ${token}
    ${dendiOrderUuid}=  Get Dendi Order UUID  ${URL}  ${dendiOrderCode}
    Create Session    test_session    ${URL}
    ${dendi_api_order_receive_full}=   Catenate    SEPARATOR=  ${dendi_api_order_receive}  ${dendiOrderUuid}
    ${default_headers}    Create Dictionary  Authorization=Token ${token}   Content-Type=application/json    Accept=application/json
    ${response}    Put On Session   test_session   ${dendi_api_order_receive_full}    headers=${default_headers}
    Should Be Equal As Strings    ${response.status_code}    200

Reject Dendi Order
    [Arguments]  ${URL}  ${dendiOrderCode}  ${token}
    ${dendiOrderUuid}=  Get Dendi Order UUID  ${URL}  ${dendiOrderCode}
    Create Session    test_session    ${URL}
    ${dendi_api_order_reject_full}=   Catenate    SEPARATOR=  ${dendi_api_order_reject}  ${dendiOrderUuid}
    ${default_headers}    Create Dictionary  Authorization=Token ${token}   Content-Type=application/json    Accept=application/json
    ${response}    Put On Session   test_session   ${dendi_api_order_reject_full}    headers=${default_headers}
    Should Be Equal As Strings    ${response.status_code}    200

Set Dendi Result
    [Arguments]  ${URL}  ${token}  ${list}
    Create Session    my session    ${url}
    ${list}=  set variable  ${list[0]}
    log  ${list}
    ${list}  Evaluate  json.dumps(${list})
    log  ${list}
    ${default_headers}    Create Dictionary  Authorization=Token ${token}   Content-Type=application/json    Accept=application/json
    ${response}    Post On Session   my session  ${dendi_api_order_result}    headers=${default_headers}   data=${list}
    log  ${response.content}
    Should Be Equal As Strings    ${response.status_code}    201

Verify Dendi Result
    [Arguments]  ${URL}  ${token}  ${dendiOrderCode}
    ${body}=  Create Dictionary    order_code= ${dendiOrderCode}
    ${body}=  Evaluate  json.dumps(${body})
    Create Session    test_session    ${URL}
    ${default_headers}    Create Dictionary  Authorization=Token ${token}   Content-Type=application/json    Accept=application/json
    ${response}    Post On Session   test_session   ${dendi_api_order_verify}    headers=${default_headers}   data=${body}
    Should Be Equal As Strings    ${response.status_code}    202


Create Dendi List For HbA1c
    [Arguments]    ${order_test}  ${quantitative}  ${qualitative}=${emptystring}
    log  ${order_test}
    ${list_len}=  get length  ${order_test}
        FOR    ${INDEX}  IN RANGE    0    ${list_len}
        ${tests}=    Evaluate    ${order_test[${INDEX}]}.get('tests')
        ${result}=  Evaluate    ${tests[0]}.get('result')
        ${result}=   Convert Dict To Json  ${result}
        Log  ${result}
        ${result}  Evaluate  json.loads(${result})
        ${result}  Create Dictionary  result=${result}
        ${result}  Set variable  ${result['result']}
        Set to Dictionary    ${result}    result_quantitative=${quantitative}
        Set to Dictionary    ${result}    result_qualitative=${qualitative}

        ${result1}=  Evaluate    ${tests[1]}.get('result')
        ${result1}=   Convert Dict To Json  ${result1}
        Log  ${result1}
        ${result1}  Evaluate  json.loads(${result1})
        ${result1}  Create Dictionary  result=${result1}
        ${result1}  Set variable  ${result1['result']}
        Set to Dictionary    ${result1}    result_quantitative=${quantitative}
        Set to Dictionary    ${result1}    result_qualitative=${qualitative}


        ${tests}=   Convert Dict To Json  ${tests}
        Log  ${result}
        ${tests}  Evaluate  json.loads(${tests})
        ${tests}  Create Dictionary  tests=${tests}
        ${tests}  Set variable  ${tests['tests']}
        Set to Dictionary  ${tests[0]}   result=${result}
        Set to Dictionary  ${tests[1]}   result=${result1}
        log  ${tests}

        ${json}=   Convert Dict To Json  ${order_test}
        Log  ${json}
        ${json}  Evaluate  json.loads(${json})
        ${json}  Create Dictionary  new=${json}
        ${json}  Set variable  ${json["new"]}
        Set to Dictionary  ${json[0]}   tests=${tests}
        log  ${json}
        END
    Return  ${json}



Reading CSV
    [Arguments]    ${csvfile}
    ${csv_file}  read csv file    ${csvfile}
    Return  ${csv_file}


Convert Excel to CSV
    [Arguments]    ${excelFile}  ${worksheetName}
    ${converted_csv}  convert excelworkSheet to csv   ${excelFile}  ${worksheetName}
    Return  ${converted_csv}

Get Result Data From CSV
    [Arguments]    ${testName_list}   ${calcutedResults}  ${chlorideValue}  ${result_index}   ${results}  ${feild_names}

    FOR  ${result_index}   IN   @{result_index}
        ${test}  Set Variable  ${result_index}
        ${test_name}  Set Variable   ${feild_names}[${test}]


        IF  "${test_name}" == "LH"
            Append to list  ${testName_list}   LH Calculated
            ${result}  set variable  ${results}[${test}]
            ${lh_calculated}  Evaluate   (101.55 / ${chlorideValue}) * (${result} * 12.0) * 1.6 + 0.7233
            ${lh_calculated}=    convert to number      ${lh_calculated}  2
            ${lh_calculated}   Evaluate  "%.2f" % ${lh_calculated}
            Append to list  ${calcutedResults}   ${lh_calculated}


        ELSE IF  "${test_name}" == "AMH"
            Append to list  ${testName_list}   AMH Calculated
            ${result}  set variable  ${results}[${test}]
            ${amh_calculated}  Evaluate   (101.55 / ${chlorideValue}) * (${result} * 20.05) * (1.69) + (0.41889)
            ${amh_calculated}=    convert to number      ${amh_calculated}     2
            ${amh_calculated}   Evaluate  "%.2f" % ${amh_calculated}
            Append to list  ${calcutedResults}   ${amh_calculated}


        ELSE IF  "${test_name}" == "TSH"
            Append to list  ${testName_list}   TSH Calculated
            ${result}  set variable  ${results}[${test}]
            ${tsh_calculated}  Evaluate   (101.7 / ${chlorideValue}) * (${result} * 20.04) * 1.111 + 0.4177
            ${tsh_calculated}=    convert to number      ${tsh_calculated}     2
            ${tsh_calculated}   Evaluate  "%.2f" % ${tsh_calculated}
            Append to list  ${calcutedResults}   ${tsh_calculated}


        ELSE IF  "${test_name}" == "FSH"
            Append to list  ${testName_list}   FSH Calculated
            ${result}  set variable  ${results}[${test}]
            ${fsh_calculated}  Evaluate   (101.55 / ${chlorideValue}) * (${result} * 12.0) * (1.46) + (1.6839)
            ${fsh_calculated}=    convert to number      ${fsh_calculated}     2
            ${fsh_calculated}   Evaluate  "%.2f" % ${fsh_calculated}
            Append to list  ${calcutedResults}   ${fsh_calculated}

        ELSE
            Append to list  ${testName_list}  ${test_name}
            ${result}  set variable  ${results}[${test}]
            ${result}    convert to number      ${result}     2
            ${result}   Evaluate  "%.2f" % ${result}
            Append to list  ${calcutedResults}   ${result}
        END
    END

#
#Initialize Credentials
#    ${serviceAccountJsonPath}=    Set Variable    qurasense-test-tdc-sa.json
#    ${credentials}    Evaluate    credentials = ServiceAccountCredentials.fromJson(File('${serviceAccountJsonPath}').readAsStringSync())
#    ${http_client}    Evaluate    http_client = await clientViaServiceAccount(credentials, [storage.StorageApi.devstorageReadOnlyScope])
#    Return    ${http_client}
#
#Login to Storage API
#    [Arguments]    ${browser}    ${url}    ${username}    ${password}
#    Input Text    name=username    ${username}
#    Input Password    name=password    ${password}
#    Click Button    name=login
#
#Download Excel Files
#    [Arguments]    ${file_names}  ${http_client}
#    ${bucket_name}    Set Variable    tdc-data
#    ${output_file_path}    Set Variable    ..//
#    ${http_client}    Set Variable   ${http_client}
#
##Download Excel Files
##    Initialize Credentials
##    Login to Storage API
##    Download Excel Files    Test Data for TDC.xlsx
###    Close Storage API

Download Excel from Cloud

    [Arguments]     ${bucket_name}    ${file_names}   ${output_file_location}   ${token}
    ${output_file}   fetching excel from cloud  ${bucket_name}    ${file_names}   ${output_file_location}   ${token}
    Return  ${output_file}