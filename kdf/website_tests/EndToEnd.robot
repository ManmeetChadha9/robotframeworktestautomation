*** Settings ***
Documentation  This is a test suite for Qurasense GUI Testing
Resource  ../data/global_variables.robot
Resource    ../resources/page_actions.robot
Resource    ../resources/custom_actions.robot
Library  HttpLibrary
Library  SeleniumLibrary

*** Variables ***

*** Test Cases ***

ROBOT_ETE_01

    #Generate  token for admin user
    Create Admin Authentication Endpoint  _admin@qvin.com  secret  123  EMAIL
    #Generate  token for logistics user
    Create Logistics Authentication Endpoint  _logistics@qvin.com  secret  123  EMAIL
    #Generate  token for doctor
    Create Doctor Authentication Endpoint  _doctor@qvin.com  secret  123  EMAIL
    #Generate  token for receiving
    Create Receiving Authentication Endpoint  _receiving@qvin.com  secret  123  EMAIL
    #Generate  token for customer
    ${customermobappendpoint}=  Create Customer Authentication Endpoint  _customermobapp@qvin.com  secret  123  EMAIL
    #${dendiuserendpoint}=  Create Dendiuser Authentication Endpoint  manmeet@qvin.com  Striker@123
    #Generate  token for lab user
    Create Lab Authentication Endpoint  _lab@qvin.com  secret  123  EMAIL


    # Navigate to browser with desired capabilities like console logs etc
    #Navigate To With Chrome Option And Desired Capabilities  ${BROWSER}  ${DASHBOARD_URL}
    Navigate To  ${BROWSER}  ${DASHBOARD_URL}
    #Open Browser  ${DASHBOARD_URL}  ${BROWSER}
    ${log entries}=    Get Browser Console Log Entries
    #Sleep  50
    Log    ${log entries}
#
    Verify  Log in
    #Click username
    Click  css  input[type='text']
    #Enter username
    Enter Text  css  input[type='text']  _doctor@qvin.com
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
    #Click on customer_input text box
    Click  id  customer_input_search
    #Click customer name to search
    Enter Text  xpath  //*[@id="customer_input_search"]/div[1]/div[1]/label/input  Customer_Mob
    #Pressing RETURN key so tht it can search
    Send Keys  None  RETURN
    #Click on Costomer_Mob App
    Click  link  Customer_Mob App
    Sleep  5
    #Click on Create Order
    Click  id  buttonCreateorder
    #Click on dropdown to select Product Type
    Click  Id  dropdown_kit_bundle
    #select Product Diabetes Minimum
#    Click  Xpath  //material-select-item[contains(.,'Diabetes_Minimum_LDT')]
    Click  Xpath  //material-select-item[contains(.,'Bundle_QPAD_PP_A1C')]
    #Enter no of kits
    Enter Text  xpath  //*[@id="widgetkitreq_input_noofkits"]/div/div[1]/label/input  1
    #Click address dropdown and select address
    Click  id  dropdown_address
    Click  Xpath  //material-select-item[contains(.,'255 Warren Street, JERSEY CITY, NJ, 07302')]
    #Click pament Dropdown and select payment mode
    #Click  Id  dropdown_payment_method
   # Click  Xpath  //material-select-item[contains(.,'Qvin')]
    #Click on Ok button on popup window to confirm Address
    Click  xpath  //*[@id="widgetkitreq_btn_okinput"]
    #Wait for some time so that page could load
    Sleep  3
    #Wait for some time so that this text appears
    Verify  Address have warning. Are you sure you want to use it?
    #Click yes buttom
    Click  xpath  //*[@id="logistics_common_btn_yesno"]/material-button[1]/material-ripple
    #Wait for screen to show up
    Sleep  3
    #Click on Orders on the left side Menu
    Wait Until Keyword Succeeds  5x  200ms  Click  id  medicaldashboard_listitem_orders
    #Getting order id form table
    ${orderid1}=  Get Text From Table  Xpath  //*[@id="medicalorders_table"]/div/div/table  NotApplicable  Customer_Mob App  1
    #Wait for some time so that page could load
    Sleep  5
    log  ${orderid1}
   #close the browser
    Close browser

    #Open Fulfillment Dashboard

    # Navigate to browser with desired capabilities like console logs etc
    #Navigate To With Chrome Option And Desired Capabilities  ${BROWSER}  ${DASHBOARD_URL}
    Navigate To  ${BROWSER}  ${DASHBOARD_URL}
    #Open Browser  ${DASHBOARD_URL}  ${BROWSER}
    Sleep  60
    ${log entries}=    Get Browser Console Log Entries
    #Sleep  50
    Log    ${log entries}
    Verify  Log in
    #Click username
    Click  css  input[type='text']
    #Enter username
    Enter Text  css  input[type='text']  _fulfillment@qvin.com
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
    #Click dashboard button on left menu
    Click  xpath  //*[@id="fulfillment_listitem_dashboard"]
    #click on order to fulfill
    #Click  xpath  //*[@id="fulfilledorders_smart_table"]/div/div/table/tbody/tr[1]/td[1]/a
    Click  link  ${orderid1}
    #Enter kit id
    Enter Text  xpath   //*[@id="fulfillmentorders-table"]/tr[2]/td[3]/input  Test2-080
    #Click on dropdown for shipping config
    Click  xpath  //*[@id="fulfillmentdashboard_dropdown_shippingconfig"]
    #Select a value
    Click  Xpath  //material-select-item[contains(.,'To customer one kit package')]
    Sleep  5
    #Click on Print label button
    Click  xpath  //*[@id="fulfillmentorders_btn_printlabel"]
    Sleep  5
    #Closing print label tab
    #Click on fulfilled button
    Click  xpath  //*[@id="fulfillmentorders_btn_fulfilled"]
    #Verify the order id being fulfilled disappears from the fulfillment dashboard
#    Verify Text Not Exists Anymore  ${orderid1}
    #click on orders menu on the left side of screen to expand it
    Click  xpath  /html/body/app/fulfillment/material-drawer/material-list/div/material-expansionpanel/div/header/div
    #click on fullfilled button in the expanded menu
    Click  xpath  //*[@id="fulfillment_listitem_orderfulfilled"]
    #check checkbox in the table to ship order
    Identify And Check Checkbox  xpath  //*[@id="fulfilledorders_smart_table"]/div/div/table  //*[@id="fulfilledorders_checkbox"]  ${orderid1}
    #click button Ship order to ship the kits
    Click  xpath  //*[@id="fulfilledorders_btn_shiporders"]
    #close the browser
    Close browser

    #Open  Logistics Dashboard

    #Open Browser and navigate to the desired URL
    #Navigate To And Verify  ${BROWSER}  ${DASHBOARD_URL}/#/site/login  Qvin
    Navigate To  ${BROWSER}  ${DASHBOARD_URL}
    #Open Browser  ${DASHBOARD_URL}  ${BROWSER}
    #Click username
    Click  css  input[type='text']
    #Enter username
    Enter Text  css  input[type='text']  _logistics@qvin.com
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
    #Register the Qpad for the mentioned customer
    ${new}=  Get Legal ID  ${APP_VERSION}  ${SECURE_URL}  _customermobapp@qvin.com
    Log to Console  ${new}
    log  ${new}


    Register Qpad  ${APP_VERSION}  ${SECURE_URL}  ${customermobappendpoint}  T2080QPA  _customermobapp@qvin.com
    #API call to mark start collection process of a pad
    Pad Start Collection  ${APP_VERSION}  ${SECURE_URL}  ${customermobappendpoint}  T2080QPA  _customermobapp@qvin.com  REGISTERED
    #Sleep  so that the next notofication to user can be verified
    Sleep  10
    #API call to mark end collection process of a pad
    Pad End Collection  ${APP_VERSION}  ${SECURE_URL}  ${customermobappendpoint}  T2080QPA  _customermobapp@qvin.com  IN_USE
    #Sleep  so that the next notofication to user can be verified
    Sleep  30
    #API call to mark start collection process of a pad
    Pad Start Collection   ${APP_VERSION}  ${SECURE_URL}  ${customermobappendpoint}  T2080QPB  _customermobapp@qvin.com  IN_USE
    #Sleep  so that the next notofication to user can be verified
    Sleep  10
    #API call to mark end collection process of a pad
    Pad End Collection  ${APP_VERSION}  ${SECURE_URL}  ${customermobappendpoint}  T2080QPB  _customermobapp@qvin.com  IN_USE
    #Sleep  so that the next notofication to user can be verified
    Sleep  30
    #Click on Dashboard link
    Click  xpath  //*[@id="logistics_listitem_dashboard"]
    #Wait for some time for screen to come up
    Sleep  2
    #clicking total kits
    Click  xpath  //*[@id="logisticsdashboard_btn_kitstotal"]
    #Enter Kit name to search
    Enter Text  xpath  //*[@id="logisticskits_input_kitid"]/div[1]/div[1]/label/input  Test2-080
    #Click Search
    Click  id  logisticskits_btn_search
    #Wait for some time for screen to come up
    Sleep  2
    #Click on Dots
    Click  id  logisticskits_menu_action
    #Click on Confirm by carrier
    Click  xpath  //span[contains(.,'Shipped by customer')]
    #Wait for some time for screen to come up
    Sleep   2
    Click  xpath  //*[@id="logisticsactions_btn_confirmshipment"]/material-ripple
    #enter text in input bar
    Enter Text  xpath  //*[@id="logisticskits_input_kitid"]/div[1]/div[1]/label/input  Test2-080
    #Wait for some time for screen to come up
    Sleep  2
    #click on search button
    Click  id  logisticskits_btn_search
    #Wait for some time for screen to come up
    Sleep  2
    #click on dots
    Click  id  logisticskits_menu_action
    #Wait for some time for screen to come up
    Sleep  2
    Click  xpath  //span[contains(.,'Confirm by carrier')]
    #Wait for some time for screen to come up
    Sleep  2
    Click   xpath   //*[@id="confirmbycarrier_btn"]
    #Wait for some time for screen to come up
    Sleep  2
    Enter Text  xpath  //*[@id="logisticskits_input_kitid"]/div[1]/div[1]/label/input  Test2-080
    #Wait for some time for screen to come up
    Sleep  2
    #    #click on search button
    Click  id  logisticskits_btn_search
    #Wait for some time for screen to come up
    Sleep   2
    Click  id  logisticskits_menu_action
    #Wait for some time for screen to come up
    Sleep  2
    Click  xpath  //span[contains(.,'Deliver to Receiving')]
    #Wait for some time for screen to come up
    Sleep  2
    Click   xpath   //*[@id="delivertolab_btn"]
    #Wait for some time for screen to come up
    Sleep   2

    Close Browser

    #Open _receiving Dashboard

#    #Open Browser and navigate to the desired URL
#    Navigate To And Verify  ${BROWSER}  ${DASHBOARD_URL}  Qvin
#    #Click username
#    Click  css  input[type='text']
#    #Enter username
##    Enter Text  css  input[type='text']  _lab@qvin.com
#    Enter Text  css  input[type='text']  _receiving@qvin.com
#    #Click password
#    Click  css  input[type='password']
#    #Enter password
#    Enter Text  css  input[type='password']  secret
#    #Click Login button
#    Click  id  login_btn_signin
#    #Wait for some time for 2fa input to come up
#    Sleep  2
#    #Click 2facode input text
#    Click  id  login_input_2facode
#    #Enter 2FA code
#    Enter Text  xpath  //*[@id="login_input_2facode"]/div[1]/div[1]/label/input  123
#    #Click Login button
#    Click  id  login_btn_signin
#    #Wait for some time for screen to come up
#    Sleep  2
#    #Click on Delivered at Receiving Kits
#    Click   xpath   //*[@id="receivingdashboard_btn_received"]/material-ripple
#    Sleep   2
#    Enter Text  xpath   /html/body/app/receiving/div/div/receiving/section[2]/div/filter/section/section[1]/material-input/div/div[1]/label/input   Test2-080
#    Sleep  2
#    #Pressing RETURN key so tht it can search
#    Send Keys  None  RETURN
#    #sleep so that it load the searched kits
#    Sleep  2
#    #clicking on three dots
#    Click   id   receivingkits_menu_action
#    Sleep   2
#    #click on Receive button in three dots menu
#    Click  xpath  //span[contains(.,'Receive')]
#    #Wait for some time for screen to come up
#    Sleep  2
#    #clicking on yes on dialogue box
#    Click  xpath  //*[@id="logistics_common_btn_yesno"]/material-button[1]
#    Sleep  5
#    Click   id   receivingdashboard_link_ready
#    Sleep   2
#    Click   id   receivingkits_menu_action
#    #click on Receive button in three dots menu
#    Click  xpath  //span[contains(.,'Deliver To Lab')]
#    #Wait for some time for screen to come up
#    Sleep  2
#    #clicking on yes on dialogue box
#    Click  xpath  //*[@id="logistics_common_btn_yesno"]/material-button[1]
#    #Wait for some time for screen to come up
#    Sleep  5
#    ${dendiAccessToken}=  Get Json Param Dendi  ${DENDI_URL}  token
#    Log to Console  ${dendiAccessToken}
#    ${dendiOrderCode}=   Get Dendi Order Code  ${APP_VERSION}  ${SECURE_URL}  Test2-080
#    Log to Console  ${dendiOrderCode}
#
#    ${hbA1CTest}    Create Dictionary    name=A1c    qualitativeValue=None    quantitativeValue=5.6    resultType=Quantitative
#    ${hbA1CResult}    Create List    ${hbA1CTest}
#    Log    ${hbA1CResult}
#
#    ${dendiOrderUuid}=  Get Dendi Order UUID  ${DENDI_URL}  ${dendiOrderCode}
#    ${dendiTest}=  Get Dendi Order Tests  ${DENDI_URL}  ${dendiOrderCode}
#    Receive Dendi Order  ${DENDI_URL}  ${dendiOrderCode}  ${dendiAccessToken}
#    ${list}=  Create Dendi List For HbA1c  ${dendiTest}  5.6
#
#    Set Dendi Result  ${DENDI_URL}  ${dendiAccessToken}  ${list}
#    Verify Dendi Result  ${DENDI_URL}  ${dendiAccessToken}  ${dendiOrderCode}

######
#    Set Dendi Result  ${DENDI_URL}  ${dendiOrderCode}
#   ${uuid}=    Get Dendi Order UUID  https://qvin.dendi-sandbox.com/api  ${externalOrderCode}  5c6b129460126974536af7e6f64a0db4f93d326c
#   Log to Console  ${uuid}
 #   Receive Dendi Order    https://qvin.dendi-sandbox.com/api   883a994b-5ded-4455-ae57-eb832fd24ceb  5c6b129460126974536af7e6f64a0db4f93d326c

 #Click on Kits to Inspect
#    Click  xpath  //*[@id="labdashboard_link_inspection"]
#    #sleep so that incoming kits load
#    Sleep  2
#    #Click on Search
#    Click  xpath  //*[@id="searchinput_kitstoinspect"]/div/div/label/input
#    #sleep so that it enable input
#    Sleep  2
#    #Enter Kit name to search
#    Enter Text  xpath  //*[@id="searchinput_kitstoinspect"]/div/div/label/input  Test2-100
#    #sleep so that input is given
#    Sleep  2
#    #Pressing RETURN key so tht it can search
#    Send Keys  None  RETURN
#    #sleep so that it load the searched kits
#    Sleep  2
#    #clicking on three dots
#    Click  id  labinspection_menu_action
#    #wait for the menu to come up
#    Sleep  2
#    #click on inspect button in three dots menu
#    Click  xpath  //span[contains(.,'Inspect')]
#    #Wait for some time for screen to come up
#    Sleep  2
#    #clicking on submit button on dialogue box
#    Click  id  inspect_dialog_btn_submit
#    #Wait for some time for screen to come up
#    Sleep  5
#    #click on awaiting analysis button
#    Click  id  labdashboard_link_awaiting
#    #Wait for some time for screen to come up
#    Sleep  3
#    #click on search
#    Click  xpath  //input[@type='text']
#    #sleep so that it enable input
#    Sleep  3
#    #entering kit name to search
#    Enter Text  xpath  //input[@type='text']  Test2-100
#    #sleep so that input is given
#    Sleep  3
#    #Send keys RETURN
#    Identify And Check Checkbox  xpath  //*[@id="labawaiting_table"]/div/div/table  /material-checkbox  T2100QPA
#    #Wait for some time for screen to come up
#    Sleep  1
#    #Click Export button
#    Click  xpath  //*[@id="export-spreadsheed"]
#    Send Keys  None  RETURN
#    #Search for the user and check the checkbox in the table
#    #Wait for some time for screen to come up
#    Sleep  5
#    ${Date}=  Todays Date
#    ${CollectionDate}=   Subtract time from date  ${Date}  4 hour
#    ${RecivalTimeDate}=  Subtract time from date  ${Date}  2 hour
#    ${legalid}=  Get Legal ID    ${APP_VERSION}  ${DASHBOARD_URL}     _customermobapp@qvin.com
#    ${humanId}=  Get Human ID  ${APP_VERSION}  ${DASHBOARD_URL}  ${legalid}
#    Log  ${humanId}
#    #Based on kit to be analysed, create IMPORT XL, based on kit, pad, assay results
#    Create Assay Result Import XL Rows  ${APP_VERSION}  ${DASHBOARD_URL}    App   Customer_Mob   ${humanId}  January 10,1985  36  Female  Test2-100  T2100QPA  12345  2  ${CollectionDate}  ${CollectionDate}  ${RecivalTimeDate}  HbA1c  Approved  Whole Blood  8  %  ${emptystring}  Comments
#    #Click on Import results and call API to Import the Assay Results
#    Import Lab Results And Open Import Details  xpath  //*[@id="labdashboard_link_imports"]  ${APP_VERSION}  ${DASHBOARD_URL}
#    #Wait for some time for screen to come up
#    Sleep  3
#    #Check the assay result status
#    Verify Text In Locator  xpath  //*[@id="assayresultimports_smart_table"]/div/div/table//tbody/tr/td[6]  Success
#    Close Browser



# ROBOT_ETE_02

#    #Generate  token for admin user
#    Create Admin Authentication Endpoint  _admin@qvin.com  secret  123  EMAIL
#    #Generate  token for logistics user
#    Create Logistics Authentication Endpoint  _logistics@qvin.com  secret  123  EMAIL
#    #Generate  token for doctor
#    Create Doctor Authentication Endpoint  _doctor@qvin.com  secret  123  EMAIL
#    #Generate  token for customer
#    ${customermobappendpoint}=  Create Customer Authentication Endpoint  _customermobapp@qvin.com  secret  123  EMAIL

    #Open Browser and vavigate to desired URL
#    Navigate To And Verify  ${BROWSER}  ${DASHBOARD_URL}  Qvin
#    #Click username
#    Click  css  input[type='text']
#    #Enter username
#    Enter Text  css  input[type='text']  _doctor@qvin.com
#    #Click password
#    Click  css  input[type='password']
#    #Enter password
#    Enter Text  css  input[type='password']  secret
#    #Click Login button
#    Click  id  login_btn_signin
#    #Wait for some time for 2fa input to come up
#    Sleep  2
#    #Click 2facode input text
#    Click  id  login_input_2facode
#    #Enter 2FA code
#    Enter Text  xpath  //*[@id="login_input_2facode"]/div[1]/div[1]/label/input  123
#    #Click Login button
#    Click  id  login_btn_signin
#    #Click on customer_input text box
#    Click  id  customer_input_search
#    #Click customer name to search
#    Enter Text  xpath  //*[@id="customer_input_search"]/div[1]/div[1]/label/input  Customer_Mob
#    #Pressing RETURN key so tht it can search
#    Send Keys  None  RETURN
#    #Click on Costomer_Mob App
#    Click  link  Customer_Mob App
#    Sleep  5
#    #Click on Create Order
#    Click  id  buttonCreateorder
#
#    Click  Id  dropdown_kit_bundle
#    #select Product Diabetes Minimum
##    Click  Xpath  //material-select-item[contains(.,'Diabetes_Minimum_LDT')]
#    Click  Xpath  //material-select-item[contains(.,'Bundle_QPAD_PP_A1C')]
#    #Enter no of kits
#    Enter Text  xpath  //*[@id="widgetkitreq_input_noofkits"]/div/div[1]/label/input  1
#    #Click address dropdown and select address
#    Click  id  dropdown_address
#    Click  Xpath  //material-select-item[contains(.,'255 Warren Street, Jersey City, NJ, 17302')]
#    #Click pament Dropdown and select payment mode
#    Click  Id  dropdown_payment_method
#    Click  Xpath  //material-select-item[contains(.,'Qvin')]
#    #Click on Ok button on popup window to confirm Address
#    Click  xpath  //*[@id="widgetkitreq_btn_okinput"]
#    #Wait for some time so that page could load
#    Sleep  3
#    #Wait for some time so that this text appears
#    Verify  Address have warning. Are you sure you want to use it?
#    #Click yes buttom
#    Click  xpath  //*[@id="logistics_common_btn_yesno"]/material-button[1]/material-ripple
#    #Wait for screen to show up
#    Sleep  3
#    #Click on Orders on the left side Menu
#    Wait Until Keyword Succeeds  5x  200ms  Click  id  medicaldashboard_listitem_orders
#    #Getting order id form table
#    ${orderid2}=  Get Text From Table  Xpath  //*[@id="medicalorders_table"]/div/div/table  NotApplicable  Customer_Mob App  1
#    #Wait for some time so that page could load
#    Sleep  5
#    log  ${orderid2}
#    #Close all browser
#    #close browser
#    [Teardown]    Close All Browsers
#
#    #Open Fulfillment Dashboard
#
#    #Open Browser and vavigate to desired URL
#    Navigate To And Verify  ${BROWSER}  ${DASHBOARD_URL}  Qvin
#    #Click username
#    Click  css  input[type='text']
#    #Enter username
#    Enter Text  css  input[type='text']  _fulfillment@qvin.com
#    #Click password
#    Click  css  input[type='password']
#    #Enter password
#    Enter Text  css  input[type='password']  secret
#    #Click Login button
#    Click  id  login_btn_signin
#    #Wait for some time for 2fa input to come up
#    Sleep  2
#    #Click 2facode input text
#    Click  id  login_input_2facode
#    #Enter 2FA code
#    Enter Text  xpath  //*[@id="login_input_2facode"]/div[1]/div[1]/label/input  123
#    #Click Login button
#    Click  id  login_btn_signin
#    #Click dashboard button on left menu
#    Click  xpath  //*[@id="fulfillment_listitem_dashboard"]
#    #click on order to fulfill
#    #Click  xpath  //*[@id="fulfilledorders_smart_table"]/div/div/table/tbody/tr[1]/td[1]/a
#    Click  link  ${orderid2}
#    #Enter kit id
#    Enter Text  xpath   //*[@id="fulfillmentorders-table"]/tr[2]/td[3]/input  TA07
#    #Click on dropdown for shipping config
#    Click  xpath  //*[@id="fulfillmentdashboard_dropdown_shippingconfig"]
#    #Select a value
#    Click  Xpath  //material-select-item[contains(.,'To customer one kit package')]
#    Sleep  5
#    #Click on Print label button
#    Click  xpath  //*[@id="fulfillmentorders_btn_printlabel"]
#    Sleep  5
#    #Closing print label tab
#    #Click on fulfilled button
#    Click  xpath  //*[@id="fulfillmentorders_btn_fulfilled"]
#    #Verify the order id being fulfilled disappears from the fulfillment dashboard
##    Verify Text Not Exists Anymore  ${orderid1}
#    #click on orders menu on the left side of screen to expand it
#    Click  xpath  /html/body/app/fulfillment/material-drawer/material-list/div/material-expansionpanel/div/header/div
#    #click on fullfilled button in the expanded menu
#    Click  xpath  //*[@id="fulfillment_listitem_orderfulfilled"]
#    #check checkbox in the table to ship order
#    Identify And Check Checkbox  xpath  //*[@id="fulfilledorders_smart_table"]/div/div/table  //*[@id="fulfilledorders_checkbox"]  ${orderid2}
#    #click button Ship order to ship the kits
#    Click  xpath  //*[@id="fulfilledorders_btn_shiporders"]
#    #close the browser
#    Close browser

    #Open  Logistics Dashboard

#    #Open Browser and navigate to the desired URL
#    Navigate To And Verify  ${BROWSER}  ${DASHBOARD_URL}/#/site/login  Qvin
#    #Click username
#    Click  css  input[type='text']
#    #Enter username
#    Enter Text  css  input[type='text']  _logistics@qvin.com
#    #Click password
#    Click  css  input[type='password']
#    #Enter password
#    Enter Text  css  input[type='password']  secret
#    #Click Login button
#    Click  xpath  /html/body/app/site/div/login/section/form/div/material-button/material-ripple
#    #Click Login button
#    Click  id  login_btn_signin
#    #Wait for some time for 2fa input to come up
#    Sleep  2
#    #Click 2facode input text
#    Click  id  login_input_2facode
#    #Enter 2FA code
#    Enter Text  xpath  //*[@id="login_input_2facode"]/div[1]/div[1]/label/input  123
#    #Click Login button
#    Click  id  login_btn_signin
    #Register the Qpad for the mentioned customer
#    Register Qpad  ${APP_VERSION}  ${SECURE_URL}  ${customermobappendpoint}  TA07PAD1  _customermobapp@qvin.com
#    #API call to mark start collection process of a pad
#    Pad Start Collection  ${APP_VERSION}  ${SECURE_URL}  ${customermobappendpoint}  TA07PAD1  _customermobapp@qvin.com  REGISTERED
#    #Sleep  so that the next notofication to user can be verified
#    Sleep  10
#    #API call to mark end collection process of a pad
#    Pad End Collection  ${APP_VERSION}  ${SECURE_URL}  ${customermobappendpoint}  TA07PAD1  _customermobapp@qvin.com  IN_USE
#    #Sleep  so that the next notofication to user can be verified
#    Sleep  30
#    #API call to mark start collection process of a pad
#    Pad Start Collection   ${APP_VERSION}  ${SECURE_URL}  ${customermobappendpoint}  TA07PAD2  _customermobapp@qvin.com  IN_USE
#    #Sleep  so that the next notofication to user can be verified
#    Sleep  10
#    #API call to mark end collection process of a pad
#    Pad End Collection  ${APP_VERSION}  ${SECURE_URL}  ${customermobappendpoint}  TA07PAD2  _customermobapp@qvin.com  IN_USE
#    #Sleep  so that the next notofication to user can be verified
#    Sleep  30
#    #Click on Dashboard link
#    Click  xpath  //*[@id="logistics_listitem_dashboard"]
#    #Wait for some time for screen to come up
#    Sleep  2
#    #clicking total kits
#    Click  xpath  //*[@id="logisticsdashboard_btn_kitstotal"]
#    #Enter Kit name to search
#    Enter Text  xpath  //*[@id="logisticskits_input_kitid"]/div[1]/div[1]/label/input  TA07
#    #Click Search
#    Click  id  logisticskits_btn_search
#    #Wait for some time for screen to come up
#    Sleep  2
#    #Click on Dots
#    Click  id  logisticskits_menu_action
#    #Click on Confirm by carrier
#    Click  xpath  //span[contains(.,'Shipped by customer')]
#    #Wait for some time for screen to come up
#    Sleep   2
#    Click  xpath  //*[@id="logisticsactions_btn_confirmshipment"]/material-ripple
#    #enter text in input bar
#    Enter Text  xpath  //*[@id="logisticskits_input_kitid"]/div[1]/div[1]/label/input  TA07
#    #Wait for some time for screen to come up
#    Sleep  2
#    #click on search button
#    Click  id  logisticskits_btn_search
#    #Wait for some time for screen to come up
#    Sleep  2
#    #click on dots
#    Click  id  logisticskits_menu_action
#    #Wait for some time for screen to come up
#    Sleep  2
#    Click  xpath  //span[contains(.,'Confirm by carrier')]
#    #Wait for some time for screen to come up
#    Sleep  2
#    Click   xpath   //*[@id="confirmbycarrier_btn"]
#    #Wait for some time for screen to come up
#    Sleep  2
#    Enter Text  xpath  //*[@id="logisticskits_input_kitid"]/div[1]/div[1]/label/input  TA07
#    #Wait for some time for screen to come up
#    Sleep  2
#    #    #click on search button
#    Click  id  logisticskits_btn_search
#    #Wait for some time for screen to come up
#    Sleep   2
#    Click  id  logisticskits_menu_action
#    #Wait for some time for screen to come up
#    Sleep  2
#    Click  xpath  //span[contains(.,'Deliver to Receiving')]
#    #Wait for some time for screen to come up
#    Sleep  2
#    Click   xpath   //*[@id="delivertolab_btn"]
#    #Wait for some time for screen to come up
#    Sleep   2
#
#    Close Browser

#    #Open _receiving Dashboard
#
#    #Open Browser and navigate to the desired URL
#    Navigate To And Verify  ${BROWSER}  ${DASHBOARD_URL}  Qvin
#    #Click username
#    Click  css  input[type='text']
#    #Enter username
##    Enter Text  css  input[type='text']  _lab@qvin.com
#    Enter Text  css  input[type='text']  _receiving@qvin.com
#    #Click password
#    Click  css  input[type='password']
#    #Enter password
#    Enter Text  css  input[type='password']  secret
#    #Click Login button
#    Click  id  login_btn_signin
#    #Wait for some time for 2fa input to come up
#    Sleep  2
#    #Click 2facode input text
#    Click  id  login_input_2facode
#    #Enter 2FA code
#    Enter Text  xpath  //*[@id="login_input_2facode"]/div[1]/div[1]/label/input  123
#    #Click Login button
#    Click  id  login_btn_signin
#    #Wait for some time for screen to come up
#    Sleep  2
#    #Click on Delivered at Receiving Kits
#    Click   xpath   //*[@id="receivingdashboard_btn_received"]/material-ripple
#    Sleep   2
#    Enter Text  xpath   /html/body/app/receiving/div/div/receiving/section[2]/div/filter/section/section[1]/material-input/div/div[1]/label/input   Test2-081
#    Sleep  2
#    #Pressing RETURN key so tht it can search
#    Send Keys  None  RETURN
#    #sleep so that it load the searched kits
#    Sleep  2
#    #clicking on three dots
#    Click   id   receivingkits_menu_action
#    Sleep   2
#    #click on Receive button in three dots menu
#    Click  xpath  //span[contains(.,'Receive')]
#    #Wait for some time for screen to come up
#    Sleep  2
#    #clicking on yes on dialogue box
#    Click  xpath  //*[@id="logistics_common_btn_yesno"]/material-button[1]
#    Sleep  5
#    Click   id   receivingdashboard_link_ready
#    Sleep   2
#    Click   id   receivingkits_menu_action
#    #click on Receive button in three dots menu
#    Click  xpath  //span[contains(.,'Deliver To Lab')]
#    #Wait for some time for screen to come up
#    Sleep  2
#    #clicking on yes on dialogue box
#    Click  xpath  //*[@id="logistics_common_btn_yesno"]/material-button[1]
#
#    #Wait for some time for screen to come up
#    Sleep  5
#
#

#
#    #Open Laboratory Dashboard
#
#    #Open Browser and navigate to the desired URL
#    Navigate To And Verify  ${BROWSER}  ${DASHBOARD_URL}  Qvin
#    #Click username
#    Click  css  input[type='text']
#    #Enter username
#    Enter Text  css  input[type='text']  _lab@qvin.com
#    #Click password
#    Click  css  input[type='password']
#    #Enter password
#    Enter Text  css  input[type='password']  secret
#    #Click Login button
#    Click  id  login_btn_signin
#    #Wait for some time for 2fa input to come up
#    Sleep  2
#    #Click 2facode input text
#    Click  id  login_input_2facode
#    #Enter 2FA code
#    Enter Text  xpath  //*[@id="login_input_2facode"]/div[1]/div[1]/label/input  123
#    #Click Login button
#    Click  id  login_btn_signin
#    #Wait for some time for screen to come up
#    Sleep  2
#    #Click on Kits to Inspect
#    Click  xpath  //*[@id="labdashboard_link_inspection"]
#    #sleep so that incoming kits load
#    Sleep  2
#    #Click on Search
#    Click  xpath  //*[@id="searchinput_kitstoinspect"]/div/div/label/input
#    #sleep so that it enable input
#    Sleep  2
#    #Enter Kit name to search
#    Enter Text  xpath  //*[@id="searchinput_kitstoinspect"]/div/div/label/input  TA07
#    #sleep so that input is given
#    Sleep  2
#    #Pressing RETURN key so tht it can search
#    Send Keys  None  RETURN
#    #sleep so that it load the searched kits
#    Sleep  2
#    #clicking on three dots
#    Click  id  labinspection_menu_action
#    #wait for the menu to come up
#    Sleep  2
#    #click on inspect button in three dots menu
#    Click  xpath  //span[contains(.,'Inspect')]
#    #Click on Device is missing checkbox
#    Click  id  TA07PAD1-missing
#    #Click on Device is missing checkbox
#    Click  id  TA07PAD2-missing
#    #Wait for some time for screen to come up
#    Sleep  2
#    #Clicking on submit button on dialogue box
#    Click  id  inspect_dialog_btn_submit
#    #Click on yes button
#    Click  id  inspect_dialog_btn_yes
#    #Wait for some time for screen to come up
#    Sleep  5
#    #Click Analysis failure link
#    Click  xpath  //*[@id="labdashboard_link_failed"]
#    #wait for the screen to show up
#    Sleep  2
#    #enter text in input bar
#    Enter Text  xpath  //*[@id="searchinput_failed"]/div/div/label/input    TA07
#    #click on RETURN key
#    Send Keys  None  RETURN
#    #Verify the text in table
#    Wait Until Keyword Succeeds  5x  200ms  Verify Text In Table  xpath  //*[@id="labfaildrqst_table"]/div/div/table  NotApplicable  TA07PAD1  3  Inspection failed
#    #Click on kit-id, from completed list
#    Click  partial link  TA07
#    #Check the analysis request status
#    #Verify Text In Locator  xpath  //*[@id="singleanalysisrequest_smart_table"]/div/div/table//tbody/tr/td[2]  Failed
#    #Verify Status "failed"
#    Verify  Failed
#    #Wait for some timet
#    Sleep  3
#    #Close Browser
#    Close browser

#ROBOT_ETE_03
#
#
#    #Open Browser and navigate to the desired URL
#    Navigate To  ${BROWSER}  ${TEST_ENV}/#/site/login
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
#    Click  xpath  /html/body/app/site/div/login/section/form/div/material-button/material-ripple
#    #Click Login button
#    Click  id  login_btn_signin
#    #Wait for some time for 2fa input to come up
#    Sleep  2
#    #Click 2facode input text
#    Click  id  login_input_2facode
#    #Enter 2FA code
#    Enter Text  xpath  //*[@id="login_input_2facode"]/div[1]/div[1]/label/input  123
#    #Click Login button
#    Click  id  login_btn_signin
#    #Click analysis request
#    Click  xpath  //*[@id="medicaldashboard_listitem_analysisrequests"]
#    #click input
#    Click  xpath  /html/body/app/medical/div/div/requests/section[2]/div[1]/section/material-input/div[1]/div[1]/label/input
#    #enter text
#    Enter Text  xpath  /html/body/app/medical/div/div/requests/section[2]/div[1]/section/material-input/div[1]/div[1]/label/input  QT36
#    #Tap RETURN key
#    Send Keys  None  RETURN
#    #Click Analysis id for kit
#    Click  xpath  //*[@id="smart_table_medicalrequests"]/tbody/tr/td[1]/a
#    # Verify kit id
#    Verify Text In Locator  xpath  /html/body/app/medical/div/div/analysis-request-detail/div[2]/card[1]/div[2]/request-details/table/tr[3]/td[2]/a   QT01
#
#    # Verify all results
#
#    Verify Text in Table  xpath  //*[@id="analysisrequest_table_assay_results"]/div/div/table  NotApplicable  AMH Calculated   3  Approved
#    Verify Text in Table  xpath  //*[@id="analysisrequest_table_assay_results"]/div/div/table  NotApplicable  AMH Calculated   6  Approved
#    Verify Text in Table  xpath  //*[@id="analysisrequest_table_assay_results"]/div/div/table  NotApplicable  AMH Calculated   4  0.62 ng/mL
#
#    Verify Text in Table  xpath  //*[@id="analysisrequest_table_assay_results"]/div/div/table  NotApplicable  LH Calculated   3  Approved
#    Verify Text in Table  xpath  //*[@id="analysisrequest_table_assay_results"]/div/div/table  NotApplicable  LH Calculated   6  Approved
#    Verify Text in Table  xpath  //*[@id="analysisrequest_table_assay_results"]/div/div/table  NotApplicable  LH Calculated   4  2.10 mIU/mL
#
#    Verify Text in Table  xpath  //*[@id="analysisrequest_table_assay_results"]/div/div/table  NotApplicable  FSH Calculated   3  Approved
#    Verify Text in Table  xpath  //*[@id="analysisrequest_table_assay_results"]/div/div/table  NotApplicable  FSH Calculated   6  Approved
#    Verify Text in Table  xpath  //*[@id="analysisrequest_table_assay_results"]/div/div/table  NotApplicable  FSH Calculated   4  2.94 mIU/mL
#
#    Verify Text in Table  xpath  //*[@id="analysisrequest_table_assay_results"]/div/div/table  NotApplicable  TSH Calculated   3  Approved
#    Verify Text in Table  xpath  //*[@id="analysisrequest_table_assay_results"]/div/div/table  NotApplicable  TSH Calculated   6  Approved
#    Verify Text in Table  xpath  //*[@id="analysisrequest_table_assay_results"]/div/div/table  NotApplicable  TSH Calculated   4  0.43 µIU/mL
#
#    Verify Text in Table  xpath  //*[@id="analysisrequest_table_assay_results"]/div/div/table  NotApplicable  A1c   3  Approved
#    Verify Text in Table  xpath  //*[@id="analysisrequest_table_assay_results"]/div/div/table  NotApplicable  A1c   6  Approved
#    Verify Text in Table  xpath  //*[@id="analysisrequest_table_assay_results"]/div/div/table  NotApplicable  A1c   4  4.10 %
#
#
#
#    Close Browser


ROBOT_ETE_04

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
    #Enter Text  xpath  /html/body/app/medical/div/div/requests/section[2]/div[1]/section/material-input/div[1]/div[1]/label/input  QT36
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



