*** Settings ***
Documentation  This is a test suite for Qurasense GUI Testing
Resource  ../data/GlobalVariables.robot
Resource    ../resources/PageActions.robot
Resource    ../resources/CustomActions.robot
*** Variables ***

*** Test Cases ***

ROBOT_LAB_01

    #Generate  token for admin user
    Create Admin Authentication Endpoint  _admin@qvin.com  secret  123  EMAIL
    #Generate  token for lab user
    Create Lab Authentication Endpoint  _lab@qvin.com  secret  123  EMAIL
    #Generate  token for customer
    Create Customer Authentication Endpoint  _customermobapp@qvin.com  secret  123  EMAIL
    #Create Logistics Authentication Endpoint
    Create Logistics Authentication Endpoint    _logistics@qvin.com  secret  123  EMAIL
    ### Matrix TC-454 Starts Here###
    #Open Browser and navigate to the desired URL
    Navigate To And Verify  ${BROWSER}  ${TEST_ENV}  Qvin
    #Click username
    Click  css  input[type='text']
    #Enter username
    Enter Text  css  input[type='text']  lab@qvin.com
    #Click password
    Click  css  input[type='password']
    #Enter password
    Enter Text  css  input[type='password']  catecret
    #Click Login button
    Click  id  login_btn_signin
    #Wait for some time for 2fa input to come up
    Sleep  2
    #Verify user not find with this email
    Verify  Could not find user
    #Close Browser
    Close Browser
    ### Matrix TC-455 Starts Here###
    #Open Browser and navigate to the desired URL
    Navigate To And Verify  ${BROWSER}  ${TEST_ENV}  Qvin
    #Click password
    Click  css  input[type='password']
    #Enter password
    Enter Text  css  input[type='password']  secret
    #Click Login button
    Click  id  login_btn_signin
    #Wait for some time for 2fa input to come up
    Sleep  2
    #Verify email is required to login
    Verify  Username or email is required!
    #Close browser
    Close Browser
    ### Matrix TC-456 Starts Here###
    #Open Browser and navigate to the desired URL
    Navigate To And Verify  ${BROWSER}  ${TEST_ENV}  Qvin
    #Click username
    Click  css  input[type='text']
    #Enter username
    Enter Text  css  input[type='text']  _lab@qvin.com
    #Click Login button
    Click  id  login_btn_signin
    #Wait for some time for 2fa input to come up
    Sleep  2
    #Verify Password is required  for login
    Verify  Password is required!
    ### Matrix TC-460 Starts Here###
    #Click username
    Click  css  input[type='text']
    #Enter username
    Enter Text  css  input[type='text']  _lab@qvin.com
    #Click password
    Click  css  input[type='password']
    #Enter password
    Enter Text  css  input[type='password']  secret
    #Click Login button
    Click  id  login_btn_signin
    #Wait for some time for 2fa input to come up
    Sleep  2
    #Click Login button
    Click  id  login_btn_signin
    #Verify  Verification code not valid if 2fa not provided
    Verify  Verification code not valid
    #Sleep for some time
    Sleep  2
    #Click 2facode input text
    Click  id  login_input_2facode
    #Enter 2FA code
    Enter Text  xpath  //*[@id="login_input_2facode"]/div[1]/div[1]/label/input  123
    #Click Login button
    Click  id  login_btn_signin
    ## Matrix TC-470 Starts Here###
    #Verify Search for kits in left menu
    Verify Text In Locator  xpath  //*[@id="labdashboard_link_search"]    Search for Kit
    #Verify "Incoming" in left menu
    Verify Text In Locator  xpath  //*[@id="labdashboard_link_incoming"]  Incoming
    #Verify "Kits To Inspect" in left menu
    Verify Text In Locator  xpath  //*[@id="labdashboard_link_inspection"]  Kits To Inspect
    #Verify "Awaiting Analysis" in left menu
    Verify Text In Locator  xpath  //*[@id="labdashboard_link_awaiting"]   Awaiting Analysis
    #Verify "Import Results" in left menu
    Verify Text In Locator  xpath  //*[@id="labdashboard_link_imports"]   Import Results
    #Verify "Analysis Complete" in left menu
    Verify Text In Locator  xpath  //*[@id="labdashboard_link_complete"]   Analysis Complete
    #Verify "Analysis Failed" in left menu
    Verify Text In Locator  xpath  //*[@id="labdashboard_link_failed"]  Analysis Failed
    #Click on right top Setting icon
    Click  xpath  //*[@id="lab_main_menu"]/material-button
    #Verify signout button
    Verify  Sign Out
    #Verify Account Settings
    Verify  Account settings
    #Click overview on left menu
    Click  xpath  //*[@id="labdashboard_link_overview"]

    ### Matrix TC-471 starts here###
    #Get lab id for organisationType= LABORATORY  And name= US Speciality Labs
    ${labid}=  Get Lab ID   ${APP_VERSION}  ${TEST_ENV}  US Specialty Labs  LABORATORY
    # Verify the count displayed on UI for kits in Analysis type status = INSPECTION
    ${kitsCountFetched}=  Get Lab Kits Count  ${APP_VERSION}  ${TEST_ENV}  INSPECTION  ${labid}
    Sleep  3
    click element  id=labdashboard_kitAmt_toInspect
    ${kitsCountRead}=  get text  id=labdashboard_kitAmt_toInspect
    Should Be Equal As Strings    ${kitsCountRead}    ${kitsCountFetched}

    ### Matrix TC-472 starts here###
    # Verify the count displayed on UI for kits in Analysis type status = AWAITING_ANALYSIS
    ${kitsCountFetched}=  Get Lab Kits Count  ${APP_VERSION}  ${TEST_ENV}  AWAITING_ANALYSIS  ${labid}
    Sleep  3
    click element  id=labdashboard_kitAmt_awaitingAnalysis
    ${kitsCountRead}=  get text  id=labdashboard_kitAmt_awaitingAnalysis
    Should Be Equal As Strings    ${kitsCountRead}    ${kitsCountFetched}

    ### Matrix TC-473 starts here###
    # Verify the count displayed on UI for kits in Analysis type status = ANALYSIS_COMPLETE
    ${kitsCountFetched}=  Get Lab Kits Count  ${APP_VERSION}  ${TEST_ENV}  ANALYSIS_COMPLETE  ${labid}
    Sleep  3
    click element  id=labdashboard_kitAmt_analysisComplete
    ${kitsCountRead}=  get text  id=labdashboard_kitAmt_analysisComplete
    Should Be Equal As Strings    ${kitsCountRead}    ${kitsCountFetched}

    ### Matrix TC-474 starts here###
    # Verify the count displayed on UI for kits in Analysis type status = ANALYSIS_FAILED
    ${kitsCountFetched}=  Get Lab Kits Count  ${APP_VERSION}  ${TEST_ENV}  FAILED  ${labid}
    Sleep  3
    click element  id=labdashboard_kitAmt_analysisFailed
    ${kitsCountRead}=  get text  id=labdashboard_kitAmt_analysisFailed
    Should Be Equal As Strings    ${kitsCountRead}    ${kitsCountFetched}

    ###TC-86 starts here###
    #Click on Incoming
    Click  Xpath  //*[@id="labdashboard_link_incoming"]
    #Wait for the screen to show up
    Sleep  5
    #Click On Dropdown Button
    Click  xpath  //*[@id="labincomingrequests_table"]/div/paging/span[1]/material-dropdown-select/dropdown-button/div
    #Wait for the screen to show up
    Sleep  3
    #Select 50 from dropdown
    Click  xpath  //material-select-item[contains(.,'50')]
    #Wait for the screen to show up
    Sleep  3
    #get row count from incoming table
    ${rows}=  Get Table Row Count  xpath  //*[@id="labincomingrequests_table"]/div/div/table
    #Custom keyword to check kit status on lab dashboard
    Check Text In Table  //*[@id="labincomingrequests_table"]/div/div/table  ${rows}  3  In use  Confirmed by carrier  Shipped by customer

    ###TC-88 & TC-89 Starts Here###
    #get row count from incoming table
    ${rows}=  Get Table Row Count  xpath  //*[@id="labincomingrequests_table"]/div/div/table
    #Custom Keyword to check assay associated are correctly visible or not.
    Check Assay For Kits   ${APP_VERSION}  ${TEST_ENV}  //*[@id="labincomingrequests_table"]/div/div/table  ${rows}  2  4  1

    ### TC-90 Starts here ###
    Sleep  2
    ${rows}=  Get Table Row Count  xpath  //*[@id="labincomingrequests_table"]/div/div/table
    ${kit_list1}=  Get List From Table  //*[@id="labincomingrequests_table"]/div/div/table  ${rows}  2  1
    sort list  ${kit_list1}
    Click  xpath  //*[@id="tableheader_kitid"]
    Sleep  3
    Click  xpath  //*[@id="tableheader_kitid"]
    Sleep  3
    ${kit_list2}=  Get List From Table  //*[@id="labincomingrequests_table"]/div/div/table  ${rows}  2  1
    lists should be equal   ${kit_list1}  ${kit_list2}

    ###TC-91  Starts here###
    Sleep  2
    reverse list  ${kit_list1}
    Click  xpath  //*[@id="tableheader_kitid"]
    Sleep  3
    ${kit_list3}=  Get List From Table  //*[@id="labincomingrequests_table"]/div/div/table  ${rows}  2  1
    lists should be equal   ${kit_list1}  ${kit_list3}

    ####TC-80###Able to navigate to the Kits to Inspect screen.
    ####TC-94 starts here###
    Click  xpath  //*[@id="labdashboard_link_overview"]
    #Wait for some time for screen to come up
    Sleep  2
    #Click View Button under Kits to Inspect
    Click  id  labdashboard_btn_kitstoinspect
    #Wait for some time for screen to come up
    Sleep  3
    #Getting kit list from table
    ${rows}=  Get Table Row Count  xpath  //*[@id="labinspection_table"]/div/div/table
    ${kit_list}=  Get List From Table  //*[@id="labinspection_table"]/div/div/table  ${rows}  1  2
    #Check kit status
    Check UI Kit Status   ${APP_VERSION}  ${TEST_ENV}   ${kit_list}   DELIVERED_AT_LAB

    ### TC-96 Starts here ###
    Click  xpath  //*[@id="labdashboard_link_inspection"]
    Sleep  2
    #Click On Dropdown Button
    Click  xpath  //*[@id="labinspection_table"]/div/paging/span[1]/material-dropdown-select/dropdown-button/div
    #Wait for the screen to show up
    Sleep  3
    #Select 50 from dropdown
    Click  xpath  //material-select-item[contains(.,'50')]
    Sleep  8
    ${rows}=  Get Table Row Count  xpath  //*[@id="labinspection_table"]/div/div/table
    ${kit_list1}=  Get List From Table   //*[@id="labinspection_table"]/div/div/table  ${rows}  1  2
    Sleep  3
    sort list  ${kit_list1}
    Click  xpath  //*[@id="labinspection_table"]/div/div/table/thead/tr/th[1]
    Sleep  8
    Click  xpath  //*[@id="labinspection_table"]/div/div/table/thead/tr/th[1]
    Sleep  8
    ${rows}=  Get Table Row Count  xpath  //*[@id="labinspection_table"]/div/div/table
    ${kit_list2}=  Get List From Table   //*[@id="labinspection_table"]/div/div/table  ${rows}  1  2
    lists should be equal   ${kit_list1}  ${kit_list2}

    ###TC-97  Starts here###
    Sleep  5
    reverse list  ${kit_list1}
    Click  xpath  //*[@id="labinspection_table"]/div/div/table/thead/tr/th[1]
    Sleep  8
    ${rows}=  Get Table Row Count  xpath  //*[@id="labinspection_table"]/div/div/table
    ${kit_list3}=  Get List From Table  //*[@id="labinspection_table"]/div/div/table  ${rows}  1  2
    lists should be equal   ${kit_list1}  ${kit_list3}

    ####TC-98 and 99 Starts Here###
    #Get total rows in table
    ${rows}=  Get Table Row Count  xpath  //*[@id="labinspection_table"]/div/div/table
    #Check assay assciated with kits in total tows
    Check Assay For Kits   ${APP_VERSION}  ${TEST_ENV}  //*[@id="labinspection_table"]/div/div/table  ${rows}  1  3   2
    Sleep  5

    #TC-389 Starts here
    #Click on Overview
    Click  xpath  //*[@id="labdashboard_link_overview"]
    #Wait for some time for screen to come up
    Sleep  2
    #Click on search for kits
    Click  id  labdashboard_link_search
    #Wait for some time for screen to come up
    Sleep  2
    #click on search
    Click  xpath  //*[@id="searchinput_totalkits"]/div[1]/div[1]/label/input
    #sleep so that it enable input
    Sleep  2
    #Enter Kit name to search
    Enter Text  xpath  //*[@id="searchinput_totalkits"]/div[1]/div[1]/label/input  ES01
    #sleep so that input is given
    Sleep  2
    #Pressing RETURN key so tht it can search
    Send Keys  None  RETURN
    #sleep so that it load the searched kits
    Sleep  2
    ${ES01_TrackingID}=  Get Tracking Number  ${APP_VERSION}  ${TEST_ENV}  ES01
    Sleep  5
    #Verify page should contain
    Verify  ${ES01_TrackingID} (ES01)
    #Wait for some time for screen to come up
    Sleep  2
    #click on search
    Click  xpath  //*[@id="searchinput_totalkits"]/div[1]/div[1]/label/input
    #sleep so that it enable input
    Sleep  2
    #Enter Kit name to search
    Enter Text  xpath  //*[@id="searchinput_totalkits"]/div[1]/div[1]/label/input  MA05
    #sleep so that input is given
    Sleep  2
    #Pressing RETURN key so tht it can search
    Send Keys  None  RETURN
    #sleep so that it load the searched kits
    Sleep  2
    ${MA05_TrackingID}=  Get Tracking Number  ${APP_VERSION}  ${TEST_ENV}  MA05
    Sleep  5
    #Verify page should contain kit id
    Verify  ${MA05_TrackingID} (MA05)
    Sleep  5

    #TC-390 starts here
    #Click on Overview
    Click  xpath  //*[@id="labdashboard_link_overview"]
    #Wait for some time for screen to come up
    Sleep  2
    #Click on search for kits
    Click  id  labdashboard_link_search
    #Wait for some time for screen to come up
    Sleep  2
    #click on search
    Click  xpath  //*[@id="searchinput_totalkits"]/div[1]/div[1]/label/input
    #sleep so that it enable input
    Sleep  2
    #Enter PAD id to search
    Enter Text  xpath  //*[@id="searchinput_totalkits"]/div[1]/div[1]/label/input  ES02PAD1
    #sleep so that input is given
    Sleep  2
    #Pressing RETURN key so tht it can search
    Send Keys  None  RETURN
    #sleep so that it load the searched kits
    Sleep  2
    #Get tracking id
    ${ES02_trackingID}=  Get Tracking Number  ${APP_VERSION}  ${TEST_ENV}  ES02
    Sleep  5
    #Verify page should contain
    Verify  ${ES02_trackingID} (ES02)
    #Wait for some time for screen to come up
    Sleep  2
    #click on search
    Click  xpath  //*[@id="searchinput_totalkits"]/div[1]/div[1]/label/input
    #sleep so that it enable input
    Sleep  2
    #Enter PAD id  to search
    Enter Text  xpath  //*[@id="searchinput_totalkits"]/div[1]/div[1]/label/input  MA05PAD2
    #sleep so that input is given
    Sleep  2
    #Pressing RETURN key so tht it can search
    Send Keys  None  RETURN
    #sleep so that it load the searched kits
    Sleep  2
    #Get kit tracking id
    ${MA05_trackingID}=  Get Tracking Number  ${APP_VERSION}  ${TEST_ENV}  MA05
    Sleep  5
    #Verify page should contain kit id
    Verify  ${MA05_trackingID} (MA05)
    Sleep  5


    #TC-391
    #Click on Overview
    Click  xpath  //*[@id="labdashboard_link_overview"]
    #Wait for some time for screen to come up
    Sleep  2
    #Click on search for kits
    Click  id  labdashboard_link_search
    #Wait for some time for screen to come up
    Sleep  2
    #click on search
    Click  xpath  //*[@id="searchinput_totalkits"]/div[1]/div[1]/label/input
    #sleep so that it enable input
    Sleep  2
    #Enter Instock kit id to search
    Enter Text  xpath  //*[@id="searchinput_totalkits"]/div[1]/div[1]/label/input  Test2-080
    #sleep so that input is given
    Sleep  2
    #Pressing RETURN key so tht it can search
    Send Keys  None  RETURN
    #sleep so that it load the searched kits
    Sleep  2
    #Verify page should not contain
    Page should not contain  (Test2-080)
    #Wait for some time for screen to come up
    Sleep  2
    #click on search
    Click  xpath  //*[@id="searchinput_totalkits"]/div[1]/div[1]/label/input
    #sleep so that it enable input
    Sleep  2
    #Enter Instock kit id to search
    Enter Text  xpath  //*[@id="searchinput_totalkits"]/div[1]/div[1]/label/input  Test1-050
    #sleep so that input is given
    Sleep  2
    #Pressing RETURN key so tht it can search
    Send Keys  None  RETURN
    #sleep so that it load the searched kits
    Sleep  2
    #Verify page should not contain kit id
    Page should not contain  (Test1-050)

    Sleep  5


    #TC-107##TC-110
    #Click on Overview
    Click  xpath  //*[@id="labdashboard_link_overview"]
    #Wait for some time for screen to come up
    Sleep  2
    #Click View Button under Kits to Inspect
    Click  id  labdashboard_btn_kitstoinspect
    #Wait for some time for screen to come up
    Sleep  3
    #Click on Input bar
    Click  Xpath  //*[@id="searchinput_kitstoinspect"]/div[1]/div[1]/label/input
    #Enter Text in Input Bar
    Enter Text  Xpath  //*[@id="searchinput_kitstoinspect"]/div[1]/div[1]/label/input  MA10
    #Send keys
    Send Keys  None  RETURN
    #Click on Menu Action three dots
    Click  id  labinspection_menu_action
    #Click on Assign Kit button
    Click  xpath  //span[contains(.,'Inspect')]
    #Wait for some time for screen to come up
    Sleep  3
    #Click Submit button
    Click  id  inspect_dialog_btn_submit
    #Wait for some time for screen to come up
    Sleep  1
    ###TC-81##-Able to navigate to Awaiting Analysis screen
    ###Click Awaiting Analysis link
    Click  xpath  //*[@id="labdashboard_link_awaiting"]
    ##TC-124###
    #Click on Input bar
    Click  Xpath  //*[@id="searchinput_awaiting"]/div[1]/div[1]/label/input
    #Enter Text in Input Bar
    Enter Text  Xpath  //*[@id="searchinput_awaiting"]/div[1]/div[1]/label/input  MA10
    #Send keys
    Send Keys  None  RETURN
    #Search for the user and check the checkbox in the table
    Identify And Check Checkbox  xpath  //*[@id="labawaiting_table"]/div/div/table  /material-checkbox  MA10PAD1
    #Wait for some time for screen to come up
    Sleep  1
    ##TC-149##
    #Click Export button
    Click  xpath  //*[@id="export-spreadsheed"]
    #Wait for some time for screen to come up
    Sleep  1
    ${Date}=  Todays Date
    ${CollectionDate}=   Subtract time from date  ${Date}  4 hour
    ${RecivalTimeDate}=  Subtract time from date  ${Date}  2 hour
    ${legalid}=  Get Legal ID    ${APP_VERSION}  ${TEST_ENV}     _customermobapp@qvin.com
    ${humanId}=  Get Human ID  ${APP_VERSION}  ${TEST_ENV}  ${legalid}
    Log  ${humanId}
    ###TC-156###TC-167##
    #Based on kit to be analysed, create IMPORT XL, based on kit, pad, assay results
    Create Assay Result Import XL Rows  ${APP_VERSION}  ${TEST_ENV}  App  Customer_Mob  ${humanId}  January 10,1985  36  Female  MA10  MA10PAD2  12345  2  ${CollectionDate}  ${CollectionDate}  ${RecivalTimeDate}  HbA1c  Approved  Whole Blood  ${emptystring}  %  QNS  Comments
    #Click on Import results(TC-82-able to navigate to Import Results screen)
    ###and call API to Import the Assay Results
    Import Lab Results And Open Import Details  xpath  //*[@id="labdashboard_link_imports"]  ${APP_VERSION}  ${TEST_ENV}
    #Wait for some time for screen to come up
    Sleep  3
    #Check the assay result status
    Verify Text In Locator  xpath  //*[@id="assayresultimports_smart_table"]/div/div/table//tbody/tr/td[6]  Success
    #Check the assay name as provided in Assay Result XL
    Verify Text In Locator  xpath  //*[@id="assayresultimports_smart_table"]/div/div/table//tbody/tr/td[3]  HbA1c
    #Check the assay result value as provided in Assay Result XL
    Verify Text In Locator  xpath  //*[@id="assayresultimports_smart_table"]/div/div/table//tbody/tr/td[5]  Quantity not sufficient
    #Click Awaiting Analysis link
    Click  xpath  //*[@id="labdashboard_link_awaiting"]
    #Search for the user and check the checkbox in the table
    Identify And Check Checkbox  xpath  //*[@id="labawaiting_table"]/div/div/table  /material-checkbox  MA10PAD1
    #Wait for some time for screen to come up
    Sleep  1
    #Click Export button
    Click  xpath  //*[@id="export-spreadsheed"]
    #Wait for some time for screen to come up
    Sleep  1
    ${Date}=  Todays Date
    ${CollectionDate}=   Subtract time from date  ${Date}  4 hour
    ${RecivalTimeDate}=  Subtract time from date  ${Date}  2 hour
    ##TC-148###
    #Based on kit to be analysed, create IMPORT XL, based on kit, pad, assay results
    #Create Assay Result Import XL Rows  ${APP_VERSION}  ${TEST_ENV}  App  Customer_Mob  January 10,1985  36  Female  MA10  MA10PAD1  12345  ${CollectionDate}   ${RecivalTimeDate}  HbA1c  Approved  Whole Blood  8  %  ${emptystring}  Comments
    Create Assay Result Import XL Rows  ${APP_VERSION}  ${TEST_ENV}  App  Customer_Mob  ${humanId}  January 10,1985  36  Female  MA10  MA10PAD1  12345  2  ${CollectionDate}  ${CollectionDate}  ${RecivalTimeDate}  HbA1c  Approved  Whole Blood  8  %  ${emptystring}  Comments
    #Click on Import results and call API to Import the Assay Results
    Import Lab Results And Open Import Details  xpath  //*[@id="labdashboard_link_imports"]  ${APP_VERSION}  ${TEST_ENV}
    #Wait for some time for screen to come up
    Sleep  3
    ##TC-166##
    #Check the assay result status
    Verify Text In Locator  xpath  //*[@id="assayresultimports_smart_table"]/div/div/table//tbody/tr/td[6]  Success
    #Check the assay name as provided in Assay Result XL
    Verify Text In Locator  xpath  //*[@id="assayresultimports_smart_table"]/div/div/table//tbody/tr/td[3]  HbA1c
    #Check the assay result value as provided in Assay Result XL
    Verify Text In Locator  xpath  //*[@id="assayresultimports_smart_table"]/div/div/table//tbody/tr/td[5]  8
    #Click Analysis complete link
    ##TC-83##Able to navigate to Analysis Complete screen
    Click  xpath  //*[@id="labdashboard_link_complete"]
    #Click on Input Bar
    Click  Xpath  //*[@id="searchinput_complete"]/div[1]/div[1]/label/input
    #Enter text in input bar
    Enter Text  Xpath  //*[@id="searchinput_complete"]/div[1]/div[1]/label/input  MA10
    #send keys
    Send Keys  None  RETURN
    #Click on kit-id, from completed list
    click  Partial link  MA10
    #Check the analysis request status
    Wait Until Keyword Succeeds  5x  200ms  Verify Text In Locator  xpath  //*[@id="singleanalysisrequest_smart_table"]/div/div/table//tbody/tr/td[2]  Approved for release
    #Wait for some time for screen to come up
    Sleep  2
    #Click View List
    Click  id  labdashboard_link_inspection
    #Wait for some time for screen to come up
    Sleep  3
    #Click on Input bar
    Click  Xpath  //*[@id="searchinput_kitstoinspect"]/div[1]/div[1]/label/input
    #Enter Text in Input Bar
    Enter Text  Xpath  //*[@id="searchinput_kitstoinspect"]/div[1]/div[1]/label/input  MA02
    #Send keys
    Send Keys  None  RETURN
    #Wait for some time for screen to come up
    Sleep  3
    #Click on Menu Action three dots
    Click  id  labinspection_menu_action
    #Click on Assign Kit button
    Click  xpath  //span[contains(.,'Inspect')]
    #Wait for some time for screen to come up
    Sleep  3
    #Click on insufficient sample checkbox for pad
    Click  id  Q_WHOLE_BLOODMA02PAD1-insufficient
    #Click on damaged checkbox for pad
    Click  id  Q_WHOLE_BLOODMA02PAD2-damaged
    #Click Submit button
    Click  id  inspect_dialog_btn_submit
    #Wait for some time for screen to come up
    Sleep  1
    #Click YES on Inspect warning dialog
    Click  id  inspect_dialog_btn_yes
    #Wait for some time for screen to come up
    Sleep  2
    ##TC-189###TC-190###TC##TC-191##
    #Click Analysis Failed link
    Click  xpath  //*[@id="labdashboard_link_failed"]
    #Click on Input Bar
    Click  Xpath  //*[@id="searchinput_failed"]/div[1]/div[1]/label/input
    #Enter text in input bar
    Enter Text  Xpath  //*[@id="searchinput_failed"]/div[1]/div[1]/label/input  MA02
    #send keys
    Send Keys  None  RETURN
    #Verify the text in table
    Verify Text In Table  xpath  //*[@id="labfaildrqst_table"]/div/div/table  NotApplicable  MA02PAD1  5  Rejected
    #Verify the text in table
    #Verify Text In Table  xpath  //*[@id="labfaildrqst_table"]/div/div/table  NotApplicable  MA02PAD1  6  Accepted
    #Click on kit-id, from completed list
    Click  partial link  MA02
    Wait Until Element Is Enabled    //*[@id="singleanalysisrequest_smart_table"]/div/div/table
    #Check the analysis request status
    Wait Until Keyword Succeeds  5x  200ms  Verify Text In Locator  xpath  //*[@id="singleanalysisrequest_smart_table"]/div/div/table//tbody/tr/td[2]  Failed
    #Wait for some time for screen to come up
    Sleep  2
    #Close the Browser being used for test.
    Close Browser

ROBOT_LAB_02
    #Open Browser and navigate to the desired URL
    Navigate To And Verify  ${BROWSER}  ${TEST_ENV}  Qvin
    #Click username
    Click  css  input[type='text']
    #Enter username
    Enter Text  css  input[type='text']  _lab@qvin.com
    #Click password
    Click  css  input[type='password']
    #Enter password
    Enter Text  css  input[type='password']  secret
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
    #Wait for some time for screen to come up
    Sleep  2
    ###TC-104, TC-105,###TC-132###
    #Click View Button under Kits to Inspect
    Click  id  labdashboard_btn_kitstoinspect
    #Wait for some time for screen to come up
    Sleep  3
    #Click on Input bar
    Click  Xpath  //*[@id="searchinput_kitstoinspect"]/div[1]/div[1]/label/input
    #Enter Text in Input Bar
    Enter Text  Xpath  //*[@id="searchinput_kitstoinspect"]/div[1]/div[1]/label/input  MA09
    #Send keys
    Send Keys  None  RETURN
    #Wait for some time for screen to come up
    Sleep  3
    ##TC-196###
    ##Search for the user and check the checkbox in the table, for shipping the kits
    Click  id  labinspection_menu_action
    #Click on Click on the three dots for any kit
    Click  xpath  //span[contains(.,'Pouch is empty')]
    #Wait for some time for screen to come up
    Sleep  3
    #Click Submit button
    Click  xpath  //material-button[contains(.,'Yes')]
    #Wait for some time for screen to come up
    Sleep  1
    #Click Analysis Failed link
    Click  xpath  //*[@id="labdashboard_link_failed"]
    #Verify the text in table
    Verify Text In Table  xpath  //*[@id="labfaildrqst_table"]/div/div/table  NotApplicable  MA09PAD1  3  Pouch empty
    #Wait for some time for screen to come up
    Sleep  2
    ##TC-106##TC-197##
    #Click View Button under Kits to Inspect
    Click  id  labdashboard_link_inspection
    #Wait for some time for screen to come up
    Sleep  3
    #Click on Input bar
    Click  Xpath  //*[@id="searchinput_kitstoinspect"]/div[1]/div[1]/label/input
    #Enter Text in Input Bar
    Enter Text  Xpath  //*[@id="searchinput_kitstoinspect"]/div[1]/div[1]/label/input  MA08
    #Send keys
    Send Keys  None  RETURN
    #Wait for some time for screen to come up
    Sleep  3
    #Search for the user and check the checkbox in the table, for shipping the kits
    Click  id  labinspection_menu_action
    #Click on Assign Kit button
    Click  xpath  //span[contains(.,'Kit not delivered')]
    #Wait for some time for screen to come up
    Sleep  3
    #Click Submit button
    Click  xpath  //material-button[contains(.,'Yes')]
    #Wait for some time for screen to come up
    Sleep  1
    #Click Analysis complete link
    Click  xpath  //*[@id="labdashboard_link_failed"]
    #Verify the text in table
    Verify Text In Table  xpath  //*[@id="labfaildrqst_table"]/div/div/table  NotApplicable  MA08PAD1  3  Not received
    #Wait for some time for screen to come up
    Sleep  2
    #Close the Browser being used for test.
    Close Browser

ROBOT_LAB_03
    #Open Browser and navigate to the desired URL
    #TC-453##TC-109##TC-113##
    Navigate To And Verify  ${BROWSER}  ${TEST_ENV}  Qvin
    #Click username
    Click  css  input[type='text']
    #Enter username
    Enter Text  css  input[type='text']  _lab@qvin.com
    #Click password
    Click  css  input[type='password']
    #Enter password
    Enter Text  css  input[type='password']  secret
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
    #Wait for some time for screen to come up
    Sleep  2
    ###TC##131
    #Click View Button under Kits to Inspect
    Click  id  labdashboard_btn_kitstoinspect
    #Wait for some time for screen to come up
    Sleep  3
    #Click on Input bar
    Click  Xpath  //*[@id="searchinput_kitstoinspect"]/div[1]/div[1]/label/input
    #Enter Text in Input Bar
    Enter Text  Xpath  //*[@id="searchinput_kitstoinspect"]/div[1]/div[1]/label/input  MA07
    #Send keys
    Send Keys  None  RETURN
    #Wait for some time for screen to come up
    Sleep  3
    #TC-100 starts here
    #Verify that Pad2 is on 1st order
    Verify Text In Table  xpath  //*[@id="labinspection_table"]/div/div/table  NotApplicable  MA07PAD2  5  1
    #Verify that Pad1 is on 2nd order
    Verify Text In Table  xpath  //*[@id="labinspection_table"]/div/div/table  NotApplicable  MA07PAD1  5  2
    Sleep  3
    #Search for the kit, click on 3 dots
    Click  id  labinspection_menu_action
    #Click on INSPECT button
    Click  xpath  //span[contains(.,'Inspect')]
    #Wait for some time for screen to come up
    Sleep  3
    #Click blood insufficient
    Click  id  Q_WHOLE_BLOODMA07PAD1-insufficient
    #Click  id  Q_PLASMAMA07PAD1-insufficient
    #Wait for some time for screen to come up
    Sleep  1
    #Click Submit button
    Click  id  inspect_dialog_btn_submit
    #Wait for some time for screen to come up
    Sleep  3
    #Click Yes button
    Click  id  inspect_dialog_btn_yes
    #Wait for some time for screen to come up
    Sleep  7
    #Click Awaiting Analysis link
    Click  xpath  //*[@id="labdashboard_link_awaiting"]
    #Search for the user and check the checkbox in the table
    Identify And Check Checkbox  xpath  //*[@id="labawaiting_table"]/div/div/table  /material-checkbox  MA07PAD2
    #Wait for some time for screen to come up
    Sleep  1
    #Click Export button
    Click  xpath  //*[@id="export-spreadsheed"]
    #Wait for some time for screen to come up
    Sleep  1
    #Generate  token for lab user
    Create Lab Authentication Endpoint  _lab@qvin.com  secret  123  EMAIL
    #Generate  token for customer
    Create Customer Authentication Endpoint  _customermobapp@qvin.com  secret  123  EMAIL
    ${Date}=  Todays Date
    ${CollectionDate}=   Subtract time from date  ${Date}  4 hour
    ${RecivalTimeDate}=  Subtract time from date  ${Date}  2 hour
    ${legalid}=  Get Legal ID    ${APP_VERSION}  ${TEST_ENV}     _customermobapp@qvin.com
    ${humanId}=  Get Human ID  ${APP_VERSION}  ${TEST_ENV}  ${legalid}
    Log  ${humanId}
    #Based on kit to be analysed, create IMPORT XL, based on kit, pad, assay results
    #Create Assay Result Import XL Rows  ${APP_VERSION}  ${TEST_ENV}  App  Customer_Mob  January 10,1985  36  Female  MA07  MA07PAD2  12345  ${CollectionDate}   ${RecivalTimeDate}  HbA1c  Approved  Whole Blood  ${emptystring}  %  Hemolysis  Comments
    Create Assay Result Import XL Rows  ${APP_VERSION}  ${TEST_ENV}  App  Customer_Mob  ${humanId}  January 10,1985  36  Female  MA07  MA07PAD2  12345  2  ${CollectionDate}  ${CollectionDate}  ${RecivalTimeDate}  HbA1c  Approved  Whole Blood  ${emptystring}  %  Hemolysis  Comments
    #Click on Import results and call API to Import the Assay Results
    Import Lab Results And Open Import Details  xpath  //*[@id="labdashboard_link_imports"]  ${APP_VERSION}  ${TEST_ENV}
    #Wait for some time for screen to come up
    Sleep  3
    #Check the assay result status
    Verify Text In Locator  xpath  //*[@id="assayresultimports_smart_table"]/div/div/table//tbody/tr/td[6]  Success
    #Click Analysis failure link
    Click  xpath  //*[@id="labdashboard_link_failed"]
    #Click on Input Bar
    Click  Xpath  //*[@id="searchinput_failed"]/div[1]/div[1]/label/input
    #Enter text in input bar
    Enter Text  Xpath  //*[@id="searchinput_failed"]/div[1]/div[1]/label/input  MA07
    #send keys
    Send Keys  None  RETURN
    #Wait for some time for screen to come up
    Sleep  5
    #Verify the text in table
    Verify Text In Table  xpath  //*[@id="labfaildrqst_table"]/div/div/table  NotApplicable  MA07PAD2  3  Analysis failed
    #Click on kit-id, from completed list
    Click  partial link  MA07
    Wait Until Element Is Enabled  //*[@id="singleanalysisrequest_smart_table"]/div/div/table
    #Check the analysis request status
    Verify Text In Locator  xpath  //*[@id="singleanalysisrequest_smart_table"]/div/div/table//tbody/tr/td[2]  Failed
    #Wait for some time for screen to come up
    Sleep  2
    #Click Link Kits to Inspect
    Click  id  labdashboard_link_inspection
    #Wait for some time for screen to come up
    Sleep  3
    #Click on Input bar
    Click  Xpath  //*[@id="searchinput_kitstoinspect"]/div[1]/div[1]/label/input
    #Enter Text in Input Bar
    Enter Text  Xpath  //*[@id="searchinput_kitstoinspect"]/div[1]/div[1]/label/input  MA06
    #Send keys
    Send Keys  None  RETURN
    #Wait for some time for screen to come up
    Sleep  3
    #Search for the kit, click on INSPECT in 3 dots
    Click  id  labinspection_menu_action
    #Click on Assign Kit button
    Click  xpath  //span[contains(.,'Inspect')]
    #Wait for some time for screen to come up
    Sleep  3
    #Click whole blood damaged
    Click  id  Q_WHOLE_BLOODMA06PAD2-damaged
    #Click  id  Q_PLASMAMA06PAD2-damaged
    #Wait for some time for screen to come up
    Sleep  3
    #Click on Device is missing checkbox
    Click  id  MA06PAD1-missing
    #Wait for some time for screen to come up
    Sleep  1
    #Click Submit button
    Click  id  inspect_dialog_btn_submit
    #Wait for some time for screen to come up
    Sleep  3
    #Click Yes button
    Click  id  inspect_dialog_btn_yes
    #Wait for some time for screen to come up
    Sleep  5
    #Click Analysis failure link
    Click  xpath  //*[@id="labdashboard_link_failed"]
    #Click on Input Bar
    Click  Xpath  //*[@id="searchinput_failed"]/div[1]/div[1]/label/input
    #Enter text in input bar
    Enter Text  Xpath  //*[@id="searchinput_failed"]/div[1]/div[1]/label/input  MA06
    #send keys
    Send Keys  None  RETURN
    #Wait for some time for screen to come up
    Sleep  5
    #Verify the text in table
    Verify Text In Table  xpath  //*[@id="labfaildrqst_table"]/div/div/table  NotApplicable  MA06PAD2  3  Inspection failed
    #Click on kit-id, from completed list
    Click  partial link  MA06
    Wait Until Element Is Enabled  //*[@id="singleanalysisrequest_smart_table"]/div/div/table
    #Check the analysis request status
    Wait Until Keyword Succeeds  5x  200ms    Verify Text In Locator  xpath  //*[@id="singleanalysisrequest_smart_table"]/div/div/table//tbody/tr/td[2]  Failed
    #Wait for some time for screen to come up
    Sleep  2
    #Click Analysis failure link
    Click  xpath  //*[@id="labdashboard_link_failed"]
    #Wait for some time for screen to come up
    Sleep  3
    #click on search
    Click  xpath  //*[@id="searchinput_failed"]/div[1]/div[1]/label/input
    #Enter Kit-id to search
    Enter Text  xpath  //*[@id="searchinput_failed"]/div[1]/div[1]/label/input  ES19
    #sleep so that input is given
    Sleep  2
    #Pressing RETURN key so tht it can search
    Send Keys  None  RETURN
     #sleep so that it load the searched kits
    Sleep  2
    #verify Kit id should display
    Wait until page does not contain  ES19PAD1
    #Wait for some time for screen to come up
    Sleep  2
    #Close the Browser being used for test.
    Click  id  labdashboard_link_incoming
    Sleep  2
    Enter Text  xpath  //material-input[@id='searchinput_incoming']/div/div/label/input   ES19
    Send Keys  None  RETURN
    Sleep  2
    Verify  Confirmed by carrier
    Sleep  2
    Close Browser

ROBOT_LAB_04

    Create Admin Authentication Endpoint  _admin@qvin.com  secret  123  EMAIL
    #Generate  token for lab user
    Create Lab Authentication Endpoint  _lab@qvin.com  secret  123  EMAIL
    #Generate  token for customer
    Create Customer Authentication Endpoint  _customermobapp@qvin.com  secret  123  EMAIL
    #Create Logistics Authentication Endpoint
    Create Logistics Authentication Endpoint    _logistics@qvin.com  secret  123  EMAIL
    #Open Browser and navigate to the desired URL
    Navigate To And Verify  ${BROWSER}  ${TEST_ENV}  Qvin
    #Click username
    Click  css  input[type='text']
    #Enter username
    Enter Text  css  input[type='text']  _lab@qvin.com
    #Click password
    Click  css  input[type='password']
    #Enter password
    Enter Text  css  input[type='password']  secret
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
    #Wait for some time for screen to come up
    Sleep  2
    #TC-396 Starts here
    #Click View Button under Analysis failed
    ##TC-84###able to navigate to Analysis Failed screen
    ##TC-200###
    ##TC-482##
    Click  id  labdashboard_btn_analysisFailed
    #Wait for some time for screen to come up
    Sleep  3
    #click on search
    Click  xpath  //*[@id="searchinput_failed"]/div[1]/div[1]/label/input
    #Enter Kit-id to search
    Enter Text  xpath  //*[@id="searchinput_failed"]/div[1]/div[1]/label/input  KT03
    #sleep so that input is given
    Sleep  2
    #Pressing RETURN key so tht it can search
    Send Keys  None  RETURN
    #Get kit tracking id
    ${KT03_TrackingID}=  Get Tracking Number  ${APP_VERSION}  ${TEST_ENV}  KT03
    Sleep  5
    #Verify page should contain
    Verify  ${KT03_TrackingID} (KT03)
    #sleep so that it load the searched kits
    Sleep  2
    #verify Kit id should display
    Verify  KT03PAD1
    #Verify the text in table
    Verify Text In Table  xpath  //*[@id="labfaildrqst_table"]/div/div/table  NotApplicable  KT03PAD1  3  Kit was expired
    #Click on kit-id, from completed list
    Click  partial link  KT03
    Sleep  2
    #Verify kit status is failed
    Verify Text In Locator  xpath  //*[@id="analysisRequestStatus"]   Failed
    Wait Until Element Is Enabled  //*[@id="singleanalysisrequest_smart_table"]/div/div/table
    #Check the analysis request status
    Wait Until Keyword Succeeds  5x  200ms  Verify Text In Locator  xpath  //*[@id="singleanalysisrequest_smart_table"]/div/div/table//tbody/tr/td[2]  Failed
    #Wait for some time for screen to come up
    Sleep  2
    #Close the Browser being used for test.
    Close Browser

ROBOT_LAB_05
    #Matrix TC-93
    Create Admin Authentication Endpoint  _admin@qvin.com  secret  123  EMAIL
    #Generate  token for lab user
    Create Lab Authentication Endpoint  _lab@qvin.com  secret  123  EMAIL
    #Generate  token for customer
    Create Customer Authentication Endpoint  _customermobapp@qvin.com  secret  123  EMAIL
    #Create Logistics Authentication Endpoint
    Create Logistics Authentication Endpoint    _logistics@qvin.com  secret  123  EMAIL
    #Open Browser and navigate to the desired URL
    Navigate To And Verify  ${BROWSER}  ${TEST_ENV}  Qvin
    #Click username
    Click  css  input[type='text']
    #Enter username
    Enter Text  css  input[type='text']  _lab@qvin.com
    #Click password
    Click  css  input[type='password']
    #Enter password
    Enter Text  css  input[type='password']  secret
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
    #Wait for some time for screen to come up
    Sleep  2
    #Click on Incomming
    Click  id  labdashboard_link_incoming
    #sleep so that incoming kits load
    Sleep  2
    #TC-1566
    #Click on Search
    Click  xpath  //material-input[@id='searchinput_incoming']/div/div/label/input
    #sleep so that it enable input
    Sleep  2
    #Enter Kit name to search
    Enter Text  xpath  //material-input[@id='searchinput_incoming']/div/div/label/input  ES04
    #sleep so that input is given
    Sleep  2
    #Pressing RETURN key so tht it can search
    Send Keys  None  RETURN
    #sleep so that it load the searched kits
    Sleep  2
    ${trackingId}=  Get Tracking Number  ${APP_VERSION}  ${TEST_ENV}  ES04
    Sleep  5
    #verify Kit id should not display
    Verify  ${trackingId} (ES04)
    Sleep  2
    #Click on Analysis failed
    Click  id  labdashboard_link_failed
    Sleep  3
    #Verify page should not contain kit
    Page should not contain  ES04PAD1

    #Matrix TC-478 and TC-392

    #Click overview Button under lab dasboard
    Click  id  labdashboard_link_overview
    #Wait for some time for screen to come up
    Sleep  3
    #click on Incoming
    Click  id  labdashboard_link_incoming
    #Wait for some time for screen to come up
    Sleep  2
    #Click on Search
    Click  xpath  //material-input[@id='searchinput_incoming']/div/div/label/input
    #sleep so that it enable input
    Sleep  2
    #Enter Kit name to search
    Enter Text  xpath  //material-input[@id='searchinput_incoming']/div/div/label/input  ES05
    #sleep so that input is given
    Sleep  2
    #Pressing RETURN key so tht it can search
    send keys  None  RETURN

    #Get  kit Tracking ID
    ${ES05_TrackingID}=  Get Tracking Number  ${APP_VERSION}  ${TEST_ENV}  ES05
    Sleep  5
    #Verify page contain kit id
    Verify  ${ES05_TrackingID} (ES05)
    #Wait for some time for screen to come up
    Sleep  2
    #Click on KitId
    Click  partial link  ES05
    #Wait for some time for screen to come up
    Sleep  3
    #Verify Staus should be Created
    Verify Text In Locator  xpath  //*[@id="analysisRequestStatus"]  Created
    #Wait for some time for confirmation
    Sleep  3
#    #Verify Assay Staus should be Empty
#    Verify Text In Locator  xpath  //section[3]/section[2]/section   Empty
    #Wait for some time for confirmation
    Sleep  4
    #Matrix TC-126

    #Click overview Button under lab dasboard
    Click  id  labdashboard_link_overview
    #Wait for some time for screen to come up
    Sleep  3
    #click on search kits on laboratotory dashboard
    Click  id  labdashboard_link_search
    #Wait for some time for screen to come up
    Sleep  2
    #click on search
    Click  xpath  //*[@id="searchinput_totalkits"]/div[1]/div[1]/label/input
    #sleep so that it enable input
    Sleep  2
    #Enter Kit name to search
    Enter Text  xpath  //*[@id="searchinput_totalkits"]/div[1]/div[1]/label/input  ES05
    #sleep so that input is given
    Sleep  2
    #Pressing RETURN key so tht it can search
    Send Keys  None  RETURN
    #Wait for some time for screen to come up
    Sleep  2
    #clicking three dots
    Click  id  labsearch_menu_action
    #wait for the menu to come up
    Sleep  2
    #clicking on Deliver to lab on three dots menu
    Click  xpath  //span[contains(.,'Deliver to lab')]
    #wait for the screen to show up
    Sleep  2
    #clicking on deliver  to lab button on dialogue box
    Click  id  delivertolab_btn
    #wait for the screen to show up
    Sleep  2
    #click on kits to inspect
    Click  id  labdashboard_link_inspection
    #wait for the screen to show up
    Sleep  2
    #clicking on the search input bar
    Click  xpath  //*[@id="searchinput_kitstoinspect"]/div[1]/div[1]/label/input
    #sleep so that it enable input
    Sleep  2
    #input kit name to search
    Enter Text  xpath  //*[@id="searchinput_kitstoinspect"]/div[1]/div[1]/label/input  ES05
    #sleep so that input is given
    Sleep  2
    #Pressing RETURN key so tht it can search
    send keys  None  RETURN
    #Wait for some time for screen to come up
    Sleep  2
    #clicking on three dots
    Click  id  labinspection_menu_action
    #wait for the menu to come up
    Sleep  2
    #click on inspect button in three dots menu
    Click  xpath  //span[contains(.,'Inspect')]
    #Wait for some time for screen to come up
    Sleep  2
    #clicking on submit button on dialogue box
    Click  id  inspect_dialog_btn_submit
    #Wait for some time for screen to come up
    Sleep  5
    #click on awaiting analysis button
    Click  id  labdashboard_link_awaiting
    #Wait for some time for screen to come up
    Sleep  3
    #click on search
    Click  xpath  //input[@type='text']
    #sleep so that it enable input
    Sleep  3
    #entering kit name to search
    Enter Text  xpath  //input[@type='text']  ES05
    #sleep so that input is given
    Sleep  3
    #Pressing RETURN key so tht it can search
    Send Keys  None  RETURN
    #Wait for some time for screen to come up
    Sleep  3
    #verifying text in Table
    Verify Text In Table  xpath  //*[@id="labawaiting_table"]/div/div/table  NotApplicable  ES05PAD2  4  HbA1c
    #wait for some time for text to verify
    Sleep  3
    #Matrix TC-127

    #Click overview Button under lab dasboard
    Click  id  labdashboard_link_overview
    #Wait for some time for screen to come up
    Sleep  3
    #click on awaiting analysis button on lab dashboard
    Click  id  labdashboard_link_awaiting
    #Wait for some time for screen to come up
    Sleep  3
    #click on search
    Click  xpath  //*[@id="searchinput_awaiting"]/div[1]/div[1]/label/input
    #sleep so that it enable input
    Sleep  3
    #enter kit name to search
    Enter Text  xpath  //*[@id="searchinput_awaiting"]/div[1]/div[1]/label/input  ES05
    #sleep so that input is given
    Sleep  3
    #Pressing RETURN key so tht it can search
    Send Keys  None  RETURN
    #Wait for some time for screen to come up
    Sleep  3
    #verifying that it should appear on 1st order
    Verify Text In Locator  xpath  //*[@id="labawaiting_table"]/div/div/table/tbody/tr[1]/td[7]  ES05PAD2
    #wait for some time for text to verify
    Sleep  3
    #verifying that it should appear on 2nd order
    Verify Text In Locator  xpath  //*[@id="labawaiting_table"]/div/div/table/tbody/tr[2]/td[7]  ES05PAD1
    #wait for some time for text to verify
    Sleep  3
    ###TC-1129 starts here###
    #Generate  token for logistics user
    Create Logistics Authentication Endpoint  _logistics@qvin.com  secret  123  EMAIL
    #Generate  token for lab user
    Create Lab Authentication Endpoint  _lab@qvin.com  secret  123  EMAIL
    ${assayresultfilename}=  Export Assay Result XL For Kit  ${APP_VERSION}  ${TEST_ENV}  ES05  CONFIRMED_BY_LAB
    Verify Text In Excel  ${assayresultfilename}  ES05PAD2
    Verify Text Not In Excel  ${assayresultfilename}  ES05PAD1
    #TC-181 starts here
    #Getting recival time from excel
    ${RecivalTimeDate}=  Get Data From Excel  ${assayresultfilename}   Receival date
    ${Date}=  Todays Date
    ${CollectionDate}=   Subtract time from date  ${Date}  4 hour
    ${Recivaldate}=  convert to string  ${RecivalTimeDate}
    ${Recivaldate}=  get substring  ${Recivaldate}  0  10
    ${legalid}=  Get Legal ID    ${APP_VERSION}  ${TEST_ENV}     _customermobapp@qvin.com
    ${humanId}=  Get Human ID  ${APP_VERSION}  ${TEST_ENV}  ${legalid}
    Log  ${humanId}
    #Based on kit to be analysed, create IMPORT XL, based on kit, pad, assay results
    #Create Assay Result Import XL Rows  ${APP_VERSION}  ${TEST_ENV}  App  Customer_Mob  January 10,1985  36  Female  ES05  ES05PAD2  12345  ${CollectionDate}   ${RecivalTimeDate}  HbA1c  Approved  Whole Blood  5  %  ${emptystring}  Comments
    Create Assay Result Import XL Rows  ${APP_VERSION}  ${TEST_ENV}  App  Customer_Mob  ${humanId}  January 10,1985  36  Female  ES05  ES05PAD2  12345  2  ${CollectionDate}  ${CollectionDate}  ${RecivalTimeDate}  HbA1c  Approved  Whole Blood  5  %  ${emptystring}  Comments
    #Click on Import results and call API to Import the Assay Results
    Import Lab Results And Open Import Details  xpath  //*[@id="labdashboard_link_imports"]  ${APP_VERSION}  ${TEST_ENV}
    #Wait for some time for screen to come up
    Sleep  3
    #Check the assay result status
    Verify Text In Locator  xpath  //*[@id="assayresultimports_smart_table"]/div/div/table/tbody/tr/td[6]   Success
    ###TC-161 Here###
    #Verify text Spreadsheet Id in locator
    Verify Text In Locator  Xpath  /html/body/app/lab/div/div/import/section[3]/div/section[1]/div[2]/span[1]    Spreadsheet ID
    #Verify Text Day OF Import In locator
    Verify Text In locator  Xpath  /html/body/app/lab/div/div/import/section[3]/div/section[1]/div[2]/span[3]   Day of import
    #Verify status of import and value in locator
    Verify Text in Locator  Xpath  /html/body/app/lab/div/div/import/section[3]/div/section[1]/div[2]/span[5]   Status of import
    #TC-395 starts here
    #Click on Analysis complete button
    Click  xpath  //*[@id="labdashboard_link_complete"]
    #Enter kit id in input bar
    Enter Text  xpath  //*[@id="searchinput_complete"]/div[1]/div[1]/label/input  ES05
    #Send RETURN key
    Send Keys  None  RETURN

    #get kit id
    ${kitstatus}=  Get Kit Status  ${APP_VERSION}  ${TEST_ENV}  ES05
    Sleep  2
    ${kitid}=  Get Kit ID  ${APP_VERSION}  ${TEST_ENV}  ES05   ${kitstatus}

#    # TC-1234;Check the Upcoming Event 'com.qurasense.communication.upcoming.AnalyzeReminderEvent' is state=Canceled for seqnum=1
#    Check Upcoming Event Message  ${APP_VERSION}  ${TEST_ENV}  'eventType'  com.qurasense.communication.upcoming.AnalyzeReminderEvent  'key'  ${kitid}   1  'state'  CANCELED

    #Get kit tracking id
    ${ES05_TrackingID}=  Get Tracking Number  ${APP_VERSION}  ${TEST_ENV}  ES05
    Sleep  5
    #Verify page should contain
    Verify  ${ES05_TrackingID} (ES05)
    #Click ES05 link
    Click  partial link  ES05
    Sleep  2
    #Verify kit status analysis complete
    Verify Text In Locator  xpath  //*[@id="analysisRequestStatus"]  Analysis complete
    ###TC-178 starts Here###
    #Wait for screen to come up
    Sleep  3
    Wait Until Element Is Enabled  //*[@id="singleanalysisrequest_smart_table"]/div/div/table
    #Verify text HbA1c as kit analysed for it.
    Wait Until Keyword Succeeds  5x  200ms  Verify Text In Table  xpath  //*[@id="singleanalysisrequest_smart_table"]/div/div/table  NotApplicable  Approved for release  1  HbA1c
    ###TC-175 Starts Here###
    #Get delivered date from Locator
    ${DeliveredDate}=   Wait Until Keyword Succeeds  5x  200ms  Get Text   //*[@id="analysisRequestTimings"]/div[1]
    #Getting Date from string
    ${DeliveredDate}=  Convert String To Date  ${DeliveredDate}  %b %d, %Y %H:%M
    ${DeliveredDate}=  Get Date From Date  ${DeliveredDate}
    #Gettin current time
    ${CurrentDate}=  todays date
    #Getting date from current time
    ${date}=  get date from date  ${CurrentDate}
    #dates should be same
    should be equal  ${DeliveredDate}  ${date}
    #Wait for screen to come up
    Sleep  3
    #Get analysis time form table
    ${AnalysisDatetime}=  Wait Until Keyword Succeeds  5x  200ms  Get Text From Table  xpath  //*[@id="singleanalysisrequest_smart_table"]/div/div/table  NotApplicable  HbA1c  4
    #Convert string to date and time
    ${AnalysisDateTime}=  Convert String To Date  ${AnalysisDatetime}  %b %d, %Y %H:%M
    #Getting Date from analysis time
    ${AnalysisDate}=  Get Date From Date  ${AnalysisDateTime}
    #Getting time from analysis time
    ${AnalysisTime}=  Get Substring  ${AnalysisDateTime}  11  19
    #Gettin current time
    ${CurrentDate}=  todays date
    #Getting date from current time
    ${date}=  get date from date  ${CurrentDate}
    #dates should be same
    should be equal  ${AnalysisDate}  ${date}
    #TC-182 starts here
    #Getting only time from currrent time
    ${currenttime}=  Get Substring  ${CurrentDate}  11
    #Getting time different from analysis time and current time
    ${time}=  Subtract time from time  ${currenttime}    ${AnalysisTime}   result_format=number
    #Should be true
    Should be true  ${time}<3600
    #TC-177  Starts here
    #Getting lab turn around time from UI
    ${labturnaround}=  Get Text  xpath=/html/body/app/lab/div/div/analysis-request-detail/section[2]/section[3]/section/div[6]/div[3]
    #Convert this to numbers to compare
    ${labturnaround}=  convert time   ${labturnaround}:00  result_format=number
    #Compare it from given time i.e 15minute to numbers
    should be equal as numbers  ${labturnaround}  900.0
    #Wait for some time for screen to come up
    Sleep  3
    #Close the Browser being used for test.
    Close Browser

ROBOT_LAB_06
    #Generate  token for logistics user
    Create Logistics Authentication Endpoint  _logistics@qvin.com  secret  123  EMAIL
    #Generate  token for lab user
    Create Lab Authentication Endpoint  _lab@qvin.com  secret  123  EMAIL
    #Open Browser and navigate to the desired URL
    Navigate To And Verify  ${BROWSER}  ${TEST_ENV}  Qvin
    #Click username
    Click  css  input[type='text']
    #Enter username
    Enter Text  css  input[type='text']  _lab@qvin.com
    #Click password
    Click  css  input[type='password']
    #Enter password
    Enter Text  css  input[type='password']  secret
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
    #Wait for some time for screen to come up
    Sleep  2
    #Click on Incomming
    Click  xpath  //*[@id="labdashboard_link_search"]
    #sleep so that incoming kits load
    Sleep  2
    #Click on Search
    Click  xpath  //*[@id="searchinput_totalkits"]/div/div/label/input
    #sleep so that it enable input
    Sleep  2
    #Enter Kit name to search
    Enter Text  xpath  //*[@id="searchinput_totalkits"]/div/div/label/input  ES11
    #sleep so that input is given
    Sleep  2
    #Pressing RETURN key so tht it can search
    Send Keys  None  RETURN
    #sleep so that it load the searched kits
    Sleep  2
    #click 3 dots menu in table
    Click  id  labsearch_menu_action
    #wait for the menu to come up
    Sleep  2
    ###TC-108 starts here###
    #clicking on Deliver to lab on three dots menu
    Click  xpath  //span[contains(.,'Deliver to lab')]
    #wait for the screen to show up
    Sleep  2
    #clicking on deliver  to lab button on dialogue box
    Click  id  delivertolab_btn
    #click on search for kits
    Click  xpath  //*[@id="labdashboard_link_search"]
    #click on input bar
    Click  xpath  //*[@id="searchinput_totalkits"]/div[1]/div[1]/label/input
    #enter text in input bar
    Enter Text  xpath  //*[@id="searchinput_totalkits"]/div[1]/div[1]/label/input  ES11
    #click RETURN key
    Send Keys  None  RETURN
    #veify status 'delivered to lab' to check.
    Verify Text In Table  xpath  //*[@id="labsearch_table"]/div/div/table  NotApplicable  Inspection  3  Delivered at lab
    #wait for the screen to show up
    Sleep  2
    #click on kits to inspect
    Click  id  labdashboard_link_inspection
    #wait for the screen to show up
    Sleep  2
    #clicking on the search input bar
    Click  xpath  //*[@id="searchinput_kitstoinspect"]/div[1]/div[1]/label/input
    #sleep so that it enable input
    Sleep  2
    ### Matrix testcase TC-111 starts here###
    ###TC-112###
    #input kit name to search
    Enter Text  xpath  //*[@id="searchinput_kitstoinspect"]/div[1]/div[1]/label/input  ES11
    #sleep so that input is given
    Sleep  2
    #Pressing RETURN key so tht it can search
    send keys  None  RETURN
    Verify  ES11PAD1
    #wait for the screen to show up
    Sleep  2
    #click on kits to inspect
    Click  id  labdashboard_link_inspection
    #wait for the screen to show up
    Sleep  2
    #clicking on the search input bar
    Click  xpath  //*[@id="searchinput_kitstoinspect"]/div[1]/div[1]/label/input
    #sleep so that it enable input
    Sleep  2
    #input kit name to search
    Enter Text  xpath  //*[@id="searchinput_kitstoinspect"]/div[1]/div[1]/label/input  ES11PAD1
    #sleep so that input is given
    Sleep  2
    #Pressing RETURN key so tht it can search
    send keys  None  RETURN
    Verify  ES11PAD1
    #Search for the kit, click on INSPECT in 3 dots
    Click  id  labinspection_menu_action
    #Click on Inspect button
    ##Click TC-477###
    Click  xpath  //span[contains(.,'Inspect')]
    #Wait for some time for screen to come up
    Sleep  3
    #Click pad missing
    Click  id  ES11PAD2-missing
    #Wait for some time for screen to come up
    Sleep  3
    #Click on Device is missing checkbox
    Click  id  ES11PAD1-missing
    #Wait for some time for screen to come up
    Sleep  1
    #Click Submit button
    Click  id  inspect_dialog_btn_submit
    #Wait for some time for screen to come up
    Sleep  3
    #Click Yes button
    Click  id  inspect_dialog_btn_yes
    #Wait for some time for screen to come up
    Sleep  7
    #Click Analysis failure link
    Click  xpath  //*[@id="labdashboard_link_failed"]
    #Click on Input Bar
    Click  Xpath  //*[@id="searchinput_failed"]/div[1]/div[1]/label/input
    #Enter text in input bar
    Enter Text  Xpath  //*[@id="searchinput_failed"]/div[1]/div[1]/label/input  ES11
    #send keys
    Send Keys  None  RETURN
    #Wait for some time for screen to come up
    Sleep  5
    #Verify the text in table
    Verify Text In Table  xpath  //*[@id="labfaildrqst_table"]/div/div/table  NotApplicable  ES11PAD2  3  Inspection failed
    #Click on kit-id, from completed list
    Click  partial link  ES11
    #Check the analysis request status
    Verify Text In Locator  xpath  //*[@id="analysisRequestStatus"]  Failed
    #Wait for some time for screen to come up
    Sleep  2
    #click on search for kits button
    Click  xpath  //*[@id="labdashboard_link_search"]
    #wait for screen to come up
    Sleep  2
    #click on input bar
    Click  xpath  //*[@id="searchinput_totalkits"]/div/div/label/input
    #enter text in input bar
    Enter Text  xpath  //*[@id="searchinput_totalkits"]/div/div/label/input  ES11
    #send Return key
    Send Keys  None  RETURN
    #wait for screen to come up
    Sleep  2
    #verify text in column Analysis request Status is Failed
    Verify Text In Table  xpath  //*[@id="labsearch_table"]/div/div/table  NotApplicable  Confirmed by lab  4  Failed
    #verify text in column Kit Status is Confirmed by lab
    #Verify Text In Table  xpath  //*[@id="labsearch_table"]/div/div/table  NotApplicable  ES11PAD2  3  Confirmed by lab
    #sleep for some time to confirm confirm action
    Sleep  10
    #Click on Incomming
    Click  xpath  //*[@id="labdashboard_link_search"]
    #sleep so that incoming kits load
    Sleep  2
    #Click on Search
    Click  xpath  //*[@id="searchinput_totalkits"]/div/div/label/input
    #sleep so that it enable input
    Sleep  2
    #Enter Kit name to search
    Enter Text  xpath  //*[@id="searchinput_totalkits"]/div/div/label/input  ES12
    #sleep so that input is given
    Sleep  2
    #Pressing RETURN key so tht it can search
    Send Keys  None  RETURN
    #sleep so that it load the searched kits
    Sleep  2
    #click 3 dots menu in table
    Click  id  labsearch_menu_action
    #wait for the menu to come up
    Sleep  2
    #clicking on Deliver to lab on three dots menu
    Click  xpath  //span[contains(.,'Deliver to lab')]
    #wait for the screen to show up
    Sleep  2
    #clicking on deliver  to lab button on dialogue box
    Click  id  delivertolab_btn
    #wait for the screen to show up
    Sleep  2
    #click on kits to inspect
    Click  id  labdashboard_link_inspection
    #wait for the screen to show up
    Sleep  2
    #clicking on the search input bar
    Click  xpath  //*[@id="searchinput_kitstoinspect"]/div[1]/div[1]/label/input
    #sleep so that it enable input
    Sleep  2
    #input kit name to search
    Enter Text  xpath  //*[@id="searchinput_kitstoinspect"]/div[1]/div[1]/label/input  ES12
    #sleep so that input is given
    Sleep  2
    #Pressing RETURN key so tht it can search
    send keys  None  RETURN
    #wait for the screen to show up
    Sleep  2
    #click on kits to inspect
    Click  id  labdashboard_link_inspection
    #wait for the screen to show up
    Sleep  2
    #clicking on the search input bar
    Click  xpath  //*[@id="searchinput_kitstoinspect"]/div[1]/div[1]/label/input
    #sleep so that it enable input
    Sleep  2
    ###TC-397 starts here###
    #input kit name to search
    Enter Text  xpath  //*[@id="searchinput_kitstoinspect"]/div[1]/div[1]/label/input  ES12PAD1
    #sleep so that input is given
    Sleep  2
    #Pressing RETURN key so tht it can search
    send keys  None  RETURN
    Sleep  2
    #Search for the kit, click on INSPECT in 3 dots
    Click  id  labinspection_menu_action
    #Click on Inspect button
    Click  xpath  //span[contains(.,'Inspect')]
    #Wait for some time for screen to come up
    Sleep  3
    #check if there is any plasma strip in dialogue box
    element should not contain  //*[@id="default-acx-overlay-container"]/div[6]/material-dialog  Q-Plasma
    #check for whole blood strip is in dialogue box
    Wait Until Keyword Succeeds  5x  200ms  element should contain  //*[@id="default-acx-overlay-container"]/div[6]/material-dialog   Q-Whole blood
    #Wait for some time for screen to come up
    Sleep  3
    #Click on Device is missing checkbox
    Click  id  ES12PAD2-missing
    #Wait for some time for screen to come up
    Sleep  1
    #Click Submit button
    Click  id  inspect_dialog_btn_submit
    #Wait for some time for screen to come up
    Sleep  3
    ###TC-114 starts here###
    #to check whole blood accepted for second kit  on 1st Order

#    Wait Until Keyword Succeeds  5x  200ms  element should contain  //*[@id="default-acx-overlay-container"]/div[8]/material-dialog/focus-trap/div[2]/div/main/section[1]/div   Q-Whole blood: REJECTED (HbA1c)
#    #to check whole blood rejected for first kit on 2nd order
#    Wait Until Keyword Succeeds  5x  200ms  element should contain  //*[@id="default-acx-overlay-container"]/div[8]/material-dialog/focus-trap/div[2]/div/main/section[2]/div   Q-Whole blood: ACCEPTED (HbA1c)
    #Click Yes button
    Click  id  inspect_dialog_btn_yes
    #Wait for some time for screen to come up
    Sleep  5
    #Click on awaiting analysis button
    Click  id  labdashboard_link_awaiting
    #Wait for some time for screen to come up
    Sleep  3
    #click on search
    Click  xpath  //input[@type='text']
    #sleep so that it enable input
    Sleep  3
    #entering kit name to search
    Enter Text  xpath  //input[@type='text']  ES12
    #sleep so that input is given
    Sleep  3
    #Pressing RETURN key so tht it can search
    Send Keys  None  RETURN
    #Wait for some time for screen to come up
    Sleep  3
    #verifying text in Table
    Verify Text In Table  xpath  //*[@id="labawaiting_table"]/div/div/table  NotApplicable  ES12PAD2  4  HbA1c
    #wait for some time for text to verify
    Sleep  3
    ### Matrix  TC-173 starts here ###
    #Click ES12 link to check
    Click  partial link  ES12
    #Check Rejcted for PAD2 on order 1
    #Verify Text In Locator  xpath  /html/body/app/lab/div/div/analysis-request-detail/section[2]/section[3]/section/div[3]/div[2]  Rejected
    #Check Accepted for PAD1 on order 2
    #Verify Text In Locator  xpath  /html/body/app/lab/div/div/analysis-request-detail/section[2]/section[3]/section/div[3]/div[3]  Accepted
    #wait for screen to show up
    Sleep  10
    #Click overview Button under lab dasboard
    Click  id  labdashboard_link_overview
    #Wait for some time for screen to come up
    Sleep  3
    #TC-394 starts here
    #click on awaiting analysis button on lab dashboard
    Click  id  labdashboard_link_awaiting
    #Wait for some time for screen to come up
    Sleep  3
    #Click on search
    Click  xpath  //*[@id="searchinput_awaiting"]/div[1]/div[1]/label/input
    #Sleep so that it enable input
    Sleep  3
    #Enter kit name to search
    Enter Text  xpath  //*[@id="searchinput_awaiting"]/div[1]/div[1]/label/input  ES12
    #Sleep so that input is given
    Sleep  3
    #Pressing RETURN key so tht it can search
    Send Keys  None  RETURN
    #Wait for some time for screen to come up
    Sleep  3
    #Get kit tracking id
    ${ES12_TrackingID}=  Get Tracking Number  ${APP_VERSION}  ${TEST_ENV}  ES12
    Sleep  5
    #Verify page should contain kit id
    Verify  ${ES12_TrackingID} (ES12)
    #page should contain ES12
    Verify  ES12PAD2
    #### Matrix TC-171 Starts here ####
    #Verifying that it should appear on 1st order
    Verify Text In Locator  xpath  //*[@id="labawaiting_table"]/div/div/table/tbody/tr[1]/td[7]  ES12PAD2
    #Wait for some time for text to verify
    Sleep  3
    #verifying that it should appear on 2nd order
    Verify Text In Locator  xpath  //*[@id="labawaiting_table"]/div/div/table/tbody/tr[2]/td[7]  ES12PAD1
    #Wait for some time for screen to come up
    Sleep  3
    #check checkbox to export spreadsheet
    Identify And Check Checkbox  xpath  //*[@id="labawaiting_table"]/div/div/table   //*[@id="checkbox_awaiting"]/div[1]/material-ripple   ES12PAD2
    #click on export spreadsheet button
    Click  xpath  //*[@id="export-spreadsheed"]
    #sleep so that file could download
    Sleep  5
    ###TC-112 starts here###
    ${todaysdate}=  Todays Date
    ${assayresultfilename}=  Export Assay Result XL For Kit  ${APP_VERSION}  ${TEST_ENV}  ES12  CONFIRMED_BY_LAB
#    #Read Exported Excel and verify text exists
#    Verify Text In Excel  ${assayresultfilename}  ES12PAD1
#    #Read Exported Excel and verify text does not exist
#    Verify Text Not In Excel  ${assayresultfilename}  ES12PAD2
    #Click on ES12 link to check status
    Click  partial link  ES12
    #to check status for awaiting analysis
    Verify Text In Locator  xpath  //*[@id="analysisRequestStatus"]  Awaiting analysis
    #Wait for some time for screen to come up
    Sleep  5
    ###TC-183  starts here###
    ${Date}=  Todays Date
    ${CollectionDate}=   Subtract time from date  ${Date}  4 hour
    ${RecivalTimeDate}=  Subtract time from date  ${Date}  2 hour
    ${legalid}=  Get Legal ID    ${APP_VERSION}  ${TEST_ENV}     _customermobapp@qvin.com
    ${humanId}=  Get Human ID  ${APP_VERSION}  ${TEST_ENV}  ${legalid}
    Log  ${humanId}
    #Based on kit to be analysed, create IMPORT XL, based on kit, pad, assay results
    #Create Assay Result Import XL Rows  ${APP_VERSION}  ${TEST_ENV}  App  Customer_Mob  January 10,1985  36  Female  ES12  ES12PAD1  12345  ${CollectionDate}   ${RecivalTimeDate}  HbA1c  Approved  Whole Blood  5.80  %  ${emptystring}  Comments
    Create Assay Result Import XL Rows  ${APP_VERSION}  ${TEST_ENV}  App  Customer_Mob  ${humanId}  January 10,1985  36  Female  ES12  ES12PAD1  12345  2  ${CollectionDate}  ${CollectionDate}  ${RecivalTimeDate}  HbA1c  Approved  Whole Blood  5.80  %  ${emptystring}  Comments
    #Click on Import results and call API to Import the Assay Results
    Import Lab Results And Open Import Details  xpath  //*[@id="labdashboard_link_imports"]  ${APP_VERSION}  ${TEST_ENV}
    #Wait for some time for screen to come up
    Sleep  3
    #Check the assay result status
    Verify Text In Locator  xpath  //*[@id="assayresultimports_smart_table"]/div/div/table//tbody/tr/td[6]  Success
    #Verifying the value given is correctly displayed
    Verify Text In Locator  Xpath  //*[@id="assayresultimports_smart_table"]/div/div/table//tbody/tr/td[5]  5.80
    #close the browser
    Close Browser

ROBOT_LAB_07
    ###Matrix test case TC-1571 starts here ###
    Create Admin Authentication Endpoint  _admin@qvin.com  secret  123  EMAIL
    #Generate  token for lab user
    Create Lab Authentication Endpoint  _lab@qvin.com  secret  123  EMAIL
    #Generate  token for customer
    Create Customer Authentication Endpoint  _customermobapp@qvin.com  secret  123  EMAIL
    #Create Logistics Authentication Endpoint
    Create Logistics Authentication Endpoint    _logistics@qvin.com  secret  123  EMAIL
    #Open Browser and navigate to the desired URL
    Navigate To And Verify  ${BROWSER}  ${TEST_ENV}  Qvin
    #Click username
    Click  css  input[type='text']
    #Enter username
    Enter Text  css  input[type='text']  _lab@qvin.com
    #Click password
    Click  css  input[type='password']
    #Enter password
    Enter Text  css  input[type='password']  secret
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
    #Wait for some time for screen to come up
    Sleep  2
    #clcik on search for kits in laboratory dashboard
    Click  xpath  //*[@id="labdashboard_link_search"]
    #wait for the screen to show up
    Sleep  2

    #enter text in input bar
    Enter Text  xpath  //*[@id="searchinput_totalkits"]/div/div/label/input    ES08
    #click RETURN key
    Send Keys  None  RETURN
    #wait for the screen to show up
    Sleep  2
    #veify status 'delivered to lab' to check.
    Verify Text In Table  xpath  //*[@id="labsearch_table"]/div/div/table  NotApplicable  Inspection  3  Delivered at lab
    #wait for the screen to show up
    Sleep  2
    #wait for the screen to show up
    Sleep  2
    #click on Kit to inspect on laboratory dashboard
    Click  xpath  //*[@id="labdashboard_link_inspection"]
    #wait for the screen to show up-
    Sleep  2
    #enter text in input bar
    Enter Text  xpath  //*[@id="searchinput_kitstoinspect"]/div[1]/div[1]/label/input    ES08
    #click RETURN key
    Send Keys  None  RETURN
    #wait for the screen to show up
    Sleep  2
    #verify it contains ES08PAD1
    Verify  ES08PAD1
    Sleep  3
    ###Matrix test case TC-1576 starts here ###
    #clcik on search for kits in laboratory dashboard
    Click  xpath  //*[@id="labdashboard_link_search"]
    #wait for the screen to show up
    Sleep  2
    #enter text in input bar
    Enter Text  xpath  //*[@id="searchinput_totalkits"]/div/div/label/input    ES07
    #click RETURN key
    Send Keys   None   RETURN
    #wait for the screen to show up
    Sleep  2
    #veify status 'confirm by carrier' to check.
    Verify Text In Table  xpath  //*[@id="labsearch_table"]/div/div/table  NotApplicable  Created  3  Confirmed by carrier
    #wait for the screen to show up
    Sleep  2
    #wait for the screen to show up
    Sleep  2
    Click  id  	labdashboard_link_incoming
    Sleep  3
    Enter Text  xpath  //*[@id="searchinput_incoming"]/div[1]/div[1]/label/input  ES07
    Send Keys  None  RETURN
    ${TrackingId3}=  Get Tracking Number   ${APP_VERSION}  ${TEST_ENV}  ES07
    Sleep  3
    Verify  ${TrackingId3} (ES07)
    Sleep  3
    #click on analysis failed on laboratory dashboard
    Click  xpath  //*[@id="labdashboard_link_failed"]
    #wait for the screen to show up
    Sleep  2
    #enter text in input bar
    Enter Text  xpath  //*[@id="searchinput_failed"]/div/div/label/input    ES07
    #click RETURN key
    Send Keys  None  RETURN
    #wait for the screen to show up
    Sleep  2
    #verify it does not contain ES07
    Wait until page does not contain  ES07PAD1


    ###Matrix test case TC-1577 and starts here ###
    #Click incoming kits on menu
    Click  id  	labdashboard_link_incoming
    Sleep  3
    #Input kit id and press Enter key
    Enter Text  xpath  //*[@id="searchinput_incoming"]/div[1]/div[1]/label/input  ES09
    Send Keys  None  RETURN
    #Get kit tracking id
    ${TrackingId3}=  Get Tracking Number   ${APP_VERSION}  ${TEST_ENV}  ES09
    Sleep  3
    #Verify page should not contain kit
    page should not contain  ${TrackingId3} (ES09)
    #wait for the screen to show up
    Sleep  2
    #click on analysis failed on laboratory dashboard
    Click  xpath  //*[@id="labdashboard_link_failed"]
    #wait for the screen to show up
    Sleep  2
    #enter text in input bar
    Enter Text  xpath  //*[@id="searchinput_failed"]/div/div/label/input    ES09
    #click on RETURN key
    Send Keys  None  RETURN
    #wait for the screen to show up
    Sleep  2
    #verify it should not contains ES09
    Wait until page does not contain  ES09PAD1


    ###Matrix TC-489 starts Here ###
    #clcik on search for kits in laboratory dashboard
    Click  xpath  //*[@id="labdashboard_link_search"]
    #wait for the screen to show up
    Sleep  2
    #enter text in input bar
    Enter Text  xpath  //*[@id="searchinput_totalkits"]/div/div/label/input    ES14
    #click RETURN key
    Send Keys  None  RETURN
    #wait for the screen to show up
    Sleep  2
    #veify status 'Expired' to check.
    Verify Text In Table  xpath  //*[@id="labsearch_table"]/div/div/table  NotApplicable  Failed  3  Expired
    #wait for the screen to show up
    Sleep  2
    #wait for the screen to show up
    Sleep  2
    #click on analysis failed on laboratory dashboard
    Click  xpath  //*[@id="labdashboard_link_failed"]
    #wait for the screen to show up
    Sleep  2
    #enter text in input bar
    Enter Text  xpath  //*[@id="searchinput_failed"]/div/div/label/input    ES14
    #click on RETURN key
    Send Keys  None  RETURN
    #wait for the screen to show up
    Sleep  2
    #verify it contains ES14
    Verify  ES14
    #verify failure type status "kit was expired"
    Verify Text In Table  xpath  //*[@id="labfaildrqst_table"]/div/div/table  NotApplicable  ES14PAD2    3   Kit was expired
    #click on ES14 link
    Click  partial link  ES14
    #wait for the screen to show up
    Sleep  2
    #verify status "failed"
    Verify Text In Locator  xpath  //*[@id="analysisRequestStatus"]  Failed
    ###Matrix test case TC-488 starts here####
    #clcik on search for kits in laboratory dashboard
    Click  xpath  //*[@id="labdashboard_link_search"]
    #wait for the screen to show up
    Sleep  2
    #enter text in input bar
    Enter Text  xpath  //*[@id="searchinput_totalkits"]/div/div/label/input    ES15
    #click RETURN key
    Send Keys  None  RETURN
    #wait for the screen to show up
    Sleep  2
    #veify status 'delivered to lab' to check.
    Verify Text In Table  xpath  //*[@id="labsearch_table"]/div/div/table  NotApplicable  Failed  3  Expired
    #wait for the screen to show up
#    Sleep  2
#    #veify Analysis status 'Failed' to check.
#    Verify Text In Table  xpath  //*[@id="labsearch_table"]/div/div/table  NotApplicable  ES15  4  Failed
    #wait for the screen to show up
    Sleep  2
    #wait for the screen to show up
    Sleep  2
    #click on analysis failed on laboratory dashboard
    Click  xpath  //*[@id="labdashboard_link_failed"]
    #wait for the screen to show up
    Sleep  2
    #enter text in input bar
    Enter Text  xpath  //*[@id="searchinput_failed"]/div/div/label/input    ES15
    #click on RETURN key
    Send Keys  None  RETURN
    #wait for the screen to show up
    Sleep  2
    #verify it contains ES15
    Verify  ES15PAD2
    #verify failure type status "kit was expired"
    Verify Text In Table  xpath  //*[@id="labfaildrqst_table"]/div/div/table  NotApplicable  ES15PAD2    3   Kit was expired
    #click on ES15 link
    Click  partial link  ES15
    #wait for the screen to show up
    Sleep  2
    #verify status "failed"
    Verify Text In Locator  xpath  //*[@id="analysisRequestStatus"]  Failed
    #closing browser
    Close browser

ROBOT_LAB_08
    ###Matrix test case TC-121 starts here ###
    Create Admin Authentication Endpoint  _admin@qvin.com  secret  123  EMAIL
    #Generate  token for lab user
    Create Lab Authentication Endpoint  _lab@qvin.com  secret  123  EMAIL
    #Create Logistics Authentication Endpoint
    Create Logistics Authentication Endpoint    _logistics@qvin.com  secret  123  EMAIL
    #Open Browser and navigate to the desired URL
    Navigate To And Verify  ${BROWSER}  ${TEST_ENV}  Qvin
    #Click username
    Click  css  input[type='text']
    #Enter username
    Enter Text  css  input[type='text']  _lab@qvin.com
    #Click password
    Click  css  input[type='password']
    #Enter password
    Enter Text  css  input[type='password']  secret
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
    #wait for some time so page could load
    Sleep  3
    #click on kits to inspect in laboratory dashboard
    Click  xpath  //*[@id="labdashboard_link_inspection"]
    #wait for the screen to show up
    Sleep  2
    #enter text in input bar
    Enter Text  xpath  //*[@id="searchinput_kitstoinspect"]/div[1]/div[1]/label/input   ES08
    #click RETURN key
    Send Keys  None  RETURN
    #wait for the screen to show up
    Sleep  2
    #veify Analysis status 'Failed' to check.
    Verify  ES08PAD1
    ##wait for the screen to show up##
    Sleep  2
    #click on analysis failed on laboratory dashboard
    Click  xpath  //*[@id="labdashboard_link_failed"]
    #wait for the screen to show up
    Sleep  2
    #enter text in input bar
    Enter Text  xpath  //*[@id="searchinput_failed"]/div/div/label/input    ES08
    #click RETURN key
    Send Keys  None  RETURN
    #wait for the screen to show up
    Sleep  2
    #verify it does not contains ES08
    Wait until page does not contain  ES08PAD1

    ##Matrix test case TC-479 and TC-393 starts here ###

    #Click on Search
    Click  xpath  //*[@id="labdashboard_link_search"]
    #sleep so that incoming kits load
    Sleep  2
    #Click on Search
    Click  xpath  //*[@id="searchinput_totalkits"]/div/div/label/input
    #sleep so that it enable input
    Sleep  2
    #Enter Kit name to search
    Enter Text  xpath  //*[@id="searchinput_totalkits"]/div/div/label/input  KT17
    #sleep so that input is given
    Sleep  2
    #Pressing RETURN key so tht it can search
    Send Keys  None  RETURN
    #sleep so that it load the searched kits
    Sleep  2
    #click 3 dots menu in table
    Click  id  labsearch_menu_action
    #wait for the menu to come up
    Sleep  2
    ###TC-108 starts here###
    #clicking on Deliver to lab on three dots menu
    Click  xpath  //span[contains(.,'Deliver to lab')]
    #wait for the screen to show up
    Sleep  2
    #Click Deliver to lab button
    Click  id   delivertolab_btn
    Sleep  2


    #click on kits to inspect
    Click  id  labdashboard_link_inspection
    #wait for the screen to show up
    Sleep  2
    #clicking on the search input bar
    Click  xpath  //*[@id="searchinput_kitstoinspect"]/div[1]/div[1]/label/input
    #sleep so that it enable input
    Sleep  2
    #input kit name to search
    Enter Text  xpath  //*[@id="searchinput_kitstoinspect"]/div[1]/div[1]/label/input  KT17
    #sleep so that input is given
    Sleep  2
    #Pressing RETURN key so tht it can search
    send keys  None  RETURN
    #sleep so that it load the searched kits
    Sleep  2
    #Get kit tracking id
    ${KT17_TrackingID}=  Get Tracking Number  ${APP_VERSION}  ${TEST_ENV}  KT17
    Sleep  5
    #Verify page should contain
    Verify  ${KT17_TrackingID} (KT17)
    #Click on kit Link  to check status
    Click  partial link  KT17
    #Wait for some time so page could load
    Sleep  5
    #Verify status of kit is Inspection
    Verify  Inspection

    Sleep  2
    #Verify Result Status Is Empty Under List of Assay
    #Wait Until Keyword Succeeds  5x  200ms  Verify Text In Table   Xpath  //*[@id="singleanalysisrequest_smart_table"]/div/div/table  NotApplicable  HbA1c  2  Approved for analysis

    ###Matrix test case TC-115,TC-116 starts here ###
    #Click on kits to inspect
    Click  id  labdashboard_link_inspection
    #wait for the screen to show up
    Sleep  2
    #Clicking on the search input bar
    Click  xpath  //*[@id="searchinput_kitstoinspect"]/div[1]/div[1]/label/input
    #Sleep so that it enable input
    Sleep  2
    #Input kit name to search
    Enter Text  xpath  //*[@id="searchinput_kitstoinspect"]/div[1]/div[1]/label/input  KT17
    #sleep so that input is given
    Sleep  2
    #Pressing RETURN key so tht it can search
    send keys  None  RETURN
    Sleep  3
    #Search for the kit, click on INSPECT in 3 dots
    Click  id  labinspection_menu_action
    #Click on Inspect button
    Click  xpath  //span[contains(.,'Inspect')]
    #Wait for some time for screen to come up
    Sleep  3
    #Wait for some time for screen to come up
    Sleep  3
    #Click on Device is missing checkbox
    Click  id  KT17PAD2-missing
    #Wait for some time for screen to come up
    Sleep  1
    #Click Submit button
    Click  id  inspect_dialog_btn_submit
    #Wait for some time for screen to come up
    Sleep  3
    #Check whole blood status for Device1 is Accepted
    Verify Text In Locator  xpath  //*[@id="default-acx-overlay-container"]/div[9]/material-dialog/focus-trap/div[2]/div/main/section[1]   Q-Whole blood: ACCEPTED
    #Check Plasma status for Device1 is Accepted
    Verify Text In Locator  xpath  //*[@id="default-acx-overlay-container"]/div[9]/material-dialog/focus-trap/div[2]/div/main/section[1]   Q-Plasma: ACCEPTED
    #Check whole blood status for Device2 is Rejected
    Verify Text In Locator  xpath  //*[@id="default-acx-overlay-container"]/div[9]/material-dialog/focus-trap/div[2]/div/main/section[2]   Q-Whole blood: REJECTED
    #Check Plasma status for Device2 is Rejected
    Verify Text In Locator  xpath  //*[@id="default-acx-overlay-container"]/div[9]/material-dialog/focus-trap/div[2]/div/main/section[2]   Q-Plasma: REJECTED
    #Click on no buttun to re-inspect
    Click  xpath  //*[@id="inspect_dialog_btn_no"]
    #Close the inspect dialog box
    Click  xpath  //*[@id="inspect_dialog_close"]
    Sleep  3

    ###Matrix test case TC-117 starts here ###
    #Search for the kit, click on INSPECT in 3 dots
    Click  id  labinspection_menu_action
    #Click on Inspect button
    Click  xpath  //span[contains(.,'Inspect')]
    #Wait for some time for screen to come up
    Sleep  3
    #Wait for some time for screen to come up
    Sleep  3
    #Reject Device2 whloe blood
    Click  id  Q_WHOLE_BLOODKT17PAD2-insufficient
    #Wait for some time for screen to come up
    Sleep  1
    #Click Submit button
    Click  id  inspect_dialog_btn_submit
    #Wait for some time for screen to come up
    Sleep  3
    #Check whole blood status for Device1 is Accepted
    Verify Text In Locator  xpath  //*[@id="default-acx-overlay-container"]/div[9]/material-dialog/focus-trap/div[2]/div/main/section[1]   Q-Whole blood: ACCEPTED
    #Check whole blood status for Device2 is Rejected
    Verify Text In Locator  xpath  //*[@id="default-acx-overlay-container"]/div[9]/material-dialog/focus-trap/div[2]/div/main/section[1]   Q-Plasma: ACCEPTED
    #Check whole blood status for Device2 is Rejected
    Verify Text In Locator  xpath  //*[@id="default-acx-overlay-container"]/div[9]/material-dialog/focus-trap/div[2]/div/main/section[2]   Q-Whole blood: REJECTED
    #Check Plasma status for Device2 is Accepted
    Verify Text In Locator  xpath  //*[@id="default-acx-overlay-container"]/div[9]/material-dialog/focus-trap/div[2]/div/main/section[2]   Q-Plasma: ACCEPTED
    #Click on No button to re-inspect
    Click  xpath  //*[@id="inspect_dialog_btn_no"]
    #Close the inspect dialogue box
    Click  xpath  //*[@id="inspect_dialog_close"]
    Sleep  3

    ###Matrix test case TC-119 starts here ###
    #Click on 3 dots
    Click  id  labinspection_menu_action
    #Click on Inspect button
    Click  xpath  //span[contains(.,'Inspect')]
    #Wait for some time for screen to come up
    Sleep  3
    #Wait for some time for screen to come up
    Sleep  3
    #Reject whole blood for device2 by marking it insufficent
    Click  id  Q_WHOLE_BLOODKT17PAD2-insufficient
    #Reject Plasma for device2 by marking it insufficent
    Click  id  Q_PLASMAKT17PAD2-insufficient
    #Wait for some time for screen to come up
    Sleep  1
    #Click Submit button
    Click  id  inspect_dialog_btn_submit
    #Wait for some time for screen to come up
    Sleep  3
    #Check whole blood status for Device1 is Accepted
    Verify Text In Locator  xpath  //*[@id="default-acx-overlay-container"]/div[9]/material-dialog/focus-trap/div[2]/div/main/section[1]   Q-Whole blood: ACCEPTED
    #Check whole blood status for Device1 is Accepted
    #Check Plasma status for Device1 is Accepted
    Verify Text In Locator  xpath  //*[@id="default-acx-overlay-container"]/div[9]/material-dialog/focus-trap/div[2]/div/main/section[1]   Q-Plasma: ACCEPTED
    #Check whole blood status for Device2 is Rejected
    Verify Text In Locator  xpath  //*[@id="default-acx-overlay-container"]/div[9]/material-dialog/focus-trap/div[2]/div/main/section[2]  Q-Whole blood: REJECTED
    #Check Plasma status for Device2 is Rejected
    Verify Text In Locator  xpath  //*[@id="default-acx-overlay-container"]/div[9]/material-dialog/focus-trap/div[2]/div/main/section[2]   Q-Plasma: REJECTED
    #Click on No button to re-inspect the kit
    Click  xpath  //*[@id="inspect_dialog_btn_no"]
    #Close the inspect dialogue box
    Click  xpath  //*[@id="inspect_dialog_close"]
    Sleep  3


    #Matrix  TC-157 and TC-176 Starts here###
    #Click on 3 dots
    Click  id  labinspection_menu_action
    #Click on Inspect button
    Click  xpath  //span[contains(.,'Inspect')]
    Sleep  3
    #Reject whole blood for Pad 1
    Click  id  Q_WHOLE_BLOODKT17PAD1-insufficient
    Sleep  2
    #Reject Plasma for device2 by marking it insufficent
    Click  id  Q_PLASMAKT17PAD2-insufficient
    #Wait for some time for screen to come up
    Sleep  3
    #Click Submit button
    Click  id  inspect_dialog_btn_submit
    #Wait for some time for screen to come up
    Sleep  1
    #Click on yes button to re-inspect the kit
    Click  xpath  //*[@id="inspect_dialog_btn_yes"]
    Sleep  2
    #Click Awaiting Analysis link
    Click  xpath  //*[@id="labdashboard_link_awaiting"]
    #Click on Input bar
    Click  Xpath  //*[@id="searchinput_awaiting"]/div[1]/div[1]/label/input
    #Enter Text in Input Bar
    Enter Text  Xpath  //*[@id="searchinput_awaiting"]/div[1]/div[1]/label/input  KT17
    #Send keys
    Send Keys  None  RETURN
    Sleep   2
    #Click on kit link to open analysis view screen
    Click  partial link   KT17
    Sleep  2
    #Verify Rejected text in locator
    Verify Text In Locator   xpath   //*[@id="secondPlasmaSpecimenStatus"]   Rejected
    Sleep   2
    #Click Awaiting Analysis link
    Click  xpath  //*[@id="labdashboard_link_awaiting"]
    #Click on Input bar
    Click  Xpath  //*[@id="searchinput_awaiting"]/div[1]/div[1]/label/input
    #Enter Text in Input Bar
    Enter Text  Xpath  //*[@id="searchinput_awaiting"]/div[1]/div[1]/label/input  KT17
    #Send keys
    Send Keys  None  RETURN
    #Search for the user and check the checkbox in the table
    Identify And Check Checkbox  xpath  //*[@id="labawaiting_table"]/div/div/table  /material-checkbox  KT17PAD1
    #Wait for some time for screen to come up
    Sleep  1
    #Click Export button
    Click  xpath  //*[@id="export-spreadsheed"]
    #Wait for some time for screen to come up
    Sleep  1
    ${Date}=  Todays Date
    ${CollectionDate}=   Subtract time from date  ${Date}  4 hour
    ${RecivalTimeDate}=  Subtract time from date  ${Date}  2 hour
    ${legalid}=  Get Legal ID    ${APP_VERSION}  ${TEST_ENV}     _customermobapp@qvin.com
    ${humanId}=  Get Human ID  ${APP_VERSION}  ${TEST_ENV}  ${legalid}
    Log  ${humanId}
    #Based on kit to be analysed, create IMPORT XL, based on kit, pad, assay results
    #Create Assay Result Import XL Rows  ${APP_VERSION}  ${TEST_ENV}  App  Customer_Mob  January 10,1985  36  Female  KT17  KT17PAD2  ${emptystring}  ${CollectionDate}  ${RecivalTimeDate}  HbA1c  Approved  Whole Blood  ${emptystring}  %  ${emptystring}  Comments
    Create Assay Result Import XL Rows  ${APP_VERSION}  ${TEST_ENV}  App  Customer_Mob  ${humanId}  January 10,1985  36  Female  KT17  KT17PAD2  12345  2  ${CollectionDate}  ${CollectionDate}  ${RecivalTimeDate}  HbA1c  Approved  Whole Blood  ${emptystring}  %  ${emptystring}  Comments
    #Click on Import results and call API to Import the Assay Results
    Import Lab Results And Open Import Details  xpath  //*[@id="labdashboard_link_imports"]  ${APP_VERSION}  ${TEST_ENV}
    #Wait for some time for screen to come up
    Sleep  3
    #Check the assay result status
    Verify Text In Locator  xpath  //*[@id="assayresultimports_smart_table"]/div/div/table//tbody/tr/td[6]  Failure (No result or failure. Row 1 ignored.)
    Sleep  2


    ### TC-180 ###
    #Based on kit to be analysed, create IMPORT XL, based on kit, pad, assay results
    #Create Assay Result Import XL Rows  ${APP_VERSION}  ${TEST_ENV}  App  Customer_Mob  January 10,1985  36  Female  KT17  KT17PAD2  ${emptystring}  ${CollectionDate}  ${RecivalTimeDate}  HbA1c  Approved  Whole Blood  5  %  ${emptystring}  Comments
    Create Assay Result Import XL Rows  ${APP_VERSION}  ${TEST_ENV}  App  Customer_Mob  ${humanId}  January 10,1985  36  Female  KT17  KT17PAD2  12345  2  ${CollectionDate}  ${CollectionDate}  ${RecivalTimeDate}  HbA1c  Approved  Whole Blood  5  %  ${emptystring}  Comments
    #Click on Import results and call API to Import the Assay Results
    Import Lab Results And Open Import Details  xpath  //*[@id="labdashboard_link_imports"]  ${APP_VERSION}  ${TEST_ENV}
    Sleep   3
    #Based on kit to be analysed, create IMPORT XL, based on kit, pad, assay results
    #Create Assay Result Import XL Rows  ${APP_VERSION}  ${TEST_ENV}  App  Customer_Mob  January 10,1985  36  Female  KT17  KT17PAD1  ${emptystring}  ${CollectionDate}  ${RecivalTimeDate}  CRP  Approved  Q-Plasma  123  mg/L  ${emptystring}  Comments
    Create Assay Result Import XL Rows  ${APP_VERSION}  ${TEST_ENV}  App  Customer_Mob  ${humanId}  January 10,1985  36  Female  KT17  KT17PAD1  ${emptystring}  2  ${CollectionDate}  ${CollectionDate}  ${RecivalTimeDate}  CRP  Approved  Q-Plasma  123  mg/L  ${emptystring}  Comments
    #Click on Import results and call API to Import the Assay Results
    Import Lab Results And Open Import Details  xpath  //*[@id="labdashboard_link_imports"]  ${APP_VERSION}  ${TEST_ENV}
    Sleep  2
    #Click analysis complete
    Click  id  labdashboard_link_complete
    Sleep  2
    #Input text in search bar
    Enter Text   Xpath   //*[@id="searchinput_complete"]/div[1]/div[1]/label/input    KT17
    #Send key RETURN
    Send Keys  None  RETURN
    Sleep  2

    ####TC-186###
    #Verify plasma accepted for device 1
    Verify Text In Table  xpath   //*[@id="labcomplete_table"]/div/div/table   NotApplicable  KT17PAD1  4  Rejected

    #Verify plasma Rejected for device 2
    Verify Text In Table  xpath   //*[@id="labcomplete_table"]/div/div/table   NotApplicable  KT17PAD2  4  Accepted
    Sleep  2

    ####TC-187###
    #Verify plasma accepted for device 1
    Verify Text In Table  xpath   //*[@id="labcomplete_table"]/div/div/table   NotApplicable  KT17PAD1  5  Accepted

    #Verify plasma Rejected for device 2
    Verify Text In Table  xpath   //*[@id="labcomplete_table"]/div/div/table   NotApplicable  KT17PAD2  5  Rejected
    Sleep  2

    #Click kit link
    Click  Partial link   KT17
    Sleep  2
    Wait Until Element Is Enabled    //*[@id="singleanalysisrequest_smart_table"]/div/div/table
    #Verify resulty status and result is there
    Wait Until Keyword Succeeds  5x  200ms  Verify Text In Table  Xpath  //*[@id="singleanalysisrequest_smart_table"]/div/div/table  NotApplicable  HbA1c  2  Approved for release
    Wait Until Keyword Succeeds  5x  200ms  Verify Text In Table  Xpath  //*[@id="singleanalysisrequest_smart_table"]/div/div/table  NotApplicable  HbA1c  4  5.00
    Wait Until Keyword Succeeds  5x  200ms  Verify Text In Table  Xpath  //*[@id="singleanalysisrequest_smart_table"]/div/div/table  NotApplicable  CRP  2  Approved for release
    Wait Until Keyword Succeeds  5x  200ms  Verify Text In Table  Xpath  //*[@id="singleanalysisrequest_smart_table"]/div/div/table  NotApplicable  CRP  4  123.00
    Sleep   5


    ###Matrix  TC-490  Starts Here###
    #Click on analysis failed
    Click  xpath  //*[@id="labdashboard_link_failed"]
    #Wait for screen to show up
    Sleep  3
    #Enter kit in input bar
    Enter Text  xpath  //*[@id="searchinput_failed"]/div[1]/div[1]/label/input  KT03
    #Send RETURN key to search
    Send Keys  None  RETURN
    #Wait for screen to show up
    Sleep  3
    #Verify failure reason is "kit was expired"
    Verify Text In Table  xpath  //*[@id="labfaildrqst_table"]/div/div/table  NotApplicable  KT03PAD1  3   Kit was expired
    #Click on kit link to view Analysis Request View Screen
    Click  partial link  KT03
    #Wait for screen to show up
    Sleep  3
    #Verify Status
    Verify Text In Locator  xpath  //*[@id="analysisRequestStatus"]  Failed
    #Wait for screen to show up
    Sleep  3
    ##Verify the text Empty for Assay
    #Wait Until Keyword Succeeds  5x  200ms  Verify Text In Table  Xpath  //*[@id="singleanalysisrequest_smart_table"]/div/div/table  NotApplicable  HbA1c  2  Failed

    ###Matrix TC-1132 Starts here###
    #Click on Incoming
    Click  xpath  //*[@id="labdashboard_link_incoming"]
    #Enter kit id to Search
    Enter Text  xpath  //*[@id="searchinput_incoming"]/div[1]/div[1]/label/input  ES06
    Send Keys  None  RETURN
    #Wait for screen to show up
    Sleep  3
    #Click on  3 dots
    Click  id  labincoming_menu_action
    #Wait for screen to show up
    Sleep  3
    #Click on mark kit delivered
    Click  Xpath  //span[contains(.,'Mark kit delivered')]
    #Wait for screen to show up
    Sleep  3
    Click  xpath  //*[@id="default-acx-overlay-container"]/div[2]/material-dialog/focus-trap/div[2]/div/main/div[2]/material-input/div[1]/div[1]/label/input
    Sleep  3
    #Click ok button
    Click  xpath  //*[@id="common_btn_okinput"]
    Sleep  3
    #Verify enter value if no track id provided and return status
    ${Result}=  Run Keyword and return status  Verify  Enter a value
    #Log Result
    Log  ${Result}
    #Click cancel if button is disable
    Run Keyword if  '${RESULT}'=='True'   Click  id  common_btn_cancelinput
    Sleep  3

    #TC-1131 starts here
    #Click on  3 dots
    Click  id  labincoming_menu_action
    #Wait for screen to show up
    Sleep  3
    #Click on mark kit delivered
    Click  Xpath  //span[contains(.,'Mark kit delivered')]
    #Wait for screen to show up
    Sleep  3
    #Enter wrong tracking number in input bar
    Enter Text  xpath  //*[@id="default-acx-overlay-container"]/div[2]/material-dialog/focus-trap/div[2]/div/main/div[2]/material-input/div[1]/div[1]/label/input  Anything123
    #Click ok button
    Click  Xpath  //*[@id="common_btn_okinput"]/material-ripple
    Sleep  3
    #Verify "sorry , wrong kit shipping track id in dialogue box"
    Verify  Sorry, Wrong Kit Shipping Track Id
    #Click ok in dialogue box
    Click  id  common_btn_okerror
    Sleep  3


    ###Matrix TC-120 and TC-1130 Starts here###
    #Click on  3 dots
    Click  id  labincoming_menu_action
    #Wait for screen to show up
    Sleep  3
    #Click on mark kit delivered
    Click  Xpath  //span[contains(.,'Mark kit delivered')]
    #Wait for screen to show up
    Sleep  3
    #API call to fetch kit id
    ${kitid}=  Get Kit ID  ${APP_VERSION}  ${TEST_ENV}  ES06  IN_USE
    #API call to fetch Tracking number for kit id
    ${trackingnumber}=  Get Tracking Number  ${APP_VERSION}  ${TEST_ENV}  ES06
    #Enter tracking number in input bar
    Enter Text  xpath  //*[@id="default-acx-overlay-container"]/div[2]/material-dialog/focus-trap/div[2]/div/main/div[2]/material-input/div[1]/div[1]/label/input  ${trackingnumber}
    #Click ok button
    Click  Xpath  //*[@id="common_btn_okinput"]/material-ripple
    #Wait for the screen to show up
    Sleep  3
    #Click on search kit
    Click  id  labdashboard_link_search
    #Enter KitID in Input bar.
    Enter text  xpath  //*[@id="searchinput_totalkits"]/div[1]/div[1]/label/input  ES06
    #Press RETURN Key
    Send Keys  None  RETURN
    Sleep  3
    #Verify status confirmed by lab
    Verify  Delivered at lab

    #Click on kits to inspect
    ##TC-101###
    Click  xpath  //*[@id="labdashboard_link_inspection"]
    #Wait for the Screen to show up
    Sleep  3
    #Enter kit id in input bar to seach
    Enter Text  xpath  //*[@id="searchinput_kitstoinspect"]/div[1]/div[1]/label/input  ES06
    Send Keys  None  RETURN
    #Wait for the screen to show up
    Sleep  3
    #Verify kit on kits to insprct screen
    Verify  ES06
    ##Verify specimen status Empty For PAD1
    #Verify Text In Table  xpath  //*[@id="labinspection_table"]/div/div/table  NotApplicable  ES06PAD1  7  Empty
    ##Verify specimen status Empty For PAD2
    #Verify Text In Table  xpath  //*[@id="labinspection_table"]/div/div/table  NotApplicable  ES06PAD2  7  Empty
    #Click on 3 Dots
    Click  id  labinspection_menu_action
    #Click on Inspect button
    Click  xpath  //span[contains(.,'Inspect')]
    #Wait for some time for screen to come up
    Sleep  3
    #Wait for some time for screen to come up
    Sleep  3
    #Click Submit button
    Click  id  inspect_dialog_btn_submit
    #Wait for some time for screen to come up
    Sleep  3

    #TC-1569
    #Click on Incomming
    Click  id  labdashboard_link_incoming
    #sleep so that incoming kits load
    Sleep  2
    #Click on Search
    Click  xpath  //material-input[@id='searchinput_incoming']/div/div/label/input
    #sleep so that it enable input
    Sleep  2
    #Enter Kit name to search
    Enter Text  xpath  //material-input[@id='searchinput_incoming']/div/div/label/input  ES01
    #sleep so that input is given
    Sleep  2
    #Pressing RETURN key so tht it can search
    Send Keys  None  RETURN
    #sleep so that it load the searched kits
    Sleep  2
    ${trackingId}=  Get Tracking Number  ${APP_VERSION}  ${TEST_ENV}  ES01
    Sleep  5
    #verify Kit id should not display
    Page should contain  ${trackingId} (ES01)
    Sleep  2

    #TC-1570
    Click  xpath  //*[@id="labdashboard_link_overview"]
    #Wait for some time for screen to come up
    Sleep  2
    #Click View Button under Kits to Inspect
    Click  id  labdashboard_btn_kitstoinspect
    #Wait for some time for screen to come up
    Sleep  3
    #Click on Input bar
    Click  Xpath  //*[@id="searchinput_kitstoinspect"]/div[1]/div[1]/label/input
    #Enter Text in Input Bar
    Enter Text  Xpath  //*[@id="searchinput_kitstoinspect"]/div[1]/div[1]/label/input  ES02
    #Send keys
    Send Keys  None  RETURN
    #Verify kit not present on "Kits to inspect screen"
    page should not contain   ES02PAD1

    #TC-1573
    #Click on Incomming
    Click  id  labdashboard_link_incoming
    #sleep so that incoming kits load
    Sleep  2

    #Click on Search
    Click  xpath  //material-input[@id='searchinput_incoming']/div/div/label/input
    #sleep so that it enable input
    Sleep  2
    #Enter Kit name to search
    Enter Text  xpath  //material-input[@id='searchinput_incoming']/div/div/label/input  ES03
    #sleep so that input is given
    Sleep  2
    #Pressing RETURN key so tht it can search
    Send Keys  None  RETURN
    #sleep so that it load the searched kits
    Sleep  2
    ${trackingId}=  Get Tracking Number  ${APP_VERSION}  ${TEST_ENV}  ES03
    Sleep  5
    #verify Kit id should not display
    Page should not contain  ${trackingId} (ES03)
    Sleep  2
    #Click on Analysis failed
    Click  id  labdashboard_link_failed
    Sleep  3
    #Verify page should not contain kit
    Page should not contain  ES03PAD1


    #TC-1578
    Click  xpath  //*[@id="labdashboard_link_overview"]
    #Wait for some time for screen to come up
    Sleep  2
    #Click View Button under Kits to Inspect
    Click  id  labdashboard_btn_kitstoinspect
    #Wait for some time for screen to come up
    Sleep  3
    #Click on Input bar
    Click  Xpath  //*[@id="searchinput_kitstoinspect"]/div[1]/div[1]/label/input
    #Enter Text in Input Bar
    Enter Text  Xpath  //*[@id="searchinput_kitstoinspect"]/div[1]/div[1]/label/input  ES13
    #Send keys
    Send Keys  None  RETURN
    #Wait for screen to show up
    Sleep  3
    #Verify kit present on "Kits to inspect screen"
    Verify   ES13PAD1
    Sleep  5


    # Matrix TC-436 starts here.
    #Click search on laboratory dashboard
    Click  id  labdashboard_link_search
    #Enter KitID in Input bar.
    Enter text  xpath  //*[@id="searchinput_totalkits"]/div[1]/div[1]/label/input  ES10
    #Press RETURN Key
    Send Keys  None  RETURN
    Sleep  3
    #Verifying kit status reserverd
    Verify  Reserved
    #Click 3 dots
    Click  id  labsearch_menu_action
    Sleep  3
    #Click on move to use
    Click  xpath  //span[contains(.,'Move to use')]
    #Unchecking check box for pad 2
    Click  xpath   (//material-checkbox[@id='logistics_padusedcheckbox']/div/material-ripple)[2]
    Sleep  5
    #Get the current date
    ${date}=  Get Current Date  exclude_millis=TRUE
    #Wait for some time for screen to come up
    Sleep  2
    #Get the time element from the current date extracted
    ${time}=  Get Time From Date  ${date}
    #Click on the drop down for Use Time
    Click  xpath  //*[@id="logistics_usedatetimepicker"]/material-time-picker/material-dropdown-select/dropdown-button
    #Wait for some time for screen to come up
    Sleep  2
    #Click on the input field for Use Time
    Click  xpath  //div/div/material-input/div/div/label/input
    #Send keys Ctrl+a for selecting all text
    Send Keys  None  CTRL+a
    #Send keys DELETE for deleting all text
    Send Keys  None  DELETE
    #Send keys for adding time value
    Send Keys  None  ${time}
    #Send keys for ENTER
    Send Keys  None  RETURN
    #Wait for some time for screen to come up
    Sleep  2
    #Take screenshot of the screen
    Capture Page Screenshot
    #Click on the drop down field for Use Start time
    Click  xpath  //td[4]/material-date-time-picker/material-time-picker/material-dropdown-select/dropdown-button/div/glyph/i
    #Wait for some time for screen to come up
    Sleep  2
    #Click on the input field for Use Start time
    Click  xpath  /html/body/div/div[9]/div/div/div[2]/header/div/div/div/material-input/div/div[1]/label/input
    #Send keys Ctrl+a for selecting all text
    Send Keys  None  CTRL+a
    #Send keys DELETE for deleting all text
    Send Keys  None  DELETE
    #Send keys for adding time value
    Send Keys  None  ${time}
    #Send keys for ENTER
    Send Keys  None  RETURN
    #Wait for some time for screen to come up
    Sleep  2
    #Click on the drop down field for Use End time
    Click  xpath  //td[6]/material-date-time-picker/material-time-picker/material-dropdown-select/dropdown-button/div/glyph/i
    #Wait for some time for screen to come up
    Sleep  2
    #Click on the input field for Use End time
    Click  xpath  /html/body/div/div[10]/div/div/div[2]/header/div/div/div/material-input/div/div[1]/label/input
    #Send keys Ctrl+a for selecting all text
    Send Keys  None  CTRL+a
    #Send keys DELETE for deleting all text
    Send Keys  None  DELETE
    #Send keys for adding time value
    Send Keys  None  ${time}
    #Send keys for ENTER
    Send Keys  None  RETURN
    #Wait for some time for screen to come up
    Sleep  2
    #Click move to use button
    Click  id  logisticsactions_btn_movetoused
    #Click yes
    Click  xpath  //*[@id="logistics_common_btn_yesno"]/material-button[1]

    #Enter kit id in input bar
    Enter text  xpath  //*[@id="searchinput_totalkits"]/div[1]/div[1]/label/input  ES10
    #Press RETURN key
    Send Keys  None  RETURN
    Sleep  3
    #Click kit id
    Click  partial link  ES10
    Sleep  3
    #Verify status is Empty for pad 2
    Verify Text In Locator  xpath  //*[@id="secondWBSpecimenStatus"]  Empty

    Sleep  10

    #Matrix TC-437 starts here.
    #Click search on laboratory dashboard
    Click  id  labdashboard_link_search
    #Enter KitID in Input bar.
    Enter text  xpath  //*[@id="searchinput_totalkits"]/div[1]/div[1]/label/input  ES17
    #Press RETURN Key
    Send Keys  None  RETURN
    Sleep  3
    #Verifying kit status reserverd
    Verify  Reserved
    #Click 3 dots
    Click  id  labsearch_menu_action
    Sleep  3
    #Click on move to use
    Click  xpath  //span[contains(.,'Move to use')]
    Sleep  5
    #Get the current date
    ${date}=  Get Current Date  exclude_millis=TRUE
    #Wait for some time for screen to come up
    Sleep  2
    #Get the time element from the current date extracted
    ${time}=  Get Time From Date  ${date}
    #Click on the drop down for Use Time
    Click  xpath  //*[@id="logistics_usedatetimepicker"]/material-time-picker/material-dropdown-select/dropdown-button
    #Wait for some time for screen to come up
    Sleep  2
    #Click on the input field for Use Time
    Click  xpath  //div/div/material-input/div/div/label/input
    #Send keys Ctrl+a for selecting all text
    Send Keys  None  CTRL+a
    #Send keys DELETE for deleting all text
    Send Keys  None  DELETE
    #Send keys for adding time value
    Send Keys  None  ${time}
    #Send keys for ENTER
    Send Keys  None  RETURN
    #Wait for some time for screen to come up
    Sleep  2
    #Take screenshot of the screen
    Capture Page Screenshot
    #Click on the drop down field for Use Start time
    Click  xpath  //td[4]/material-date-time-picker/material-time-picker/material-dropdown-select/dropdown-button/div/glyph/i
    #Wait for some time for screen to come up
    Sleep  2
    #Click on the input field for Use Start time
    Click  xpath  /html/body/div/div[9]/div/div/div[2]/header/div/div/div/material-input/div/div[1]/label/input
    #Send keys Ctrl+a for selecting all text
    Send Keys  None  CTRL+a
    #Send keys DELETE for deleting all text
    Send Keys  None  DELETE
    #Send keys for adding time value
    Send Keys  None  ${time}
    #Send keys for ENTER
    Send Keys  None  RETURN
    #Wait for some time for screen to come up
    Sleep  2
    #Click on the drop down field for Use End time
    Click  xpath  //td[6]/material-date-time-picker/material-time-picker/material-dropdown-select/dropdown-button/div/glyph/i
    #Wait for some time for screen to come up
    Sleep  2
    #Click on the input field for Use End time
    Click  xpath  /html/body/div/div[10]/div/div/div[2]/header/div/div/div/material-input/div/div[1]/label/input
    #Send keys Ctrl+a for selecting all text
    Send Keys  None  CTRL+a
    #Send keys DELETE for deleting all text
    Send Keys  None  DELETE
    #Send keys for adding time value
    Send Keys  None  ${time}
    #Send keys for ENTER
    Send Keys  None  RETURN
    #Wait for some time for screen to come up
    Sleep  15

    #Get the current date
    ${date}=  Get Current Date  exclude_millis=TRUE
    #Wait for some time for screen to come up
    Sleep  2
    #Get the time element from the current date extracted
    ${time}=  Get Time From Date  ${date}
    Sleep  2
    #Click on the drop down field for Use Start time
    Click  xpath  //tr[3]/td[4]/material-date-time-picker/material-time-picker/material-dropdown-select/dropdown-button/div/glyph/i
    #Wait for some time for screen to come up
    Sleep  2
    #Click on the input field for Use Start time
    Click  xpath  /html/body/div/div[11]/div/div/div[2]/header/div/div/div/material-input/div/div[1]/label/input
    #Send keys Ctrl+a for selecting all text
    Send Keys  None  CTRL+a
    #Send keys DELETE for deleting all text
    Send Keys  None  DELETE
    #Send keys for adding time value
    Send Keys  None  ${time}
    #Send keys for ENTER
    Send Keys  None  RETURN
    #Wait for some time for screen to come up
    Sleep  2
    #Click on the drop down field for Use End time
    Click  xpath  //tr[3]/td[6]/material-date-time-picker/material-time-picker/material-dropdown-select/dropdown-button/div/glyph/i
    #Wait for some time for screen to come up
    Sleep  2
    #Click on the input field for Use End time
    Click  xpath  /html/body/div/div[12]/div/div/div[2]/header/div/div/div/material-input/div/div[1]/label/input
    #Send keys Ctrl+a for selecting all text
    Send Keys  None  CTRL+a
    #Send keys DELETE for deleting all text
    Send Keys  None  DELETE
    #Send keys for adding time value
    Send Keys  None  ${time}
    #Send keys for ENTER
    Send Keys  None  RETURN
    #Wait for some time for screen to come up
    Sleep  2
    #Click move to use button
    Click  id  logisticsactions_btn_movetoused
    Sleep  3
    #Click yes button
    Click  xpath  //*[@id="logistics_common_btn_yesno"]/material-button[1]
    #Enter kit id in input bar
    Enter text  xpath  //*[@id="searchinput_totalkits"]/div[1]/div[1]/label/input  ES17
    #Press RETURN key
    Send Keys  None  RETURN
    Sleep  3
    #Click kit id
    Click  partial link  ES17
    #Verifying status for both pad is loaded
    Verify Text In Locator  xpath  //*[@id="firstWBSpecimenStatus"]  Loaded
    Verify Text in Locator  Xpath  //*[@id="secondWBSpecimenStatus"]  Loaded


    Sleep  10

    # Matrix TC-438 starts here.
    #Click search on laboratory dashboard
    Click  id  labdashboard_link_search
    #Enter kit id in input bar
    Enter text  xpath  //*[@id="searchinput_totalkits"]/div[1]/div[1]/label/input  MA01
    #Press RETURN key
    Send Keys  None  RETURN
    Sleep  3
    #Verifying kit status Reserved
    Verify  Reserved
    #Click 3 dots
    Click  id  labsearch_menu_action
    #Click comfirm by carrier
    Click  xpath  //span[contains(.,'Confirm by carrier(test)')]
    Sleep   2
    #Click confirm by carrier button
    Click  id  confirmbycarrier_btn
    Sleep  5

    #Enter kit id in input bar
    Enter text  xpath  //*[@id="searchinput_totalkits"]/div[1]/div[1]/label/input  MA01
    #Press RETURN key
    Send Keys  None  RETURN
    Sleep  2
    #Verifying kit status confirm by carrier
    Verify  Confirmed by carrier
    #Click analysis failed on left menu
    Click  id   labdashboard_link_failed
    Sleep  2

    #Enter kit id in input bar
    Enter text  xpath  //*[@id="searchinput_failed"]/div[1]/div[1]/label/input   MA01
    #press RETURN key
    Send Keys  None   RETURN
    #Verifying kit not available on analysis failed screen.
    Page should not contain  MA01PAD1
    Page should not contain  MA01PAD2

    Sleep  10


    # Matrix TC-439 starts here.
    #Click search on laboratory dashboard
    Click  id  labdashboard_link_search
    #Enter kit id in input bar
    Enter text  xpath  //*[@id="searchinput_totalkits"]/div[1]/div[1]/label/input  KT07
    #Press RETURN key
    Send Keys  None  RETURN
    Sleep  2
    #VErifying kit status is shipped by customer
    Verify  Shipped by customer
    #Click 3 dots
    Click  id  labsearch_menu_action
    #Click on Confirm by carrier
    Click  xpath  //span[contains(.,'Confirm by carrier')]
    Sleep  2
    #Click  Confirm by CaRRIER button
    Click  id  confirmbycarrier_btn
    Sleep  5

    #Enter kit id in input bar
    Enter text  xpath  //*[@id="searchinput_totalkits"]/div[1]/div[1]/label/input  KT07
    #Press RETURN key
    Send Keys  None  RETURN
    Sleep  2
    #Verify kit status confirm by carrier
    Verify  Confirmed by carrier

    #Click on incoming kits on left menu
    Click  id   labdashboard_link_incoming
    Sleep  1
    #Getting lab tracking id of kit
    ${KT07_trackingId}=   Get Tracking Number   ${APP_VERSION}  ${TEST_ENV}  KT07

    #Enter kit id in input bar
    Enter text  xpath  //*[@id="searchinput_incoming"]/div[1]/div[1]/label/input   KT07
    #Press RETURN key
    Send Keys  None   RETURN
    Sleep  2

    #Verifying kit available on incoming kit screen
    Verify    ${KT07_trackingId} (KT07)

    Sleep  10

    # Matrix TC-440 starts here.
    #Click search on Lab dashboard
    Click  id  labdashboard_link_search
    #Enter kit id in input bar
    Enter text  xpath  //*[@id="searchinput_totalkits"]/div[1]/div[1]/label/input  KT07
    #Press RETURN key
    Send Keys  None  RETURN
    Sleep  2
    #Verifyin kit status is Confirmed by carrier
    Verify  Confirmed by carrier

    #Click 3 dots
    Click  id  labsearch_menu_action
    #Click deliver to lab
    Click  xpath  //span[contains(.,'Deliver to lab')]
    #Click Deliver to lab button
    Click  id   delivertolab_btn
    Sleep  2

    #Click kits to inspect on left side menu
    Click  id  labdashboard_link_inspection
    Sleep  2
    #Enter it id in Input bar
    Enter Text  xpath  //*[@id="searchinput_kitstoinspect"]/div[1]/div[1]/label/input  KT07
    Sleep  2
    #Verifying kit available on kits to inspect screen
    Verify  ${KT07_trackingId} (KT07)

    Sleep  10

    ###Matrix TC-1135 Starts here###
    #Click on Incoming
    Click  xpath  //*[@id="labdashboard_link_incoming"]
    #Enter kit id to Search
    Enter Text  xpath  //*[@id="searchinput_incoming"]/div[1]/div[1]/label/input  KT02
    Send Keys  None  RETURN
    #Wait for screen to show up
    Sleep  3
    #Verify  status "Shipped by customer"
    Verify  Shipped by customer
    #Click on  3 dots
    Click  id  labincoming_menu_action
    #Wait for screen to show up
    Sleep  3
    #Click on mark kit delivered
    Click  Xpath  //span[contains(.,'Mark kit delivered')]
    #Wait for screen to show up
    Sleep  3
    #Click ok button
    Click  xpath  //*[@id="common_btn_okinput"]
    Sleep  3
    #Verify enter value if no track id provided and return status
    ${Result}=  Run Keyword and return status  Verify  Enter a value
    #Log Result
    Log  ${Result}
    #Click cancel if button is disable
    Run Keyword if  '${RESULT}'=='True'   Click  id  common_btn_cancelinput

    #TC-1134 starts here
    #Click on  3 dots
    Click  id  labincoming_menu_action
    #Wait for screen to show up
    Sleep  3
    #Click on mark kit delivered
    Click  Xpath  //span[contains(.,'Mark kit delivered')]
    #Wait for screen to show up
    Sleep  3
    #Enter wrong tracking number in input bar
    Enter Text  xpath  //*[@id="default-acx-overlay-container"]/div[2]/material-dialog/focus-trap/div[2]/div/main/div[2]/material-input/div[1]/div[1]/label/input  Anything123
    #Click ok button
    Click  Xpath  //*[@id="common_btn_okinput"]/material-ripple
    Sleep  3
    #Verify "sorry , wrong kit shipping track id in dialogue box"
    Verify  Sorry, Wrong Kit Shipping Track Id
    #Click ok in dialogue box
    Click  id  common_btn_okerror
    Sleep  3


    ###Matrix TC-1133 Starts here###
    #Click on  3 dots
    Click  id  labincoming_menu_action
    #Wait for screen to show up
    Sleep  3
    #Click on mark kit delivered
    Click  Xpath  //span[contains(.,'Mark kit delivered')]
    #Wait for screen to show up
    Sleep  3
    #API call to fetch kit id
    ${kitid}=  Get Kit ID  ${APP_VERSION}  ${TEST_ENV}  KT02  IN_USE
    #API call to fetch Tracking number for kit id
    ${trackingKT02}=  Get Tracking Number  ${APP_VERSION}  ${TEST_ENV}  KT02
    #Enter tracking number in input bar
    Enter Text  xpath  //*[@id="default-acx-overlay-container"]/div[2]/material-dialog/focus-trap/div[2]/div/main/div[2]/material-input/div[1]/div[1]/label/input  ${trackingKT02}
    #Click ok button
    Click  Xpath  //*[@id="common_btn_okinput"]/material-ripple
    #Wait for the screen to show up
    Sleep  3
    #Click on search kit
    Click  id  labdashboard_link_search
    #Enter KitID in Input bar.
    Enter text  xpath  //*[@id="searchinput_totalkits"]/div[1]/div[1]/label/input  KT02
    #Press RETURN Key
    Send Keys  None  RETURN
    Sleep  3
    #Verify status confirmed by lab
    Verify  Delivered at lab

    #Click on kits to inspect
    Click  xpath  //*[@id="labdashboard_link_inspection"]
    #Wait for the Screen to show up
    Sleep  3
    #Enter kit id in input bar to seach
    Enter Text  xpath  //*[@id="searchinput_kitstoinspect"]/div[1]/div[1]/label/input  KT02
    Send Keys  None  RETURN
    #Wait for the screen to show up
    Sleep  3
    #Verify kit on kits to insprct screen
    Verify  ${trackingKT02} (KT02)

    ###Matrix TC-1136 Starts here###

    #Click on Incoming
    Click  xpath  //*[@id="labdashboard_link_incoming"]
    #Enter kit id to Search
    Enter Text  xpath  //*[@id="searchinput_incoming"]/div[1]/div[1]/label/input  ES01
    Send Keys  None  RETURN
    #Wait for screen to show up
    Sleep  3
    #Verify  status "Shipped by customer"
    Verify  Confirmed by carrier
    #Click on  3 dots
    Click  id  labincoming_menu_action
    #Wait for screen to show up
    Sleep  3
    #Click on mark kit delivered
    Click  Xpath  //span[contains(.,'Mark kit delivered')]
    #Wait for screen to show up
    Sleep  3
    #API call to fetch kit id
    ${kitid}=  Get Kit ID  ${APP_VERSION}  ${TEST_ENV}  ES01  IN_USE
    #API call to fetch Tracking number for kit id
    ${trackingES01}=  Get Tracking Number  ${APP_VERSION}  ${TEST_ENV}  ES01
    #Enter tracking number in input bar
    Enter Text  xpath  //*[@id="default-acx-overlay-container"]/div[2]/material-dialog/focus-trap/div[2]/div/main/div[2]/material-input/div[1]/div[1]/label/input  ${trackingES01}
    #Click ok button
    Click  Xpath  //*[@id="common_btn_okinput"]/material-ripple
    #Wait for the screen to show up
    Sleep  3
    #Click on search kit
    Click  id  labdashboard_link_search
    #Enter KitID in Input bar.
    Enter text  xpath  //*[@id="searchinput_totalkits"]/div[1]/div[1]/label/input  ES01
    #Press RETURN Key
    Send Keys  None  RETURN
    Sleep  3
    #Verify status confirmed by lab
    Verify  Delivered at lab

    #Click on kits to inspect
    Click  xpath  //*[@id="labdashboard_link_inspection"]
    #Wait for the Screen to show up
    Sleep  3
    #Enter kit id in input bar to seach
    Enter Text  xpath  //*[@id="searchinput_kitstoinspect"]/div[1]/div[1]/label/input  ES01
    Send Keys  None  RETURN
    #Wait for the screen to show up
    Sleep  3
    #Verify kit on kits to insprct screen
    Verify  ${trackingES01} (ES01)
    Sleep  4
    ##TC-340##
    #Get  kit Tracking ID
    ${MA15_TrackingID}=  Get Tracking Number  ${APP_VERSION}  ${TEST_ENV}  MA15
    Sleep  5
    #Click on search kit
    Click  id  labdashboard_link_search
    #Enter KitID in Input bar.
    Enter text  xpath  //*[@id="searchinput_totalkits"]/div[1]/div[1]/label/input  MA15
    #Press RETURN Key
    Send Keys  None  RETURN
    Sleep  3
    #Verify page contain kit id
    Verify  ${MA15_TrackingID} (MA15)
    Sleep   4
    #Verify status 	Delivered at lab
    Verify Text In Table  xpath  //*[@id="labsearch_table"]/div/div/table   NotApplicable  ${MA15_TrackingID} (MA15)  3    Delivered at lab
    #Wait for some time for screen to come up
    Sleep  2
    #Click on KitId
    Click  partial link  MA15
    #Wait for some time for screen to come up
    Sleep  3
    #Verify Device status "Empty " for Pad 1 whole blood
    Verify Text In Locator  xpath  //*[@id="firstWBSpecimenStatus"]   Empty
    #Verify Device status "Empty " for Pad 1 Plasma
    Verify Text In Locator  xpath  //*[@id="firstPlasmaSpecimenStatus"]   Empty
    #Verify Device status "Empty " for Pad 2 whole blood
    Verify Text In Locator  xpath  //*[@id="secondWBSpecimenStatus"]   Empty
    #Verify Device status "Empty " for Pad 2 Plasma
    Verify Text In Locator  xpath  //*[@id="secondPlasmaSpecimenStatus"]  Empty
    Sleep  4
    ###TC-102###
    #Get  kit Tracking ID
    ${MA13_TrackingID}=  Get Tracking Number  ${APP_VERSION}  ${TEST_ENV}  MA13
    #Click kits to inspect on left side menu
    Click  id  labdashboard_link_inspection
    Sleep     3
    #enter text in input bar
    Enter Text  xpath  //*[@id="searchinput_kitstoinspect"]/div[1]/div[1]/label/input    MA13
    Send Keys  None  RETURN
    #Wait for the screen to show up
    Sleep  3
    #Verify kit on kits to inspect screen
    Verify  ${MA13_TrackingID} (MA13)
    Sleep   4
    #Click on KitId
    Click  partial link  MA13
    #Wait for some time for screen to come up
    Sleep  3
    #Verify Device status "Loaded " for Pad 1 whole blood
    Verify Text In Locator  xpath  //*[@id="firstWBSpecimenStatus"]   Loaded
    #Verify Device status "Loaded " for Pad 1 Plasma
    Verify Text In Locator  xpath  //*[@id="firstPlasmaSpecimenStatus"]   Loaded
    #Verify Device status "Empty " for Pad 2 whole blood
    Verify Text In Locator  xpath  //*[@id="secondWBSpecimenStatus"]   Empty
    #Verify Device status "Empty " for Pad 2 Plasma
    Verify Text In Locator  xpath   //*[@id="secondPlasmaSpecimenStatus"]  Empty
    Sleep  5
    ###TC-103###
    #Get  kit Tracking ID
    ${MA14_TrackingID}=  Get Tracking Number  ${APP_VERSION}  ${TEST_ENV}  MA14
    #Click kits to inspect on left side menu
    Click  id  labdashboard_link_inspection
    Sleep     3
    #enter text in input bar
    Enter Text  xpath  //*[@id="searchinput_kitstoinspect"]/div[1]/div[1]/label/input    MA14
    Send Keys  None  RETURN
    #Wait for the screen to show up
    Sleep  3
    #Verify kit on kits to inspect screen
    Verify  ${MA14_TrackingID} (MA14)
    Sleep   4
    #Click on KitId
    Click  partial link  MA14
    #Wait for some time for screen to come up
    Sleep  3
    #Verify Device status "Loaded " for Pad 2 whole blood
    Verify Text In Locator  xpath  //*[@id="secondWBSpecimenStatus"]   Loaded
    #Verify Device status "Loaded " for Pad 2 Plasma
    Verify Text In Locator  xpath  //*[@id="secondPlasmaSpecimenStatus"]   Loaded
    #Verify Device status "Empty " for Pad 1 whole blood
    Verify Text In Locator  xpath  //*[@id="firstWBSpecimenStatus"]   Empty
    #Verify Device status "Empty " for Pad 1 Plasma
    Verify Text In Locator  xpath   //*[@id="firstPlasmaSpecimenStatus"]  Empty
    Sleep  4
    ####TC-1241###
    ##Click on Overview
    Click  xpath  //*[@id="labdashboard_link_overview"]
    #Wait for some time for screen to come up
    Sleep  2
    #Click View Button under Kits to Inspect
    Click  id  labdashboard_btn_kitstoinspect
    #Wait for some time for screen to come up
    Sleep  3
    #Click on Input bar
    Click  Xpath  //*[@id="searchinput_kitstoinspect"]/div[1]/div[1]/label/input
    #Enter Text in Input Bar
    Enter Text  Xpath  //*[@id="searchinput_kitstoinspect"]/div[1]/div[1]/label/input  TA08
    #Send keys
    Send Keys  None  RETURN
    #Click on Menu Action three dots
    Click  id  labinspection_menu_action
    #Click on Assign Kit button
    Click  xpath  //span[contains(.,'Inspect')]
    #Wait for some time for screen to come up
    Sleep  3
    #Click Submit button
    Click  id  inspect_dialog_btn_submit
    #Wait for some time for screen to come up
    Sleep  1
    ###Click Awaiting Analysis link
    Click  xpath  //*[@id="labdashboard_link_awaiting"]
    #Click on Input bar
    Click  Xpath  //*[@id="searchinput_awaiting"]/div[1]/div[1]/label/input
    #Enter Text in Input Bar
    Enter Text  Xpath  //*[@id="searchinput_awaiting"]/div[1]/div[1]/label/input  TA08
    #Send keys
    Send Keys  None  RETURN
    #Search for the user and check the checkbox in the table
    Verify   TA08PAD1
    Sleep   3
    Verify  TA08PAD2
    Sleep   2
    ##API call to Set Physician Approval as Rejected
    ${Assayresultid}=  Get Assay Result Id   ${APP_VERSION}  ${TEST_ENV}   TA08   CONFIRMED_BY_LAB
    Set Physician Approval  ${APP_VERSION}  ${TEST_ENV}  ${Assayresultid}    REJECTED_FOR_ANALYSIS
    Sleep  4
    #Click on Overview
    Click  xpath  //*[@id="labdashboard_link_overview"]
    Sleep  4
    ##Click on Analysis Failed Screen##
    Click   id     labdashboard_btn_analysisFailed
    ##Search for the Kit##
    Enter Text  xpath  //*[@id="searchinput_failed"]/div[1]/div[1]/label/input  TA08
    #Send keys
    Send Keys  None  RETURN
    Sleep  2
    ${TA08_TrackingID}=  Get Tracking Number  ${APP_VERSION}  ${TEST_ENV}  TA08
    Sleep  5
    #Verify page should contain
    Verify  ${TA08_TrackingID} (TA08)
    Wait Until Keyword Succeeds  5x  200ms  Verify Text In Table  xpath   //*[@id="labfaildrqst_table"]/div/div/table  NotApplicable  ${TA08_TrackingID} (TA08)  3  Assays failed
    Sleep  5
    #TC-1242###
    ##Click on Overview
    Click  xpath  //*[@id="labdashboard_link_overview"]
    #Wait for some time for screen to come up
    Sleep  2
    #Click View Button under Kits to Inspect
    Click  id  labdashboard_btn_kitstoinspect
    #Wait for some time for screen to come up
    Sleep  3
    #Click on Input bar
    Click  Xpath  //*[@id="searchinput_kitstoinspect"]/div[1]/div[1]/label/input
    #Enter Text in Input Bar
    Enter Text  Xpath  //*[@id="searchinput_kitstoinspect"]/div[1]/div[1]/label/input  TA09
    #Send keys
    Send Keys  None  RETURN
    #Click on Menu Action three dots
    Click  id  labinspection_menu_action
    #Click on Assign Kit button
    Click  xpath  //span[contains(.,'Inspect')]
    #Wait for some time for screen to come up
    Sleep  3
    #Click Submit button
    Click  id  inspect_dialog_btn_submit
    #Wait for some time for screen to come up
    Sleep  1
    ###Click Awaiting Analysis link
    Click  xpath  //*[@id="labdashboard_link_awaiting"]
    #Click on Input bar
    Click  Xpath  //*[@id="searchinput_awaiting"]/div[1]/div[1]/label/input
    #Enter Text in Input Bar
    Enter Text  Xpath  //*[@id="searchinput_awaiting"]/div[1]/div[1]/label/input  TA09
    #Send keys
    Send Keys  None  RETURN
    #Search for the user and check the checkbox in the table
    Verify   TA09PAD1
    Sleep   3
    Verify  TA09PAD2
    Sleep   2
    #API call to Set Physician Approval as Approved
    ${Assayresultid}=  Get Assay Result Id   ${APP_VERSION}  ${TEST_ENV}   TA09   CONFIRMED_BY_LAB
    Set Physician Approval  ${APP_VERSION}  ${TEST_ENV}  ${Assayresultid}    APPROVED_FOR_ANALYSIS
    Sleep  4
    #Click on Overview
    Click  xpath  //*[@id="labdashboard_link_overview"]
    Sleep  4
    #Click Awaiting Analysis link
    Click  xpath  //*[@id="labdashboard_btn_awaitingAnalysis"]/material-ripple
    #Search for the user and check the checkbox in the table
    Identify And Check Checkbox  xpath  //*[@id="labawaiting_table"]/div/div/table  /material-checkbox  TA09PAD1
    #Wait for some time for screen to come up
    Sleep  1
    #Click Export button
    Click  xpath  //*[@id="export-spreadsheed"]
    #Wait for some time for screen to come up
    Sleep  1
    ${Date}=  Todays Date
    ${CollectionDate}=   Subtract time from date  ${Date}  4 hour
    ${RecivalTimeDate}=  Subtract time from date  ${Date}  2 hour
    #Based on kit to be analysed, create IMPORT XL, based on kit, pad, assay results
    #Create Assay Result Import XL Rows  ${APP_VERSION}  ${TEST_ENV}  App  Customer_Mob  January 10,1985  36  Female  TA09  TA09PAD1  12345  ${CollectionDate}   ${RecivalTimeDate}  HbA1c LDT  Approved  Whole Blood  5  %  ${emptystring}  Comments
    Create Assay Result Import XL Rows  ${APP_VERSION}  ${TEST_ENV}  App  Customer_Mob  ${humanId}  January 10,1985  36  Female  TA09  TA09PAD1  12345  2  ${CollectionDate}  ${CollectionDate}  ${RecivalTimeDate}  HbA1c  Approved  Whole Blood  5  %  ${emptystring}  Comments
    #Click on Import results and call API to Import the Assay Results
    Import Lab Results And Open Import Details  xpath  //*[@id="labdashboard_link_imports"]  ${APP_VERSION}  ${TEST_ENV}
    #Wait for some time for screen to come up
    Sleep  3
    #Check the assay result status
    Verify Text In Locator  xpath  //*[@id="assayresultimports_smart_table"]/div/div/table//tbody/tr/td[6]  Success
    #Check the assay name as provided in Assay Result XL
    Verify Text In Locator  xpath  //*[@id="assayresultimports_smart_table"]/div/div/table//tbody/tr/td[3]  HbA1c LDT
    #Check the assay result value as provided in Assay Result XL
    Verify Text In Locator  xpath  //*[@id="assayresultimports_smart_table"]/div/div/table//tbody/tr/td[5]  5
    #Click Analysis complete link
    Click  xpath  //*[@id="labdashboard_link_complete"]
    #Click on Input Bar
    Click  Xpath  //*[@id="searchinput_complete"]/div[1]/div[1]/label/input
    #Enter text in input bar
    Enter Text  Xpath  //*[@id="searchinput_complete"]/div[1]/div[1]/label/input  TA09
    #send keys
    Send Keys  None  RETURN
    #Click on kit-id, from completed list
    Click  Partial link  TA09
    #Check the analysis request status
    Verify Text In Locator  xpath  //*[@id="analysisRequestStatus"]  Analysis complete
    #Wait for some time for screen to come up
    Sleep  4
    #API call to Set Physician Approval as Approved
    ${Assayresultid}=  Get Assay Result Id   ${APP_VERSION}  ${TEST_ENV}   TA09   CONFIRMED_BY_LAB
    Set Physician Approval  ${APP_VERSION}  ${TEST_ENV}  ${Assayresultid}    REJECTED_FOR_RELEASE
    Sleep  4
    ##Click on Overview
    Click  xpath  //*[@id="labdashboard_link_overview"]
    Sleep  4
    ##Click on Analysis Failed Screen##
    Click   id     labdashboard_btn_analysisFailed
    ##Search for the Kit##
    Enter Text  xpath  //*[@id="searchinput_failed"]/div[1]/div[1]/label/input  TA09
    #Send keys
    Send Keys  None  RETURN
    Sleep  2
    ${TA09_TrackingID}=  Get Tracking Number  ${APP_VERSION}  ${TEST_ENV}  TA09
    Sleep  5
    #Verify page should contain
    Verify  ${TA09_TrackingID} (TA09)
    Wait Until Keyword Succeeds  5x  200ms  Verify Text In Table  xpath   //*[@id="labfaildrqst_table"]/div/div/table  NotApplicable  ${TA09_TrackingID} (TA09)  3  Assays failed
    Sleep  5
    #TC-1243##
    #Click on Overview
    Click  xpath  //*[@id="labdashboard_link_overview"]
    #Wait for some time for screen to come up
    Sleep  2
    #Click View Button under Kits to Inspect
    Click  id  labdashboard_btn_kitstoinspect
    #Wait for some time for screen to come up
    Sleep  3
    #Click on Input bar
    Click  Xpath  //*[@id="searchinput_kitstoinspect"]/div[1]/div[1]/label/input
    #Enter Text in Input Bar
    Enter Text  Xpath  //*[@id="searchinput_kitstoinspect"]/div[1]/div[1]/label/input  TA10
    #Send keys
    Send Keys  None  RETURN
    #Click on Menu Action three dots
    Click  id  labinspection_menu_action
    #Click on Assign Kit button
    Click  xpath  //span[contains(.,'Inspect')]
    #Wait for some time for screen to come up
    Sleep  3
    #Click Submit button
    Click  id  inspect_dialog_btn_submit
    #Wait for some time for screen to come up
    Sleep  1
    ###Click Awaiting Analysis link
    Click  xpath  //*[@id="labdashboard_link_awaiting"]
    #Click on Input bar
    Click  Xpath  //*[@id="searchinput_awaiting"]/div[1]/div[1]/label/input
    #Enter Text in Input Bar
    Enter Text  Xpath  //*[@id="searchinput_awaiting"]/div[1]/div[1]/label/input  TA10
    #Send keys
    Send Keys  None  RETURN
    #Search for the user and check the checkbox in the table
    Verify   TA10PAD1
    Sleep   3
    Verify  TA10PAD2
    Sleep   2
    #API call to Set Physician Approval as Approved
    ${Assayresultid}=  Get Assay Result Id   ${APP_VERSION}  ${TEST_ENV}   TA10   CONFIRMED_BY_LAB
    Set Physician Approval  ${APP_VERSION}  ${TEST_ENV}  ${Assayresultid}    APPROVED_FOR_ANALYSIS
    Sleep  4
    ###Click on Overview
    Click  xpath  //*[@id="labdashboard_link_overview"]
    Sleep  4
    #Click Awaiting Analysis link
    Click  xpath  //*[@id="labdashboard_btn_awaitingAnalysis"]/material-ripple
    #Search for the user and check the checkbox in the table
    Identify And Check Checkbox  xpath  //*[@id="labawaiting_table"]/div/div/table  /material-checkbox  TA10PAD1
    #Wait for some time for screen to come up
    Sleep  1
    #Click Export button
    Click  xpath  //*[@id="export-spreadsheed"]
    #Wait for some time for screen to come up
    Sleep  1
    ${Date}=  Todays Date
    ${CollectionDate}=   Subtract time from date  ${Date}  4 hour
    ${RecivalTimeDate}=  Subtract time from date  ${Date}  2 hour
    #Based on kit to be analysed, create IMPORT XL, based on kit, pad, assay results
    #Create Assay Result Import XL Rows  ${APP_VERSION}  ${TEST_ENV}  App  Customer_Mob  January 10,1985  36  Female  TA10  TA10  12345  ${CollectionDate}   ${RecivalTimeDate}  HbA1c LDT  Approved  Whole Blood  ${emptystring}  %  Hemolysis  Comments
    Create Assay Result Import XL Rows  ${APP_VERSION}  ${TEST_ENV}  App  Customer_Mob  ${humanId}  January 10,1985  36  Female  TA10  TA10PAD1  12345  2  ${CollectionDate}  ${CollectionDate}  ${RecivalTimeDate}  HbA1c  Approved  Whole Blood  ${emptystring}  %  Hemolysis}  Comments
    #Click on Import results and call API to Import the Assay Results
    Import Lab Results And Open Import Details  xpath  //*[@id="labdashboard_link_imports"]  ${APP_VERSION}  ${TEST_ENV}
    #Wait for some time for screen to come up
    #Check the assay result status
    Verify Text In Locator  xpath  //*[@id="assayresultimports_smart_table"]/div/div/table//tbody/tr/td[6]  Success
    ##Click on Overview
    Click  xpath  //*[@id="labdashboard_link_overview"]
    Sleep  4
    #Click Awaiting Analysis link
    Click  xpath  //*[@id="labdashboard_btn_awaitingAnalysis"]/material-ripple
    #Search for the user and check the checkbox in the table
    Identify And Check Checkbox  xpath  //*[@id="labawaiting_table"]/div/div/table  /material-checkbox  TA10PAD1
    #Wait for some time for screen to come up
    Sleep  1
    #Click Export button
    Click  xpath  //*[@id="export-spreadsheed"]
    #Wait for some time for screen to come up
    Sleep  1
    ${Date}=  Todays Date
    ${CollectionDate}=   Subtract time from date  ${Date}  4 hour
    ${RecivalTimeDate}=  Subtract time from date  ${Date}  2 hour
    #Based on kit to be analysed, create IMPORT XL, based on kit, pad, assay results
    #Create Assay Result Import XL Rows  ${APP_VERSION}  ${TEST_ENV}  App  Customer_Mob  January 10,1985  36  Female  TA10  TA10PAD2  12345  ${CollectionDate}   ${RecivalTimeDate}  HbA1c LDT  Approved  Whole Blood  ${emptystring}  %  Hemolysis  Comments
    Create Assay Result Import XL Rows  ${APP_VERSION}  ${TEST_ENV}  App  Customer_Mob  ${humanId}  January 10,1985  36  Female  TA10  TA10PAD2  12345  2  ${CollectionDate}  ${CollectionDate}  ${RecivalTimeDate}  HbA1c  Approved  Whole Blood  ${emptystring}  %  Hemolysis  Comments
    #Click on Import results and call API to Import the Assay Results
    Import Lab Results And Open Import Details  xpath  //*[@id="labdashboard_link_imports"]  ${APP_VERSION}  ${TEST_ENV}
    #Wait for some time for screen to come up
    #Check the assay result status
    Verify Text In Locator  xpath  //*[@id="assayresultimports_smart_table"]/div/div/table//tbody/tr/td[6]  Success
    #Click Analysis failure link
    Click  xpath  //*[@id="labdashboard_link_failed"]
    #Click on Input Bar
    Click  Xpath  //*[@id="searchinput_failed"]/div[1]/div[1]/label/input
    #Enter text in input bar
    Enter Text  Xpath  //*[@id="searchinput_failed"]/div[1]/div[1]/label/input  TA10
    #send keys
    Send Keys  None  RETURN
    #Wait for some time for screen to come up
    Sleep  5
    #Verify the text in table
    Verify Text In Table  xpath  //*[@id="labfaildrqst_table"]/div/div/table  NotApplicable  TA10PAD1  3  Analysis failed
    #Click on kit-id, from completed list
    Click  partial link  TA10
    #Check the analysis request status
    Verify Text In Locator  xpath  //*[@id="analysisRequestStatus"]  Failed
    #Wait for some time for screen to come up
    Sleep  2
    #Close browser
    Close Browser



