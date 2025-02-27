*** Settings ***
Documentation  This is a test suite for Qurasense GUI Testing
Resource  ../data/GlobalVariables.robot
Resource    ../resources/PageActions.robot
Resource    ../resources/CustomActions.robot
*** Variables ***

*** Test Cases ***

ROBOT_FULFILL_01
    #Generate  token for admin user
    Create Admin Authentication Endpoint  _admin@qvin.com  secret  1234567  EMAIL
    #Generate  token for logistics user
    Create Logistics Authentication Endpoint  _logistics@qvin.com  secret  1234567  EMAIL
    #Generate  token for doctor
    Create Doctor Authentication Endpoint  _doctor@qvin.com  secret  1234567  EMAIL
    #Generate token for fullfillment dashboard
    Create Fulfillment Authentication Endpoint  _fulfillment@qvin.com  secret  1234567  EMAIL
    #Create an order for 2 kits, for customer _customermobapp@qvin.com
    ${orderid1}=  Create Order  ${APP_VERSION}  ${SECURE_URL}  _customermobapp@qvin.com   Bundle_QPAD_PP_A1C   2
    #API call to validate address
    ${address}=  Validate Address  ${APP_VERSION}  ${SECURE_URL}   _customermobapp@qvin.com   255 Warren St   07302-3722  NJ  US  Jersey City  SHIPPING
    #API call to Set shipment address
    Shipment Order  ${APP_VERSION}  ${SECURE_URL}  ${orderid1}  ${address}
    ${ordernumber1}=  Get Order Number  ${APP_VERSION}  ${SECURE_URL}  ${orderid1}
    #Create an order for 1 kit, for customer _customermobapp@qvin.com
    ${orderid2}=  Create Order  ${APP_VERSION}  ${SECURE_URL}  _customermobapp@qvin.com   Bundle_QPAD_PP_A1C  1
    #API call to validate address
    ${address}=  Validate Address  ${APP_VERSION}  ${SECURE_URL}   _customermobapp@qvin.com   255 Warren St   07302-3722  NJ  US  Jersey City  SHIPPING
    #API call to Set shipment address
    Shipment Order  ${APP_VERSION}  ${SECURE_URL}  ${orderid2}  ${address}
    ${ordernumber2}=  Get Order Number  ${APP_VERSION}  ${SECURE_URL}  ${orderid2}
    #Create an order for 1 kit, for customer _customermobapp@qvin.com
    ${orderid3}=  Create Order  ${APP_VERSION}  ${SECURE_URL}  _customermobapp@qvin.com   Bundle_QPAD_PP_A1C  1
    #API call to validate address
    ${address}=  Validate Address  ${APP_VERSION}  ${SECURE_URL}   _customermobapp@qvin.com   255 Warren St   07302-3722  NJ  US  Jersey City  SHIPPING
    #API call to Set shipment address
    Shipment Order  ${APP_VERSION}  ${SECURE_URL}  ${orderid3}  ${address}
    ${ordernumber3}=  Get Order Number  ${APP_VERSION}  ${SECURE_URL}  ${orderid3}
    #Create an order for 2 kits, for customer _customermobapp@qvin.com
    ${orderid4}=  Create Order  ${APP_VERSION}  ${SECURE_URL}  _customermobapp@qvin.com   Bundle_QPAD_PP_A1C  2
    #API call to validate address
    ${address}=  Validate Address  ${APP_VERSION}  ${SECURE_URL}   _customermobapp@qvin.com   255 Warren St   07302-3722  NJ  US  Jersey City  SHIPPING
    #API call to Set shipment address
    Shipment Order  ${APP_VERSION}  ${SECURE_URL}  ${orderid4}  ${address}
    ${ordernumber4}=  Get Order Number  ${APP_VERSION}  ${SECURE_URL}  ${orderid4}
    #Create an order for 3 kits, for customer _customermobapp@qvin.com
    ${orderid5}=  Create Order  ${APP_VERSION}  ${SECURE_URL}  _customermobapp@qvin.com   Bundle_QPAD_PP_A1C  3
    #API call to validate address
    ${address5}=  Validate Address  ${APP_VERSION}  ${SECURE_URL}   _customermobapp@qvin.com   255 Warren St   07302-3722  NJ  US  Jersey City  SHIPPING
    #API call to Set shipment address
    Shipment Order  ${APP_VERSION}  ${SECURE_URL}  ${orderid5}  ${address5}
    ${ordernumber5}=  Get Order Number  ${APP_VERSION}  ${SECURE_URL}  ${orderid5}
    # Navigate to browser with desired capabilities like console logs etc
    Navigate To With Chrome Option And Desired Capabilities  ${BROWSER}  ${DASHBOARD_URL}
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
    #Click on order to fulfill
    ###Click  xpath  //*[@id="fulfilledorders_smart_table"]/div/div/table/tbody/tr[1]/td[1]/a
    Click  link  ${ordernumber1}
    ##Enter kit id
    Enter Text  xpath   //*[@id="fulfillmentorders-table"]/tr[2]/td[3]/input  TA01
    #enter kit id
    Enter Text  xpath   //*[@id="fulfillmentorders-table"]/tr[3]/td[3]/input  TA02
    #Click on dropdown to select Product Type
    Click  Id  fulfillmentdashboard_dropdown_shippingconfig
    #select Product Diabetes Minimum
    Click  Xpath  //material-select-item[contains(.,'To customer one kit package')]
    #Click on Print Label button
    Click  xpath  //*[@id="fulfillmentorders_btn_printlabel"]
    #Wait for some time
    Sleep  2
    #Click on fulfilled button
    #Click  xpath  /html/body/app/fulfillment/div/div/dashboard/section[3]/div/div[2]/div[3]/material-button/material-ripple
    Click  xpath  //*[@id="fulfillmentorders_btn_fulfilled"]
    Sleep  5
    #Click on order to fulfill
    Click  link  ${ordernumber2}
    #Enter kit id
    Enter Text  xpath   //*[@id="fulfillmentorders-table"]/tr[2]/td[3]/input  TA03
    #Click on dropdown to select Product Type
    Click  Id  fulfillmentdashboard_dropdown_shippingconfig
    #select Product Diabetes Minimum
    Click  Xpath  //material-select-item[contains(.,'To customer one kit package')]
    #Click on Print Label button
    Click  xpath  //*[@id="fulfillmentorders_btn_printlabel"]
    #Wait for some time
    Sleep  2
    #click on fulfilled button
    #Click  xpath  /html/body/app/fulfillment/div/div/dashboard/section[3]/div/div[2]/div[3]/material-button/material-ripple
    Click  xpath  //*[@id="fulfillmentorders_btn_fulfilled"]
    Sleep  5
    #click on order to fulfill
    Click  link  ${ordernumber3}
    #enter kit id
    Enter Text  xpath   //*[@id="fulfillmentorders-table"]/tr[2]/td[3]/input  TA04
    #Click on dropdown to select Product Type
    Click  Id  fulfillmentdashboard_dropdown_shippingconfig
    #select Product Diabetes Minimum
    Click  Xpath  //material-select-item[contains(.,'To customer one kit package')]
    #Click on Print Label button
    Click  xpath  //*[@id="fulfillmentorders_btn_printlabel"]
    #Wait for some time
    Sleep  2
    #Click on fulfilled button
    Click  xpath  //*[@id="fulfillmentorders_btn_fulfilled"]
    Sleep  5
    #Click on order to fulfill
    Click  link  ${ordernumber4}
    #Enter Kit id
    Enter Text  xpath   //*[@id="fulfillmentorders-table"]/tr[2]/td[3]/input  TA05
    #Enter kit id
    Enter Text  xpath   //*[@id="fulfillmentorders-table"]/tr[3]/td[3]/input  TA06
    #select Product Diabetes Minimum
    #Click on dropdown to select Product Type
    Click  Id  fulfillmentdashboard_dropdown_shippingconfig
    #select Product Diabetes Minimum
    Click  Xpath  //material-select-item[contains(.,'To customer one kit package')]
    ##Click on Print Label button
    Click  xpath  //*[@id="fulfillmentorders_btn_printlabel"]
    #Wait for some time
    Sleep  5
    #Click on fulfilled button
    Click  xpath  //*[@id="fulfillmentorders_btn_fulfilled"]
    Sleep  5
    #Click on order to fulfill
    Click  link  ${ordernumber5}
    #enter kit id
    Enter Text  xpath   //*[@id="fulfillmentorders-table"]/tr[2]/td[3]/input  TA08
    #enter kit id
    Enter Text  xpath   //*[@id="fulfillmentorders-table"]/tr[3]/td[3]/input  TA09
    #enter kit id
    Enter Text  xpath   //*[@id="fulfillmentorders-table"]/tr[4]/td[3]/input  TA10
    #Click on dropdown to select Product Type
    Click  Id  fulfillmentdashboard_dropdown_shippingconfig
    #select Product Diabetes Minimum
    Click  Xpath  //material-select-item[contains(.,'To customer one kit package')]
    #Click on Print Label button
    Click  xpath  //*[@id="fulfillmentorders_btn_printlabel"]
    #Wait for some time
    Sleep  5
    #Click on fulfilled button
    #Click  xpath  /html/body/app/fulfillment/div/div/dashboard/section[3]/div/div[2]/div[3]/material-button/material-ripple
    Click  xpath  //*[@id="fulfillmentorders_btn_fulfilled"]
    Sleep  5
    #Click on orders menu on the left side of screen to expand it
    Click  xpath  /html/body/app/fulfillment/material-drawer/material-list/div/material-expansionpanel/div/header/div
    #Click on fullfilled button in the expanded menu
    Click  xpath  //*[@id="fulfillment_listitem_orderfulfilled"]
    #Check checkbox in the table to ship order
    Identify And Check Checkbox  xpath  //*[@id="fulfilledorders_smart_table"]/div/div/table  //*[@id="fulfilledorders_checkbox"]  ${ordernumber3}
    #Check checkbox in the table to ship order
    Identify And Check Checkbox  xpath  //*[@id="fulfilledorders_smart_table"]/div/div/table  //*[@id="fulfilledorders_checkbox"]  ${ordernumber4}
    #Check checkbox in the table to ship order
    Identify And Check Checkbox  xpath  //*[@id="fulfilledorders_smart_table"]/div/div/table  //*[@id="fulfilledorders_checkbox"]  ${ordernumber5}
    #Click button Ship order to ship the kits
    Click  xpath  //*[@id="fulfilledorders_btn_shiporders"]
    Sleep  5
    #Close the browser
    Close browser