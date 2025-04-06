*** Settings ***
Documentation  This is a test suite for Qurasense GUI Testing
Resource  ../data/global_variables.robot
Resource    ../resources/page_actions.robot
Resource    ../resources/custom_actions.robot
*** Variables ***

*** Test Cases ***

#AT_MED_01
#    #Open Browser and navigate to the desired URL
#    Navigate To  ${BROWSER}  ${DASHBOARD_URL}
#    #Click Login Link on main screen
#    #Click  link  Login
#    #Click username
#    Click  css  input[type='text']
#    #Enter username
#    Enter Text  css  input[type='text']  _doctor@qvin.com
#    #Click password
#    Click  css  input[type='password']
#    #Enter password
#    Enter Text  css  input[type='password']  secret
#    #Click Login button
#    Click  xpath  //material-ripple
#    #Click on user name link, which needs to be assigned to Trial
#    Click  link  _TestCustomer1_FirstName _TestCustomer1_LastName
#    #Click on Select Box for selecting trial
#    Click  id  customertrial_select_trial
#    #Click on xpath, for the desired trial
#    Click  xpath  //material-select-item[contains(.,'San Diego comparative trial')]
#    #Click on Accept button
#    Click  id  customertrial_btn_accept
#    #Click on YES button, on the active x window.
#    Click  xpath  //*[@id=\"default-acx-overlay-container\"]/div[1]/material-dialog/focus-trap/div[2]/div/main/div[2]/material-yes-no-buttons/material-button[1]/material-ripple
#    #Click product_type dropdown
#    Click  id  dropdown_kit_product_type
#    #Select desired product
#    Click  xpath  //material-select-item[contains(.,'San Diego Comparative trial')]
#    #Click trial dropdown
#    #Click  id  dropdown_kit_trial
#    #Select desired  trial
#    #Click  xpath  //material-select-item[contains(.,'San Diego comparative trial')]
#    #Click for entering no of kits
#    Click  xpath  //*[@id="widgetkitreq_input_noofkits"]/div[1]/div[1]/label/input
#    #Enter the number of kits for the user
#    Enter Text  xpath  //*[@id="widgetkitreq_input_noofkits"]/div[1]/div[1]/label/input  2
#    #Click on button Request Kit
#    Click  id  widgetkitreq_btn_requestkit
#    #Click on OK button, on the active x window.
#    Click  id  widgetkitreq_btn_okinput
#    #Wait for some time for screen to come up
#    Sleep  2
#    #Close the Browser being used for test.
#    Close Browser


AT_MED_02
#Test case to verify test results for kit id : QT36

    #Generate  token for admin user
    Create Admin Authentication Endpoint  _admin@qvin.com  secret  123  EMAIL
    #Generate  token for logistics user
    Create Logistics Authentication Endpoint  _logistics@qvin.com  secret  123  EMAIL
    #Generate  token for doctor
    Create Doctor Authentication Endpoint  _doctor@qvin.com  secret  123  EMAIL

    Download Excel from Cloud   tdc-data    Test Data for TDC.xlsx   ./data/Test Data for TDC.xlsx     qurasense-test-tdc-sa.json

    ${requestApproval}  Set Variable  Approved
    ${resultApproval}   Set Variable  Approved

    Log    Read from CSV started..

    #Converting TDC Customers worksheet to CSV from Test Data for TDC xlsx file.
    ${tdcCustomer}   Convert Excel to CSV    ${test_data}  Customers Result

    #Reading created csv and logging to console
    ${csv_file}    Reading CSV   ${tdcCustomer}
    log  ${csv_file}

    #Getting feild names from the above csv
    ${feild_names}  Set Variable  ${csv_file}[0]

    #Searching cell of a particular kit id
    ${kitId_location}   search cell   ${tdcCustomer}   QT36
    #Fetching row and column of the kit id
    ${row}   set variable  ${kitId_location}[row]
    ${column}   set variable  ${kitId_location}[column]

    #Getting results row for particular  kit id
    ${results}   Set Variable  ${csv_file}[${row}]
    #Getting row length
    ${result_length}  Get length  ${results}

    #Fetch bundle name
    ${bundleName}  Set Variable  ${results}[3]

    #Getting chloride value from results
    ${chlorideValue}  set variable  ${results}[7]


    #Creation list for populated results location
    ${result_index}   Create List
    FOR  ${i}   IN RANGE  8  ${result_length}
        ${assay}  Set variable  ${feild_names}[${i}]
        log  ${assay}
        ${condition}  Run Keyword And Return Status    Should Contain Any   "${assay}"   [Result Approval]  [Request Approval]  #    is aEvaluate  "Approval]" in "${assay}"
        IF  ${condition} == False
            ${value}   Set Variable      ${results}[${i}]
            log  ${value}
            ${length}  Get length  ${value}
            RUN KEYWORD IF  ${length}>0    Append to List   ${result_index}  ${i}
        ELSE
            Log  "${assay}"
        END
    END
    Log  ${result_index}

    #Creating lists for calculated test names and their results
    ${testName_list}   Create List
    ${calcutedResults}  Create List

    #Geting result data from csv and appending fetched data to list
    Get Result Data From CSV   ${testName_list}   ${calcutedResults}    ${chlorideValue}   ${result_index}   ${results}  ${feild_names}
    log  ${calcutedResults}
    log  ${testName_list}




    # Navigate to browser with desired capabilities like console logs etc
    #Navigate To With Chrome Option And Desired Capabilities  ${BROWSER}  ${DASHBOARD_URL}
    Navigate To  ${BROWSER}  ${DASHBOARD_URL}
    #Open Browser  ${DASHBOARD_URL}  ${BROWSER}
    #Click Login Link on main screen
    #Click  link  Login
    #Click username
    Click  css  input[type='text']
    #Enter username
    Enter Text  css  input[type='text']  _doctor@qvin.com
    #Click password
    Click  css  input[type='password']
    #Enter password
    Enter Text  css  input[type='password']  secret
    #Click Login button
    Click  xpath  /html/body/app/site/div/login/section/form/div/material-button/material-ripple
    #Click Login button
    Click  id  login_btn_signin
    #Wait for some time for 2fa input to come up
    Sleep  2
    #Click 2facode input text
    Click  id  login_input_2facode
    #Enter 2FA code
    Enter Text  xpath  //*[@id="login_input_2facode"]/div[1]/div[1]/label/input  123
    #Click Login button
    Click  id  login_btn_signin
    #Click analysis request
    Click  xpath  //*[@id="medicaldashboard_listitem_analysisrequests"]
    #click input
    Click  xpath  /html/body/app/medical/div/div/requests/section[2]/div[1]/section/material-input/div[1]/div[1]/label/input
    #enter text
    #Enter Text  xpath  /html/body/app/medical/div/div/requests/section[2]/div[1]/section/material-input/div[1]/div[1]/label/input  QT01
    Enter Text  xpath  //*[@id="medicalrequests_text_input"]/div[1]/div[1]/label/input   QT36
    #Tap RETURN key
    Send Keys  None  RETURN
    #Click Analysis id for kit
    Click  xpath  //*[@id="smart_table_medicalrequests"]/tbody/tr/td[1]/a
    # Verify kit id
    Verify Text In Locator  xpath  /html/body/app/medical/div/div/analysis-request-detail/div[2]/card[1]/div[2]/request-details/table/tr[3]/td[2]/a   QT36


    #Checking if correct values are appearing in the table
    ${testlist_len}  get length  ${testname_list}
    FOR  ${index}  IN RANGE  0  ${testlist_len}
        ${name}  Set Variable    ${testname_list}[${index}]
        ${result_val}  Set Variable  ${calcutedResults}[${index}]
        ${text}   Get Text From Table  xpath  //*[@id="analysisrequest_table_assay_results"]/div/div/table  NotApplicable   ${name}   4
        Verify Text in Table  xpath  //*[@id="analysisrequest_table_assay_results"]/div/div/table  NotApplicable  ${name}   3  ${requestApproval}
        Verify Text in Table  xpath  //*[@id="analysisrequest_table_assay_results"]/div/div/table  NotApplicable  ${name}   6  ${resultApproval}
        log  ${text}
        ${val}  Split String   ${text}  ${SPACE}
        Should be Equal  ${val}[0]  ${result_val}

    END

    #Closing browser
    Close Browser


AT_MED_03
#Test case to verify test results for kit id : QT46

    #Generate  token for admin user
    Create Admin Authentication Endpoint  _admin@qvin.com  secret  123  EMAIL
    #Generate  token for logistics user
    Create Logistics Authentication Endpoint  _logistics@qvin.com  secret  123  EMAIL
    #Generate  token for doctor
    Create Doctor Authentication Endpoint  _doctor@qvin.com  secret  123  EMAIL

    Download Excel from Cloud   tdc-data    Test Data for TDC.xlsx   ./data/Test Data for TDC.xlsx     qurasense-test-tdc-sa.json

    ${requestApproval}  Set Variable  Approved
    ${resultApproval}   Set Variable  Approved

    Log    Read from CSV started..

    #Converting TDC Customers worksheet to CSV from Test Data for TDC xlsx file.
    ${tdcCustomer}   Convert Excel to CSV    ${test_data}  Customers Result

    #Reading created csv and logging to console
    ${csv_file}    Reading CSV   ${tdcCustomer}
    log  ${csv_file}

    #Getting feild names from the above csv
    ${feild_names}  Set Variable  ${csv_file}[0]

    #Searching cell of a particular kit id
    ${kitId_location}   search cell   ${tdcCustomer}   QT46
    #Fetching row and column of the kit id
    ${row}   set variable  ${kitId_location}[row]
    ${column}   set variable  ${kitId_location}[column]

    #Getting results row for particular  kit id
    ${results}   Set Variable  ${csv_file}[${row}]
    #Getting row length
    ${result_length}  Get length  ${results}

    #Fetch bundle name
    ${bundleName}  Set Variable  ${results}[3]

    #Getting chloride value from results
    ${chlorideValue}  set variable  ${results}[7]


    #Creation list for populated results location
    ${result_index}   Create List
    FOR  ${i}   IN RANGE  8  ${result_length}
        ${assay}  Set variable  ${feild_names}[${i}]
        log  ${assay}
        ${condition}  Run Keyword And Return Status    Should Contain Any   "${assay}"   [Result Approval]  [Request Approval]  #    is aEvaluate  "Approval]" in "${assay}"
        IF  ${condition} == False
            ${value}   Set Variable      ${results}[${i}]
            log  ${value}
            ${length}  Get length  ${value}
            RUN KEYWORD IF  ${length}>0    Append to List   ${result_index}  ${i}
        ELSE
            Log  "${assay}"
        END
    END
    Log  ${result_index}

    #Creating lists for calculated test names and their results
    ${testName_list}   Create List
    ${calcutedResults}  Create List

    #Geting result data from csv and appending fetched data to list
    Get Result Data From CSV   ${testName_list}   ${calcutedResults}    ${chlorideValue}   ${result_index}   ${results}  ${feild_names}
    log  ${calcutedResults}
    log  ${testName_list}




    # Navigate to browser with desired capabilities like console logs etc
    #Navigate To With Chrome Option And Desired Capabilities  ${BROWSER}  ${DASHBOARD_URL}
    Navigate To  ${BROWSER}  ${DASHBOARD_URL}
    #Open Browser  ${DASHBOARD_URL}  ${BROWSER}
    #Click Login Link on main screen
    #Click  link  Login
    #Click username
    Click  css  input[type='text']
    #Enter username
    Enter Text  css  input[type='text']  _doctor@qvin.com
    #Click password
    Click  css  input[type='password']
    #Enter password
    Enter Text  css  input[type='password']  secret
    #Click Login button
    Click  xpath  /html/body/app/site/div/login/section/form/div/material-button/material-ripple
    #Click Login button
    Click  id  login_btn_signin
    #Wait for some time for 2fa input to come up
    Sleep  2
    #Click 2facode input text
    Click  id  login_input_2facode
    #Enter 2FA code
    Enter Text  xpath  //*[@id="login_input_2facode"]/div[1]/div[1]/label/input  123
    #Click Login button
    Click  id  login_btn_signin
    #Click analysis request
    Click  xpath  //*[@id="medicaldashboard_listitem_analysisrequests"]
    #click input
    Click  xpath  /html/body/app/medical/div/div/requests/section[2]/div[1]/section/material-input/div[1]/div[1]/label/input
    #enter text
    #Enter Text  xpath  /html/body/app/medical/div/div/requests/section[2]/div[1]/section/material-input/div[1]/div[1]/label/input  QT01
    Enter Text  xpath  //*[@id="medicalrequests_text_input"]/div[1]/div[1]/label/input   QT46
    #Tap RETURN key
    Send Keys  None  RETURN
    #Click Analysis id for kit
    Click  xpath  //*[@id="smart_table_medicalrequests"]/tbody/tr/td[1]/a
    # Verify kit id
    Verify Text In Locator  xpath  /html/body/app/medical/div/div/analysis-request-detail/div[2]/card[1]/div[2]/request-details/table/tr[3]/td[2]/a   QT46


    #Checking if correct values are appearing in the table
    ${testlist_len}  get length  ${testname_list}
    FOR  ${index}  IN RANGE  0  ${testlist_len}
        ${name}  Set Variable    ${testname_list}[${index}]
        ${result_val}  Set Variable  ${calcutedResults}[${index}]
        ${text}   Get Text From Table  xpath  //*[@id="analysisrequest_table_assay_results"]/div/div/table  NotApplicable   ${name}   4
        Verify Text in Table  xpath  //*[@id="analysisrequest_table_assay_results"]/div/div/table  NotApplicable  ${name}   3  ${requestApproval}
        Verify Text in Table  xpath  //*[@id="analysisrequest_table_assay_results"]/div/div/table  NotApplicable  ${name}   6  ${resultApproval}
        log  ${text}
        ${val}  Split String   ${text}  ${SPACE}
        Should be Equal  ${val}[0]  ${result_val}

    END

    #Closing browser
    Close Browser



AT_MED_04
#Test case to Approve Analysis request for kit(QT26) with multile assay

    #Generate  token for admin user
    Create Admin Authentication Endpoint  _admin@qvin.com  secret  123  EMAIL
    #Generate  token for logistics user
    Create Logistics Authentication Endpoint  _logistics@qvin.com  secret  123  EMAIL
    #Generate  token for doctor
    Create Doctor Authentication Endpoint  _doctor@qvin.com  secret  123  EMAIL

    Download Excel from Cloud   tdc-data    Test Data for TDC.xlsx   ./data/Test Data for TDC.xlsx     qurasense-test-tdc-sa.json
    Log    Read from CSV started..

    #Converting TDC Customers worksheet to CSV from Test Data for TDC xlsx file.
    ${tdcCustomer}   Convert Excel to CSV    ${test_data}  Customers Result

    #Reading created csv and logging to console
    ${csv_file}    Reading CSV   ${tdcCustomer}
    log  ${csv_file}

    #Getting feild names from the above csv
    ${feild_names}  Set Variable  ${csv_file}[0]

    #Searching cell of a particular kit id
    ${kitId_location}   search cell   ${tdcCustomer}   QT26
    #Fetching row and column of the kit id
    ${row}   set variable  ${kitId_location}[row]
    ${column}   set variable  ${kitId_location}[column]

    #Getting results row for particular  kit id
    ${results}   Set Variable  ${csv_file}[${row}]
    #Getting row length
    ${result_length}  Get length  ${feild_names}

    #Fetch bundle name
    ${bundleName}  Set Variable  ${results}[3]


    #Creation list for populated results location
    ${assay_list}   Create List
    FOR  ${i}   IN RANGE  8  25
        ${assay}  Set variable  ${feild_names}[${i}]
        log  ${assay}
        ${condition}  Run Keyword And Return Status    Should Contain Any   "${assay}"   [Request Approval]  #    is aEvaluate  "Approval]" in "${assay}"
        IF  ${condition} == True
            ${value}   Set Variable      ${feild_names}[${i}]
            log  ${value}
            ${assay_value}  Split String  ${value}  ${SPACE}\[
            ${assay_name}   Set Variable  ${assay_value}[0]
            ${length}  Get length  ${assay_name}
            RUN KEYWORD IF  ${length}>0    Append to List   ${assay_list}  ${assay_name}
        ELSE
            Log  "${assay_list}"
        END
    END

    #Creating lists for calculated test names and their results
    ${testName_list}   Create List
    ${calcutedResults}  Create List

    # Navigate to browser with desired capabilities like console logs etc
    #Navigate To With Chrome Option And Desired Capabilities  ${BROWSER}  ${DASHBOARD_URL}
    Navigate To  ${BROWSER}  ${DASHBOARD_URL}
    #Open Browser  ${DASHBOARD_URL}  ${BROWSER}
    #Click Login Link on main screen
    #Click  link  Login
    #Click username
    Click  css  input[type='text']
    #Enter username
    Enter Text  css  input[type='text']  _doctor@qvin.com
    #Click password
    Click  css  input[type='password']
    #Enter password
    Enter Text  css  input[type='password']  secret
    #Click Login button
    Click  xpath  /html/body/app/site/div/login/section/form/div/material-button/material-ripple
    #Click Login button
    Click  id  login_btn_signin
    #Wait for some time for 2fa input to come up
    Sleep  2
    #Click 2facode input text
    Click  id  login_input_2facode
    #Enter 2FA code
    Enter Text  xpath  //*[@id="login_input_2facode"]/div[1]/div[1]/label/input  123
    #Click Login button
    Click  id  login_btn_signin
    #Click analysis request
    Click  xpath  //*[@id="medicaldashboard_listitem_analysisrequests"]
    #click input
    Click  xpath  /html/body/app/medical/div/div/requests/section[2]/div[1]/section/material-input/div[1]/div[1]/label/input
    #enter text
    #Enter Text  xpath  /html/body/app/medical/div/div/requests/section[2]/div[1]/section/material-input/div[1]/div[1]/label/input  QT01
    Enter Text  xpath  //*[@id="medicalrequests_text_input"]/div[1]/div[1]/label/input   QT26
    #Tap RETURN key
    Send Keys  None  RETURN
    #Click Analysis id for kit
    Click  xpath  //*[@id="smart_table_medicalrequests"]/tbody/tr/td[1]/a
    # Verify kit id
    Verify Text In Locator  xpath  /html/body/app/medical/div/div/analysis-request-detail/div[2]/card[1]/div[2]/request-details/table/tr[3]/td[2]/a   QT26


    #Checking if correct values are appearing in the table
    ${testlist_len}  get length  ${assay_list}
    FOR  ${index}  IN RANGE  0  ${testlist_len}
        ${name}  Set Variable    ${assay_list}[${index}]
        ${request_approval}  Set Variable  Unapproved
         Set Analysis Approval  xpath  //*[@id="analysisrequest_table_assay_results"]/div/div/table  ${name}   3  ${request_approval}  //*[@id="assay_results_btn_approve_analysis"]
    END


    #Closing browser
    Close Browser

