*** Settings ***
Documentation  layer is for creating custom keywords
Library  DateTime
Library  OperatingSystem
Library  Collections
Library  String
Library  ../libs/custom_selenium_library.py
Resource  page_actions.robot
Resource  api_utils.robot
Resource  ../data/global_variables.robot


*** Variables ***

*** Keywords ***

Todays Date
    ${date} =  Get Current Date  exclude_millis=TRUE
    RETURN  ${date}

Get Date After Adding Days
    [Arguments]  ${date}    ${number}  ${outputDateFormat}
    ${date} =  Add Time To Date	${date}	 ${number} days
    log to console  ${date}
    ${datetime} =	 Convert Date	${date}	 result_format=${outputDateFormat}
   RETURN   ${datetime}

Get Day From Date
    [Arguments]  ${dateandtime}
    ${datetime} =	Convert Date	${dateandtime}	 datetime
   RETURN   ${datetime.day}


Convert String To Date
    [Arguments]  ${dateandtime}  ${inputdateformat}
    ${datetime} =	Convert Date  ${dateandtime}  date_format=${inputdateformat}   exclude_millis=yes
   RETURN   ${datetime}

Get Date From Date
    [Arguments]  ${dateandtime}
    ${datetime} =	Convert Date  ${dateandtime}  result_format=%m/%d/%Y
   RETURN   ${datetime}

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
   RETURN   ${time}

Get PM Time
    [Arguments]  ${hourspm}  ${minutespm}
    ${hourspm}=  run keyword if  ${hourspm} > 12  Evaluate  ${hourspm}-12  ELSE  Set Variable  ${hourspm}
    ${timepm}=   Set variable  ${hourspm}:${minutespm} PM
   RETURN   ${timepm}

Get AM Time
    [Arguments]  ${hoursam}  ${minutesam}
    ${timeam}=   Set variable  ${hoursam}:${minutesam} AM
   RETURN   ${timeam}

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
   RETURN ${account_api_oauthcustomer}

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
   RETURN ${readResult}

Verify Text Not In Excel
    [Arguments]   ${file}  ${textToSearch}
    ${readResult}=    Read_XL  ${file}  ${textToSearch}
    should be equal as strings  ${readResult}  false


Post Form Data Request
     [Arguments]  ${URL}  ${headers}  ${file}
     ${Response} =  Post File  ${URL}  ${headers}  ${file}
    RETURN ${Response}



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




Calculate Event Time
    [Arguments]  ${basedatetime}  ${variablemins}
    ${datetime}=  Extract DateTime From EventTime  ${basedatetime}
    ${derivedtime}=  Add Time To Date  ${datetime}  ${variablemins} minutes
    Log  ${derivedtime}
   RETURN ${derivedtime}

Extract DateTime From EventTime
    [Arguments]  ${basedatetime}
    Log  ${basedatetime}
    ${timesubstring}=  Get Substring  ${basedatetime}  0  23
    #${timesubstring}=  Get Substring  2019-09-19T09:29:36.511+0000  0  23
    ${timesubstring}=  Replace String  ${timesubstring}  T  ' '
    Log  ${timesubstring}
    ${datetime}=  Convert Date  ${timesubstring}
   RETURN ${datetime}


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
    [Arguments]  ${APP_VERSION}  ${URL}  ${emailid}  ${eventtocheck}  ${SeqNum}  ${kitid}  ${messagelog_api}   ${valueid}    ${channelType}=${emptystring}   ${channelValue}=${emptystring}
    ${eventtime}=  Get Time Of Event From MessageLog  ${APP_VERSION}  ${URL}  ${emailid}  ${eventtocheck}   ${messagelog_api}   ${valueid}  ${channelType}  ${channelValue}
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



Get Table Row Count
    [Arguments]  ${Locator_Type}  ${Row_Locator_Value}
    ${rowCount}=   Get Element Count  tag:tr
   RETURN ${rowCount}

Get Table Col Count
    [Arguments]  ${Locator_Type}  ${Col_Locator_Value}
    ${colCount}=   Get Element Count  tag:td
   RETURN ${colCount}




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
    RETURN ${assaynamelist}

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
   RETURN ${kitid}

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


Get step id
    [Arguments]   ${steps}  ${step_name}
    ${list_len}=  get length  ${steps}
    ${step_id}=  run keyword if  ${list_len}>0  Get Key Value  ${steps}  ${list_len}  'name'  ${step_name}  'id'
    Log  ${step_id}
   RETURN ${step_id}


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
   RETURN ${Response.text}




Reading CSV
    [Arguments]    ${csvfile}
    ${csv_file}  read csv file    ${csvfile}
   RETURN ${csv_file}


Convert Excel to CSV
    [Arguments]    ${excelFile}  ${worksheetName}
    ${converted_csv}  convert excelworkSheet to csv   ${excelFile}  ${worksheetName}
   RETURN ${converted_csv}

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


Download Excel from Cloud

    [Arguments]     ${bucket_name}    ${file_names}   ${output_file_location}   ${token}
    ${output_file}   fetching excel from cloud  ${bucket_name}    ${file_names}   ${output_file_location}   ${token}
   RETURN ${output_file}