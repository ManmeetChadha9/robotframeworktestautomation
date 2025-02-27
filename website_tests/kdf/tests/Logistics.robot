*** Settings ***
Documentation  This is a test suite for Qurasense GUI Testing
Resource  ../data/GlobalVariables.robot
Resource    ../resources/PageActions.robot
Resource    ../resources/CustomActions.robot
*** Variables ***

*** Test Cases ***

ROBOT_LOG_01
    #Generate  token for admin user
    Create Admin Authentication Endpoint  _admin@qvin.com  secret  123  EMAIL
    #Generate  token for logistics user
    Create Logistics Authentication Endpoint  _logistics@qvin.com  secret  123  EMAIL
    #Generate  token for doctor
    Create Doctor Authentication Endpoint  _doctor@qvin.com  secret  123  EMAIL
    #Generate  token for customer
    ${customermobappendpoint}=  Create Customer Authentication Endpoint  _customermobapp@qvin.com  secret  123  EMAIL
    #Create an order for 3 kits, for customer _customermobapp@qvin.com
#    ${orderid}=  Create Order  ${APP_VERSION}  ${TEST_ENV}  _customermobapp@qvin.com   Heart Health  3
#    #Based on order created, extract order lines and create IMPORT XL, based on number of kits required by the order
#    ${kitIdsConcatenated}  ${kitOrderJson}  Create Kit Import XL Rows  ${APP_VERSION}  ${TEST_ENV}  T997  12345   T997P1  123  T997P2  123   Heart Health  ${orderid}  92020902823611000052
#    #Using the created XL, add kits to inventory and assign kits
#    Import Kits to Stock  ${APP_VERSION}  ${TEST_ENV}
#    #Ship the order based on order id
#    Ship Order  ${APP_VERSION}  ${TEST_ENV}  ${orderid}
#    #Create an order for 2 kits, for customer _customermobapp@qvin.com
#    ${orderid}=  Create Order  ${APP_VERSION}  ${TEST_ENV}  _customermobapp@qvin.com  Diabetes minimum  2
#    #Based on order created, extract order lines and create IMPORT XL, based on number of kits required by the order
#    ${kitIdsConcatenated}  ${kitOrderJson}  Create Kit Import XL Rows  ${APP_VERSION}  ${TEST_ENV}  T996  12245  T996P1  122  T996P2  122  Diabetes minimum  ${orderid}  92020902823611000053
#    #Using the created XL, add kits to inventory and assign kits
#    Import Kits to Stock  ${APP_VERSION}  ${TEST_ENV}
#    #Create an order for 2 kits, for customer _customermobapp@qvin.com
#    ${orderid}=  Create Order  ${APP_VERSION}  ${TEST_ENV}  _customermobapp@qvin.com   Heart Health  2
#    #Based on order created, extract order lines and create IMPORT XL, based on number of kits required by the order
#    ${kitIdsConcatenated}  ${kitOrderJson}  Create Kit Import XL Rows  ${APP_VERSION}  ${TEST_ENV}  T995  12225  T995P1  111  T995P2  111   Heart Health  ${orderid}  92020902823611000054
#    #Using the created XL, add kits to inventory and assign kits
#    Import Kits to Stock  ${APP_VERSION}  ${TEST_ENV}
#    #Create an order for 3 kits, for customer _customermobapp@qvin.com
#    ${orderid}=  Create Order   ${APP_VERSION}  ${TEST_ENV}  _customermobapp@qvin.com   Heart Health  3
#    #Based on order created, extract order lines and create IMPORT XL, based on number of kits required by the order
#    ${kitIdsConcatenated}  ${kitOrderJson}  Create Kit Import XL Rows  ${APP_VERSION}  ${TEST_ENV}  T994  11345  T994P1  123  T994P2  123   Heart Health  ${orderid}  92020902823611000055
#    #Using the created XL, add kits to inventory and assign kits
#    Import Kits to Stock  ${APP_VERSION}  ${TEST_ENV}
#    #Ship the order based on order id
#    Ship Order  ${APP_VERSION}  ${TEST_ENV}  ${orderid}
    #Open Browser and navigate to the desired URL
    Navigate To And Verify  ${BROWSER}  ${TEST_ENV}/#/site/login  Qvin
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
    #Click on Dashboard link
    Click  xpath  //*[@id="logistics_listitem_dashboard"]
    # Verify the count displayed on UI for kits in status=REGISTERED
    ${kitsCountFetched}=  Get Kits Count  ${APP_VERSION}  ${TEST_ENV}  REGISTERED
    click element  id=logisticsdashboard_kitAmt_registered
    ${kitsCountRead}=  get text  id=logisticsdashboard_kitAmt_registered
    Should Be Equal As Strings    ${kitsCountRead}    ${kitsCountFetched}
    # Verify the count displayed on UI for kits in status=SHIPPED_BY_CUSTOMER
    ${kitsCountFetched}=  Get Kits Count  ${APP_VERSION}  ${TEST_ENV}  SHIPPED_BY_CUSTOMER
    click element  id=logisticsdashboard_kitAmt_shippedbycustomer
    ${kitsCountRead}=  get text  id=logisticsdashboard_kitAmt_shippedbycustomer
    Should Be Equal As Strings    ${kitsCountRead}    ${kitsCountFetched}
    # Verify the count displayed on UI for kits in status=DELIVERED_AT_LAB
    ${kitsCountFetched}=  Get Kits Count  ${APP_VERSION}  ${TEST_ENV}  DELIVERED_AT_LAB
    click element  id=logisticsdashboard_kitAmt_deliveredatlab
    ${kitsCountRead}=  get text  id=logisticsdashboard_kitAmt_deliveredatlab
    Should Be Equal As Strings    ${kitsCountRead}    ${kitsCountFetched}
    # Verify the count displayed on UI for kits in status=RESERVED
    ${kitsCountFetched}=  Get Kits Count  ${APP_VERSION}  ${TEST_ENV}  RESERVED
    click element  id=logisticsdashboard_kitAmt_reserved
    ${kitsCountRead}=  get text  id=logisticsdashboard_kitAmt_reserved
    Should Be Equal As Strings    ${kitsCountRead}    ${kitsCountFetched}
    # Verify the count displayed on UI for kits in status=IN_USE
    ${kitsCountFetched}=  Get Kits Count  ${APP_VERSION}  ${TEST_ENV}  IN_USE
    click element  id=logisticsdashboard_kitAmt_inuse
    ${kitsCountRead}=  get text  id=logisticsdashboard_kitAmt_inuse
    Should Be Equal As Strings    ${kitsCountRead}    ${kitsCountFetched}
    #Wait for some time for screen to come up
    Sleep  1
    #Close the Browser being used for test.
    Close Browser

ROBOT_LOG_02
    #Generate  token for admin user
    Create Admin Authentication Endpoint  _admin@qvin.com  secret  123  EMAIL
    #Generate  token for logistics user
    Create Logistics Authentication Endpoint  _logistics@qvin.com  secret  123  EMAIL
    #Generate  token for doctor
    Create Doctor Authentication Endpoint  _doctor@qvin.com  secret  123  EMAIL
    #Generate  token for customer
    ${customermobappendpoint}=  Create Customer Authentication Endpoint  _customermobapp@qvin.com  secret  123  EMAIL
    #Open Browser and navigate to the desired URL
    Navigate To And Verify  ${BROWSER}  ${TEST_ENV}/#/site/login  Qvin
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
    #Click on Dashboard link
    Click  xpath  //*[@id="logistics_listitem_dashboard"]
    #Click on Kits link
#    Click  xpath  //*[@id="logistics_listitem_kits"]
    #Click on Reserved button
    Click  xpath  //*[@id="logisticsdashboard_btn_kitsreserved"]
    #Enter Kit name to search
    Enter Text  xpath  //*[@id="logisticskits_input_kitid"]/div[1]/div[1]/label/input  ES20
    #Click Search
    Click  id  logisticskits_btn_search
    #Wait for some time for screen to come up
    Sleep  2
    #Click on Dots
    Click  id  logisticskits_menu_action
    #Click on Move to Use
    Click  xpath  //span[contains(.,'Move to use')]
    #Wait for some time for screen to come up
    Sleep  2
    #Uncheck the checkbox to remove the second pad
    Click  xpath  //tr[3]/td[2]/*[@id="logistics_padusedcheckbox"]/div[1]/material-ripple
    #Wait for some time for screen to come up
    Sleep  2
    #Get the current date
    ${date}=  Get Current Date  exclude_millis=TRUE
    #Wait for some time for screen to come up
    Sleep  2
    #Get the time element from the current date extracted
    ${time}=  Get Time From Date  ${date}
    #Click on the drop down for Use Time
    Click  xpath  //tr[2]/td[2]/div/material-date-time-picker/material-time-picker/material-dropdown-select/dropdown-button/div/glyph/i
    #Wait for some time for screen to come up
    Sleep  2
    #Click on the input field for Use Time
    Click  xpath  /html/body/div/div[8]/div/div/div[2]/header/div/div/div/material-input/div/div/label/input
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
    #Take screenshot of the screen
    Capture Page Screenshot
    #Click on MoveToUsed button
    Click  xpath  //*[@id="logisticsactions_btn_movetoused"]
    #Click on YES button
    Click  xpath  //*[@id="logistics_common_btn_yesno"]/material-button[1]/material-ripple
    #Enter Kit name to search
    Enter Text  xpath  //*[@id="logisticskits_input_kitid"]/div[1]/div[1]/label/input  ES19
    #Click Search
    Click  id  logisticskits_btn_search
    #Wait for some time for screen to come up
    Sleep  2
    #Click on Dots
    Click  id  logisticskits_menu_action
    #Click on Confirm by carrier
    Click  xpath  //span[contains(.,'Confirm by carrier(test: fail analysis request)')]
    #Click on Confirm By Carrier button
    Click  xpath  //*[@id="confirmbycarrier_btn"]
    #Click on Dashboard link
    Click  xpath  //*[@id="logistics_listitem_dashboard"]
    #Click on Confirm by carrier
    click  id  logisticsdashboard_btn_kitsconfirmedbycarrier
    Enter Text  xpath  //*[@id="logisticskits_input_kitid"]/div[1]/div[1]/label/input  ES19
    #click on search
    Click   id  logisticskits_btn_search
    Sleep  3
    Verify   ES19
    #click Kit_id
    #Wait Until Keyword Succeeds  5x  200ms  Click  link  ES19
    #Click on 3 dots and  Add use time button under kit detail screen.
    Click   id   logisticskits_menu_action
    #Wait Until Keyword Succeeds  5x  200ms  Click  link  ES01
    Sleep  3
    Wait Until Keyword Succeeds  5x  200ms  Click   xpath  //span[contains(.,'Add use times')]
    #Wait Until Keyword Succeeds  5x  200ms  Click  link  ES19
    Sleep  3
    #Click on Add use time button under kit detail screen.
    #Click   id   showAddUseTimeButton
    #Wait for some time for screen to come up
    Sleep  2
    #Uncheck the checkbox to remove the second pad
    Click  xpath  //tr[3]/td[2]/*[@id="logistics_padusedcheckbox"]/div[1]/material-ripple
    #Wait for some time for screen to come up
    Sleep  2
    #Get the current date
    ${date}=  Get Current Date  exclude_millis=TRUE
    #Wait for some time for screen to come up
    Sleep  2
    #Get the time element from the current date extracted
    ${time}=  Get Time From Date  ${date}
    #Click on the drop down for Use Time
    Click  xpath  //tr[1]/td[2]/div/material-date-time-picker/material-time-picker/material-dropdown-select/dropdown-button/div/glyph/i
    #Wait for some time for screen to come up
    Sleep  2
    #Click on the input field for Use Time
    Click  xpath   /html/body/div/div[8]/div/div/div[2]/header/div/div/div/material-input/div/div[1]/label/input
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
    Click  xpath  //tr[2]/td[4]/material-date-time-picker/material-time-picker/material-dropdown-select/dropdown-button/div/glyph/i
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
    Click  xpath  //tr[2]/td[6]/material-date-time-picker/material-time-picker/material-dropdown-select/dropdown-button/div/glyph/i
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
    #Take screenshot of the screen
    Capture Page Screenshot
    #Click on MoveToUsed button
    Click  xpath  //*[@id="logisticsactions_btn_movetoused"]
    #Click on YES button
    Click  xpath  //*[@id="logistics_common_btn_yesno"]/material-button[1]/material-ripple

    #Click on Dashboard link
    Click  xpath  //*[@id="logistics_listitem_dashboard"]
    #Click on Kits in Use button
    Click  xpath  //*[@id="logisticsdashboard_btn_kitsinuse"]
    #Enter Kit name to search
    Enter Text  xpath  //*[@id="logisticskits_input_kitid"]/div[1]/div[1]/label/input  ES20
    #Click Search
    Click  id  logisticskits_btn_search
    #Wait for some time for screen to come up
    Sleep  2
    #Click on Dots
    Click  id  logisticskits_menu_action
    #Click on Shipped by Customer
    Click  xpath  //span[contains(.,'Shipped by customer')]
    #Click on Confirm Shipment button
    Click  xpath  //*[@id="logisticsactions_btn_confirmshipment"]
    #Click on Dashboard link
    Click  xpath  //*[@id="logistics_listitem_dashboard"]
    #Click on Shipped By Customer button
    Click  xpath  //*[@id="logisticsdashboard_btn_kitshippedbycustomer"]
    #Enter Kit name to search
    Enter Text  xpath  //*[@id="logisticskits_input_kitid"]/div[1]/div[1]/label/input  ES20
    #Click Search
    Click  id  logisticskits_btn_search
    #Wait for some time for screen to come up
    Sleep  2
    #Click on Dots
    Click  id  logisticskits_menu_action
    #Click on Reject by Logistics
    Click  xpath  //span[contains(.,'Reject by logistics')]
    #Click on YES button
    Click  xpath  //*[@id="logistics_common_btn_yesno"]/material-button[1]/material-ripple
    #Register the Qpad for the mentioned customer
    Register Qpad  ${APP_VERSION}  ${TEST_ENV}  ${customermobappendpoint}  MA10PAD1  _customermobapp@qvin.com
    #API call to mark start collection process of a pad
    Pad Start Collection  ${APP_VERSION}  ${TEST_ENV}   ${customermobappendpoint}  MA10PAD1  _customermobapp@qvin.com  REGISTERED
    #Sleep  so that the next notofication to user can be verified
    Sleep  10
    #API call to mark end collection process of a pad
    Pad End Collection  ${APP_VERSION}  ${TEST_ENV}  ${customermobappendpoint}  MA10PAD1  _customermobapp@qvin.com  IN_USE
    #Sleep  so that the next notofication to user can be verified
    Sleep  30
    #API call to mark start collection process of a pad
    Pad Start Collection  ${APP_VERSION}  ${TEST_ENV}  ${customermobappendpoint}  MA10PAD2  _customermobapp@qvin.com  IN_USE
    #Sleep  so that the next notofication to user can be verified
    Sleep  10
    #API call to mark end collection process of a pad
    Pad End Collection  ${APP_VERSION}  ${TEST_ENV}  ${customermobappendpoint}  MA10PAD2  _customermobapp@qvin.com  IN_USE
    #get kit id
    ${kitid}=  Get Kit ID  ${APP_VERSION}  ${TEST_ENV}  MA10   IN_USE
    #Sleep  so that the next notofication to user can be verified
    Sleep  30
    Click  id  logistics_listitem_kits
    #Click on Kits button
    Click  xpath  //*[@id="logistics_listitem_kittotalkits"]
    #Enter Kit name to search
    Enter Text  xpath  //*[@id="logisticskits_input_kitid"]/div[1]/div[1]/label/input  MA10
    #Click Search
    Click  id  logisticskits_btn_search
    #Get event id of upcoming_event='com.qurasense.communication.upcoming.AnalyzeReminderEvent'  seqnum=1
    ${eventid}=  Get Upcoming Event Value   ${APP_VERSION}  ${TEST_ENV}  com.qurasense.communication.upcoming.AnalyzeReminderEvent  1  id
    #Set event id of upcoming_event='com.qurasense.communication.upcoming.AnalyzeReminderEvent'  seqnum=1
    Set Upcoming Event  ${APP_VERSION}  ${TEST_ENV}  ${eventid}  1  com.qurasense.common.messaging.broadcast.event.KitConfirmedByCarrier  com.qurasense.communication.upcoming.AnalyzeReminderEvent  PT3M
    #Wait for some time for screen to come up
    Sleep  2
    #Click on Dots
    Click  id  logisticskits_menu_action
    #Click on Confirm by carrier
    Click  xpath  //span[contains(.,'Confirm by carrier')]
    #Click on Move to Delivered
    Click  id  confirmbycarrier_btn

    #${kitid}=  Get Kit ID  ${APP_VERSION}  ${TEST_ENV}  MA10   IN_USE
    Sleep  30
    # TC-1233;Check the Upcoming Event 'com.qurasense.communication.upcoming.PadStillUsingFirst' is state=UNPROCESSED for seqnum=1
    Check Upcoming Event Message  ${APP_VERSION}  ${TEST_ENV}  'eventType'  com.qurasense.communication.upcoming.AnalyzeReminderEvent  'key'  ${kitid}   1  'state'  UNPROCESSED
    Sleep    160
    #TC-1232; Check the message llog for event reminder to schedule kit is sent.
    Check Message Log Time After Event  ${APP_VERSION}  ${TEST_ENV}  _customermobapp@qvin.com  com.qurasense.communication.upcoming.AnalyzeReminderEvent    ${communication_api_messageLogs}   10    'channelType'   SLACK

    #Enter Kit name to search
    Enter Text  xpath  //*[@id="logisticskits_input_kitid"]/div[1]/div[1]/label/input  MA10
    #Click Search
    Click  id  logisticskits_btn_search
    #Wait for some time for screen to come up
    Sleep  2
    #Clcik on Assign Dots
    Click  id  logisticskits_menu_action
    #Click on Confirm by carrier
    Click  xpath  //span[contains(.,'Deliver to Lab')]
    #Click on Move to Delivered
    Click  id  delivertolab_btn
    #Get event id of upcoming_event='com.qurasense.communication.upcoming.AnalyzeReminderEvent'  seqnum=1
    ${eventid}=  Get Upcoming Event Value   ${APP_VERSION}  ${TEST_ENV}  com.qurasense.communication.upcoming.AnalyzeReminderEvent  1  id
    #Set event id of upcoming_event='com.qurasense.communication.upcoming.AnalyzeReminderEvent'  seqnum=1
    Set Upcoming Event  ${APP_VERSION}  ${TEST_ENV}  ${eventid}  1  com.qurasense.common.messaging.broadcast.event.KitConfirmedByCarrier  com.qurasense.communication.upcoming.AnalyzeReminderEvent  P2D

    #Register the Qpad for the mentioned customer
    Register Qpad  ${APP_VERSION}  ${TEST_ENV}  ${customermobappendpoint}  MA09PAD1  _customermobapp@qvin.com
    #API call to mark start collection process of a pad
    Pad Start Collection  ${APP_VERSION}  ${TEST_ENV}   ${customermobappendpoint}  MA09PAD1  _customermobapp@qvin.com  REGISTERED
    #Sleep  so that the next notofication to user can be verified
    Sleep  10
    #API call to mark end collection process of a pad
    Pad End Collection  ${APP_VERSION}  ${TEST_ENV}  ${customermobappendpoint}  MA09PAD1  _customermobapp@qvin.com  IN_USE
    #Sleep  so that the next notofication to user can be verified
    Sleep  30
    #API call to mark start collection process of a pad
    Pad Start Collection  ${APP_VERSION}  ${TEST_ENV}  ${customermobappendpoint}  MA09PAD2  _customermobapp@qvin.com  IN_USE
    #Sleep  so that the next notofication to user can be verified
    Sleep  10
    #API call to mark end collection process of a pad
    Pad End Collection  ${APP_VERSION}  ${TEST_ENV}  ${customermobappendpoint}  MA09PAD2  _customermobapp@qvin.com  IN_USE
    #Enter Kit name to search
    Enter Text  xpath  //*[@id="logisticskits_input_kitid"]/div[1]/div[1]/label/input  MA09
    #Click Search
    Click  id  logisticskits_btn_search
    #Wait for some time for screen to come up
    Sleep  2
    #Clcik on Assign Dots
    Click  id  logisticskits_menu_action
    #Click on Confirm by carrier
    Click  xpath  //span[contains(.,'Confirm by carrier')]
    #Click on Move to Delivered
    Click  id  confirmbycarrier_btn
    #Enter Kit name to search
    Enter Text  xpath  //*[@id="logisticskits_input_kitid"]/div[1]/div[1]/label/input  MA09
    #Click Search
    Click  id  logisticskits_btn_search
    #Wait for some time for screen to come up
    Sleep  2
    #Clcik on Assign Dots
    Click  id  logisticskits_menu_action
    #Click on Confirm by carrier
    Click  xpath  //span[contains(.,'Deliver to Lab')]
    #Click on Move to Delivered
    Click  id  delivertolab_btn
    #Wait for some time for screen to come up
    Sleep  1
    #Register the Qpad for the mentioned customer
    Register Qpad  ${APP_VERSION}  ${TEST_ENV}  ${customermobappendpoint}  MA08PAD1  _customermobapp@qvin.com
    #API call to mark start collection process of a pad
    Pad Start Collection  ${APP_VERSION}  ${TEST_ENV}  ${customermobappendpoint}  MA08PAD1  _customermobapp@qvin.com  REGISTERED
    #Sleep  so that the next notofication to user can be verified
    Sleep  10
    #API call to mark end collection process of a pad
    Pad End Collection  ${APP_VERSION}  ${TEST_ENV}  ${customermobappendpoint}  MA08PAD1  _customermobapp@qvin.com  IN_USE
    #Sleep  so that the next notofication to user can be verified
    Sleep  30
    #API call to mark start collection process of a pad
    Pad Start Collection  ${APP_VERSION}  ${TEST_ENV}  ${customermobappendpoint}  MA08PAD2  _customermobapp@qvin.com  IN_USE
    #Sleep  so that the next notofication to user can be verified
    Sleep  10
    #API call to mark end collection process of a pad
    Pad End Collection  ${APP_VERSION}  ${TEST_ENV}  ${customermobappendpoint}  MA08PAD2  _customermobapp@qvin.com  IN_USE
    #Enter Kit name to search
    Enter Text  xpath  //*[@id="logisticskits_input_kitid"]/div[1]/div[1]/label/input  MA08
    #Click Search
    Click  id  logisticskits_btn_search
    #Wait for some time for screen to come up
    Sleep  2
    #Clcik on Assign Dots
    Click  id  logisticskits_menu_action
    #Click on Confirm by carrier
    Click  xpath  //span[contains(.,'Confirm by carrier')]
    #Click on Move to Delivered
    Click  id  confirmbycarrier_btn
    #Enter Kit name to search
    Enter Text  xpath  //*[@id="logisticskits_input_kitid"]/div[1]/div[1]/label/input  MA08
    #Click Search
    Click  id  logisticskits_btn_search
    #Wait for some time for screen to come up
    Sleep  2
    #Clcik on Assign Dots
    Click  id  logisticskits_menu_action
    #Click on Confirm by carrier
    Click  xpath  //span[contains(.,'Deliver to Lab')]
    #Click on Move to Delivered
    Click  id  delivertolab_btn
    #Wait for some time for screen to come up
    Sleep  1
    #Register the Qpad for the mentioned customer
    Register Qpad  ${APP_VERSION}  ${TEST_ENV}  ${customermobappendpoint}  MA07PAD2  _customermobapp@qvin.com
    #API call to mark start collection process of a pad
    Pad Start Collection  ${APP_VERSION}  ${TEST_ENV}  ${customermobappendpoint}  MA07PAD2  _customermobapp@qvin.com  REGISTERED
    #Sleep  so that the next notofication to user can be verified
    Sleep  10
    #API call to mark end collection process of a pad
    Pad End Collection  ${APP_VERSION}  ${TEST_ENV}  ${customermobappendpoint}  MA07PAD2  _customermobapp@qvin.com  IN_USE
    #Sleep  so that the next notofication to user can be verified
    Sleep  30
    #API call to mark start collection process of a pad
    Pad Start Collection  ${APP_VERSION}  ${TEST_ENV}  ${customermobappendpoint}  MA07PAD1  _customermobapp@qvin.com  IN_USE
    #Sleep  so that the next notofication to user can be verified
    Sleep  10
    #API call to mark end collection process of a pad
    Pad End Collection  ${APP_VERSION}  ${TEST_ENV}  ${customermobappendpoint}  MA07PAD1  _customermobapp@qvin.com  IN_USE
    #Enter Kit name to search
    Enter Text  xpath  //*[@id="logisticskits_input_kitid"]/div[1]/div[1]/label/input  MA07
    #Click Search
    Click  id  logisticskits_btn_search
    #Wait for some time for screen to come up
    Sleep  2
    #Clcik on Assign Dots
    Click  id  logisticskits_menu_action
    #Click on Confirm by carrier
    Click  xpath  //span[contains(.,'Confirm by carrier')]
    #Click on Move to Delivered
    Click  id  confirmbycarrier_btn
    #Enter Kit name to search
    Enter Text  xpath  //*[@id="logisticskits_input_kitid"]/div[1]/div[1]/label/input  MA07
    #Click Search
    Click  id  logisticskits_btn_search
    #Wait for some time for screen to come up
    Sleep  2
    #Clcik on Assign Dots
    Click  id  logisticskits_menu_action
    #Click on Confirm by carrier
    Click  xpath  //span[contains(.,'Deliver to Lab')]
    #Click on Move to Delivered
    Click  id  delivertolab_btn
    #Wait for some time for screen to come up
    Sleep  1
    #Register the Qpad for the mentioned customer
    Register Qpad  ${APP_VERSION}  ${TEST_ENV}  ${customermobappendpoint}  MA06PAD2  _customermobapp@qvin.com
    #API call to mark start collection process of a pad
    Pad Start Collection  ${APP_VERSION}  ${TEST_ENV}  ${customermobappendpoint}  MA06PAD2  _customermobapp@qvin.com  REGISTERED
    #Sleep  so that the next notofication to user can be verified
    Sleep  10
    #API call to mark end collection process of a pad
    Pad End Collection  ${APP_VERSION}  ${TEST_ENV}  ${customermobappendpoint}  MA06PAD2  _customermobapp@qvin.com  IN_USE
    #Sleep  so that the next notofication to user can be verified
    Sleep  30
    #API call to mark start collection process of a pad
    Pad Start Collection  ${APP_VERSION}  ${TEST_ENV}  ${customermobappendpoint}  MA06PAD1  _customermobapp@qvin.com  IN_USE
    #Sleep  so that the next notofication to user can be verified
    Sleep  10
    #API call to mark end collection process of a pad
    Pad End Collection  ${APP_VERSION}  ${TEST_ENV}  ${customermobappendpoint}  MA06PAD1  _customermobapp@qvin.com  IN_USE
    #Enter Kit name to search
    Enter Text  xpath  //*[@id="logisticskits_input_kitid"]/div[1]/div[1]/label/input  MA06
    #Click Search
    Click  id  logisticskits_btn_search
    #Wait for some time for screen to come up
    Sleep  2
    #Clcik on Assign Dots
    Click  id  logisticskits_menu_action
    #Click on Confirm by carrier
    Click  xpath  //span[contains(.,'Confirm by carrier')]
    #Click on Move to Delivered
    Click  id  confirmbycarrier_btn
    #Enter Kit name to search
    Enter Text  xpath  //*[@id="logisticskits_input_kitid"]/div[1]/div[1]/label/input  MA06
    #Click Search
    Click  id  logisticskits_btn_search
    #Wait for some time for screen to come up
    Sleep  2
    #Clcik on Assign Dots
    Click  id  logisticskits_menu_action
    #Click on Confirm by carrier
    Click  xpath  //span[contains(.,'Deliver to Lab')]
    #Click on Move to Delivered
    Click  id  delivertolab_btn
    #Wait for some time for screen to come up
    Sleep  1
    #Close the Browser being used for test.
    Close Browser

ROBOT_LOG_03

    #Getting kit ready for TC-490#
    #Generate  token for customer
    ${customermobappendpoint}=  Create Customer Authentication Endpoint  _customermobapp@qvin.com  secret  123  EMAIL
    #Open Browser and navigate to the desired URL
    Navigate To And Verify  ${BROWSER}  ${TEST_ENV}/#/site/login  Qvin
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
    #Click on Dashboard link
    Click  xpath  //*[@id="logistics_listitem_dashboard"]
    #Click on Kits link
#    Click  xpath  //*[@id="logistics_listitem_kits"]
    #Click on Dashboard link
    Click  xpath  //*[@id="logisticsdashboard_btn_kitdeliveredatlab"]
    #Enter Kit name to search
    Enter Text  xpath  //*[@id="logisticskits_input_kitid"]/div[1]/div[1]/label/input  KT03
    #Click Search
    Click  id  logisticskits_btn_search
    #Wait for some time for screen to come up
    Sleep  2
    #Click on Dots
    Click  id  logisticskits_menu_action
    #Click on Expire Kits
    Click  xpath  //span[contains(.,'Expire kit')]
    #Wait for some time for screen to come up
    Sleep  2
    #Click on YES button
    Click  xpath  //*[@id="logistics_common_btn_yesno"]/material-button[1]/material-ripple
    #Wait for some time for screen to come up
    Sleep  2
    Click  id  logistics_listitem_kits
    Sleep  2
    #Click on Kits menu
    Click  xpath  //*[@id="logistics_listitem_kittotalkits"]
    #Enter Kit name to search
    Enter Text  xpath  //*[@id="logisticskits_input_kitid"]/div[1]/div[1]/label/input  KT03
    #Click Search
    Click  id  logisticskits_btn_search
    #Wait for some time for screen to come up
    Sleep  2
    #Click on kit-id, from completed list
    Wait Until Keyword Succeeds  5x  200ms  Click  link  KT03
    #Verifying the text 'Expired' will be commented till the time a way is found to do so, after change of Kit detail screen
    #Verify Text In Locator  xpath  /html/body/app/logistic/div/div/kit-detail/div[2]/card[1]/div[2]/kit-main-details/table/tr[4]/td[2]/a  Expired
    #Wait for some time for screen to come up
    Sleep  1
    #Close the Browser being used for test.
    Close Browser

ROBOT_LOG_04

    #Generate  token for customer
    ${customermobappendpoint}=  Create Customer Authentication Endpoint  _customermobapp@qvin.com  secret  123  EMAIL
    #Open Browser and navigate to the desired URL
    Navigate To And Verify  ${BROWSER}  ${TEST_ENV}/#/site/login  Qvin
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
    #Click on Dashboard link
    Click  xpath  //*[@id="logistics_listitem_dashboard"]
    #Click on Kits link
#    Click  xpath  //*[@id="logistics_listitem_kits"]
    #Click on Dashboard link
    Click  xpath  //*[@id="logisticsdashboard_btn_kitdeliveredatlab"]
    #Enter Kit name to search
    Enter Text  xpath  //*[@id="logisticskits_input_kitid"]/div[1]/div[1]/label/input  MA02
    #Click Search
    Click  id  logisticskits_btn_search
    #Wait for some time for screen to come up
    Sleep  2
    #Click on human-id
    Click Anchor Cell In Table  xpath  //*[@id="logisticskits_smart_table"]/div/div/table  NotApplicable  2  MA02
    Click  id  buttonCreateorder
    #Click on Select product in Orders
    Click  xpath  //span[contains(.,'Select product type')]
    #Click on Diabetes minimum
    Click  xpath  //material-select-item[contains(.,'Diabetes minimum')]
    #Enter number of Kits 2
    Enter Text  xpath  //*[@id="widgetkitreq_input_noofkits"]/div[1]/div[1]/label/input  2
    #Click on Add order line
    Click  xpath  //*[@id="widgetkitreq_btn_requestkit"]
    #Click on Select product in Orders
    Click  xpath  //span[contains(.,'Select product type')]
    #Click on Heart Health
    Click  xpath  //material-select-item[contains(.,'Heart Health')]
    #Enter number of Kits 1
    Enter Text  xpath  (//material-input[@id='widgetkitreq_input_noofkits']/div/div/label/input)[2]  1
    #Click address dropdown and select address
    Click  id  dropdown_address
    Click  Xpath  //material-select-item[contains(.,'255 Warren Street, Jersey City, NJ, 17302')]
    #Click pament Dropdown and select payment mode
    Click  Id  dropdown_payment_method
    Click  Xpath  //material-select-item[contains(.,'Qvin')]
    #Wait for some time for screen to come up
    Sleep  1

    #Click Ok Button
    Click  id  widgetkitreq_btn_okinput

    #Click Yes button
    Click  xpath  //*[@id="logistics_common_btn_yesno"]/material-button[1]/material-ripple

    Sleep  5

    #Close the Browser being used for test.
    Close Browser

ROBOT_LOG_05

    #Generate  token for customer
    ${customermobappendpoint}=  Create Customer Authentication Endpoint  _customermobapp@qvin.com  secret  123  EMAIL
    #Open Browser and navigate to the desired URL
    Navigate To And Verify  ${BROWSER}  ${TEST_ENV}/#/site/login  Qvin
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
    #Click on Dashboard link
    Click  xpath  //*[@id="logistics_listitem_dashboard"]
    #Click on Kits link
#    Click  xpath  //*[@id="logistics_listitem_kits"]
    #Click on Fullfilled orders button
    Click  xpath  //*[@id="logisticsdashboard_btn_fulfilledorders"]
    #Enter Kit name to search
    Enter Text  xpath  //*[@id="logisticsorders_input_kitid"]/div[1]/div[1]/label/input  TA01
    #Click Search
    Click  id  logisticsorders_btn_search
    #Wait for some time for screen to come up
    Sleep  10
    #Get order id for kit
    ${orderedid}=  Get Text  //*[@id="fulfilledorders_smart_table"]/div/div/table/tbody/tr/td[2]/a
    #Click Actionx`
    Click  id  fulfilledorders_menu_action
    #Click Unassign kit
    Click  xpath  //span[contains(.,'Unassign kit')]
    #Click Yes
    Click  xpath  //*[@id="logistics_common_btn_yesno"]/material-button[1]
    #Click on Dashboard link
    Click  xpath  //*[@id="logistics_listitem_dashboard"]
    #Click on Ordered orders button
    Click  xpath  //*[@id="logisticsdashboard_btn_orderedorders"]
    #Click Orderid button
    Wait Until Keyword Succeeds  5x  200ms  Click  link  ${orderedid}
    #Wait for some time for screen to come up
    Sleep  2
    #Verifying the text 'Ordered' will be commented till the time a way is found to do so, after change of Order detail screen
    #Verify Text In Locator   xpath  /html/body/app/logistic/div/div/order-detail/div[2]/card/div[2]/table/tr[3]/td[2]/a  Ordered
    #Click on Dashboard link
    Click  xpath  //*[@id="logistics_listitem_dashboard"]
    #Click on Fullfilled orders button
    Click  xpath  //*[@id="logisticsdashboard_btn_fulfilledorders"]
    #Enter Kit name to search
    Enter Text  xpath  //*[@id="logisticsorders_input_kitid"]/div[1]/div[1]/label/input  TA03
    #Click Search
    Click  id  logisticsorders_btn_search
    #Wait for some time for screen to come up
    Sleep  6
    #Get order id for kit
    ${orderedid}=  Get Text   //*[@id="fulfilledorders_smart_table"]/div/div/table/tbody/tr/td[2]/a
    #Click Action
    Click  id  fulfilledorders_menu_action
    #Click Cancel Order
    Click  xpath  //span[contains(.,'Cancel order')]
    #Click Yes
    Click  xpath  //*[@id="logistics_common_btn_yesno"]/material-button[1]
    #Click on Dashboard link
    Click  xpath  //*[@id="logistics_listitem_dashboard"]
    #Click on Cancelled kits
    Click  xpath  //*[@id="logisticsdashboard_btn_cancelledorders"]
    #Wait for some time for screen to come up
    Sleep  3
    #Verify the text
    Verify  ${orderedid}
    #Close the Browser being used for test.
    Close Browser

ROBOT_LOG_06

    #Generate  token for customer
    ${customermobappendpoint}=  Create Customer Authentication Endpoint  _customermobapp@qvin.com  secret  123  EMAIL
    #Open Browser and navigate to the desired URL
    Navigate To And Verify  ${BROWSER}  ${TEST_ENV}/#/site/login  Qvin
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
    #Click on Dashboard link
    Click  xpath  //*[@id="logistics_listitem_dashboard"]
    #Click on Kits link
#    Click  xpath  //*[@id="logistics_listitem_kits"]
    #Click on Reserved orders button
    Click  xpath  //*[@id="logisticsdashboard_btn_kitsreserved"]
    #Enter Kit name to search
    Enter Text  xpath  //*[@id="logisticskits_input_kitid"]/div[1]/div[1]/label/input  TA04
    #Click Search
    Click  id  logisticskits_btn_search
    #Wait for some time for screen to come up
    Sleep  3
    #Click Action
    Click  id  logisticskits_menu_action
    #Click Release order
    Click  xpath  //span[contains(.,'Release from order')]
    #Click Cancel
    Click  xpath  //span[contains(.,'Cancel')]
    #Click Unassign
    Click  xpath  //material-select-item[contains(.,'Unassign')]
    #Click Release
    Click  id  logisticsactions_btn_unassignrelease
    #Click on Dashboard link
    Click  xpath  //*[@id="logistics_listitem_dashboard"]
#    #Click on Instock button
#    Click  xpath  //*[@id="logistics_listitem_kitinstock"]
#    #Enter Kit name to search
#    Enter Text  xpath  //*[@id="logisticskits_input_kitid"]/div[1]/div[1]/label/input  TA04
#    #Click Search
#    Click  id  logisticskits_btn_search
#    #Click the link for kit
#    Wait Until Keyword Succeeds  5x  200ms  Click  link  TA04
#    #Wait for some time for screen to come up
#    Sleep  2
#    #Verify the text
#    Verify Text In Locator   xpath  /html/body/app/logistic/div/div/kit-detail/div[2]/card[1]/div[2]/kit-main-details/table/tr[4]/td[2]/a  In stock
#    #Click on Dashboard link
#    Click  xpath  //*[@id="logistics_listitem_dashboard"]
    #Click on Reserved orders button
    Click  xpath  //*[@id="logisticsdashboard_btn_kitsreserved"]
    #Enter Kit name to search
    Enter Text  xpath  //*[@id="logisticskits_input_kitid"]/div[1]/div[1]/label/input  TA05
    #Click Search
    Click  id  logisticskits_btn_search
    #Wait for some time for screen to come up
    Sleep  3
    #Click Action
    Click  id  logisticskits_menu_action
    #Click Release order
    Click  xpath  //span[contains(.,'Release from order')]
    #Click Release
    Click  id  logisticsactions_btn_unassignrelease
    #Click on Dashboard link
    Click  xpath  //*[@id="logistics_listitem_dashboard"]
    ###### To insert code for checking the IN_STOCK kits TA04, TA05, TA06 thru API call and remove the code for checking instock kits thru UI #######
#    #Click on Dashboard link
#    Click  xpath  //*[@id="logistics_listitem_kitinstock"]
#    #Enter Kit name to search
#    Enter Text  xpath  //*[@id="logisticskits_input_kitid"]/div[1]/div[1]/label/input  T997-0
#    #Click Search
#    Click  id  logisticskits_btn_search
#    #Click Orderid button
#    Wait Until Keyword Succeeds  5x  200ms  Click  link  T997-0
#    #Wait for some time for screen to come up
#    Sleep  2
#    #Verify the text
#    Verify Text In Locator   xpath  /html/body/app/logistic/div/div/kit-detail/div[2]/card[1]/div[2]/kit-main-details/table/tr[4]/td[2]/a  In stock
    #Close the Browser being used for test.
    Close Browser

ROBOT_LOG_07
    #Generate  token for admin user
    Create Admin Authentication Endpoint  _admin@qvin.com  secret  123  EMAIL
    #Generate  token for logistics user
    Create Logistics Authentication Endpoint  _logistics@qvin.com  secret  123  EMAIL
    #Generate  token for doctor
    Create Doctor Authentication Endpoint  _doctor@qvin.com  secret  123  EMAIL
    #Generate  token for customer
    ${customermobappendpoint}=  Create Customer Authentication Endpoint  _customermobapp@qvin.com  secret  123  EMAIL
    #Open Browser and navigate to the desired URL
    Navigate To And Verify  ${BROWSER}  ${TEST_ENV}/#/site/login  Qvin
    #Click username
    Click  css  input[type='text']
    #Enter username
    Enter Text  css  input[type='text']  _logistics@qvin.com
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
    #Click on Dashboard link
    Click  xpath  //*[@id="logistics_listitem_dashboard"]
    #Wait for some time for screen to come up
    Sleep  2
    #Kits ready for TC-1566
    #Click on Reserved button
    Click  xpath  //*[@id="logisticsdashboard_btn_kitsreserved"]
    #Enter Kit name to search
    Enter Text  xpath  //*[@id="logisticskits_input_kitid"]/div[1]/div[1]/label/input  ES04
    #Click Search
    Click  id  logisticskits_btn_search
    #Wait for some time for screen to come up
    Sleep  2
    #Click on Dots
    Click  id  logisticskits_menu_action
    #Wait for some time for screen to come up
    Sleep  2
    #Click on Confirm by carrier
    Click  xpath  //span[contains(.,'Confirm by carrier(test: fail analysis request)')]
    #Wait for some time for screen to come up
    Sleep  2
    #Click on Confirm By Carrier button
    Click  xpath  //*[@id="confirmbycarrier_btn"]
    #Sleep so that page could loaded
    Sleep  3
    #Click on dashboard on left menu
    Click  xpath  //*[@id="logistics_listitem_dashboard"]
    Sleep  3
    #Click on Confirm by carrier button on dashboard
    Click   id  logisticsdashboard_btn_kitsconfirmedbycarrier
    Sleep  2
    #Input kit id in input bar and click search
    Enter Text  xpath  //*[@id="logisticskits_input_kitid"]/div[1]/div[1]/label/input  ES04
    #Click search
    Click  id  logisticskits_btn_search
    #Verify kit on confirm by carrier screen
    Verify  ES04
    #Click kit id to check status
    Wait Until Keyword Succeeds  5x  200ms  Click  link  ES04
    Sleep  3
    #Verify kit status
    Verify Text In Locator  Xpath  /html/body/app/logistic/div/div/kit-detail/div[2]/card[2]/div[2]/order-details/table/tr[5]/td[2]    Shipped
    Sleep  5

    #Register the Qpad for the mentioned customer
    Register Qpad  ${APP_VERSION}  ${TEST_ENV}  ${customermobappendpoint}  ES05PAD2  _customermobapp@qvin.com
    #API call to mark start collection process of a pad
    Pad Start Collection  ${APP_VERSION}  ${TEST_ENV}  ${customermobappendpoint}  ES05PAD2  _customermobapp@qvin.com  REGISTERED
    #Sleep  so that the next notofication to user can be verified
    Sleep  10
    #API call to mark end collection process of a pad
    Pad End Collection  ${APP_VERSION}  ${TEST_ENV}  ${customermobappendpoint}  ES05PAD2  _customermobapp@qvin.com  IN_USE
    #Sleep  so that the next notofication to user can be verified
    Sleep  30
    #API call to mark start collection process of a pad
    Pad Start Collection   ${APP_VERSION}  ${TEST_ENV}  ${customermobappendpoint}  ES05PAD1  _customermobapp@qvin.com  IN_USE
    #Sleep  so that the next notofication to user can be verified
    Sleep  10
    #API call to mark end collection process of a pad
    Pad End Collection  ${APP_VERSION}  ${TEST_ENV}  ${customermobappendpoint}  ES05PAD1  _customermobapp@qvin.com  IN_USE
    #Sleep  so that the next notofication to user can be verified
    Sleep  30
    #Click on Dashboard link
    Click  xpath  //*[@id="logistics_listitem_dashboard"]
    #Wait for some time for screen to come up
    Sleep  2
    #Click on Kits button
#    Click  xpath  //*[@id="logistics_listitem_kits"]
    #Sleep so that page could loaded
    Sleep  3
    #clicking total kits
    Click  xpath  //*[@id="logisticsdashboard_btn_kitstotal"]
    #Enter Kit name to search
    Enter Text  xpath  //*[@id="logisticskits_input_kitid"]/div[1]/div[1]/label/input  ES05
    #Click Search
    Click  id  logisticskits_btn_search
    #Wait for some time for screen to come up
    Sleep  2
    #Click on Dots
    Click  id  logisticskits_menu_action
    #Click on Confirm by carrier
    Click  xpath  //span[contains(.,'Confirm by carrier')]
    #Click on Move to Delivered
    Click  id  confirmbycarrier_btn
    Sleep  3
    #close the browser on success
    Close Browser

Robot_LOG_08
    # Getting Kits ready for TC-108; TC-111; TC-397; TC-112; TC-114; TC-171; TC-173; TC-183
    #Generate  token for admin user
    Create Admin Authentication Endpoint  _admin@qvin.com  secret  123  EMAIL
    #Generate  token for logistics user
    Create Logistics Authentication Endpoint  _logistics@qvin.com  secret  123  EMAIL
    #Generate  token for doctor
    Create Doctor Authentication Endpoint  _doctor@qvin.com  secret  123  EMAIL
    #Generate  token for customer
    ${customermobappendpoint}=  Create Customer Authentication Endpoint  _customermobapp@qvin.com  secret  123  EMAIL
    #Open Browser and navigate to the desired URL
    Navigate To And Verify  ${BROWSER}  ${TEST_ENV}/#/site/login  Qvin
    #Click username
    Click  css  input[type='text']
    #Enter username
    Enter Text  css  input[type='text']  _logistics@qvin.com
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
    #Click on Dashboard link
    Click  xpath  //*[@id="logistics_listitem_dashboard"]
    #Wait for some time for screen to come up
    Sleep  2
    #Click on Kits link
#    Click  xpath  //*[@id="logistics_listitem_kits"]
    #Wait for some time for screen to come up
    Sleep  2
    #Register the Qpad for the mentioned customer
    Register Qpad  ${APP_VERSION}  ${TEST_ENV}  ${customermobappendpoint}  ES11PAD2  _customermobapp@qvin.com
    #API call to mark start collection process of a pad
    Pad Start Collection  ${APP_VERSION}  ${TEST_ENV}  ${customermobappendpoint}  ES11PAD2  _customermobapp@qvin.com  REGISTERED
    #Sleep  so that the next notofication to user can be verified
    Sleep  10
    #API call to mark end collection process of a pad
    Pad End Collection  ${APP_VERSION}  ${TEST_ENV}  ${customermobappendpoint}  ES11PAD2  _customermobapp@qvin.com  IN_USE
    #Sleep  so that the next notofication to user can be verified
    Sleep  30
    #API call to mark start collection process of a pad
    Pad Start Collection   ${APP_VERSION}  ${TEST_ENV}  ${customermobappendpoint}  ES11PAD1  _customermobapp@qvin.com  IN_USE
    #Sleep  so that the next notofication to user can be verified
    Sleep  10
    #API call to mark end collection process of a pad
    Pad End Collection  ${APP_VERSION}  ${TEST_ENV}  ${customermobappendpoint}  ES11PAD1  _customermobapp@qvin.com  IN_USE
    #Sleep  so that the next notofication to user can be verified
    Sleep  30
    #Click on Dashboard link
    Click  xpath  //*[@id="logistics_listitem_dashboard"]
    #Wait for some time for screen to come up
    Sleep  2
    #Click on Kits button
#    Click  xpath  //*[@id="logistics_listitem_kits"]
    #Sleep so that page could loaded
    Sleep  3
    #clicking total kits
    Click  xpath  //*[@id="logisticsdashboard_btn_kitstotal"]
    #Enter Kit name to search
    Enter Text  xpath  //*[@id="logisticskits_input_kitid"]/div[1]/div[1]/label/input  ES11
    #Click Search
    Click  id  logisticskits_btn_search
    #Wait for some time for screen to come up
    Sleep  2
    #Click on Dots
    Click  id  logisticskits_menu_action
    #Click on Confirm by carrier
    Click  xpath  //span[contains(.,'Confirm by carrier')]
    #Click on Move to Delivered
    Click  id  confirmbycarrier_btn
    #Click on Dashboard link
    Click  xpath  //*[@id="logistics_listitem_dashboard"]
    #Wait for some time for screen to come up
    Sleep  30
    #Register the Qpad for the mentioned customer
    Register Qpad  ${APP_VERSION}  ${TEST_ENV}  ${customermobappendpoint}  ES12PAD2  _customermobapp@qvin.com
    #API call to mark start collection process of a pad
    Pad Start Collection  ${APP_VERSION}  ${TEST_ENV}  ${customermobappendpoint}  ES12PAD2  _customermobapp@qvin.com  REGISTERED
    #Sleep  so that the next notofication to user can be verified
    Sleep  10
    #API call to mark end collection process of a pad
    Pad End Collection  ${APP_VERSION}  ${TEST_ENV}  ${customermobappendpoint}  ES12PAD2  _customermobapp@qvin.com  IN_USE
    #Sleep  so that the next notofication to user can be verified
    Sleep  30
    #API call to mark start collection process of a pad
    Pad Start Collection   ${APP_VERSION}  ${TEST_ENV}  ${customermobappendpoint}  ES12PAD1  _customermobapp@qvin.com  IN_USE
    #Sleep  so that the next notofication to user can be verified
    Sleep  10
    #API call to mark end collection process of a pad
    Pad End Collection  ${APP_VERSION}  ${TEST_ENV}  ${customermobappendpoint}  ES12PAD1  _customermobapp@qvin.com  IN_USE
    #Sleep  so that the next notofication to user can be verified
    Sleep  30
    #Click on Dashboard link
    Click  xpath  //*[@id="logistics_listitem_dashboard"]
    #Wait for some time for screen to come up
    Sleep  2
    #Click on Kits button
#    Click  xpath  //*[@id="logistics_listitem_kits"]
    #Sleep so that page could loaded
#    Sleep  3
    #clicking total kits
    Click  xpath  //*[@id="logisticsdashboard_btn_kitstotal"]
    #Enter Kit name to search
    Enter Text  xpath  //*[@id="logisticskits_input_kitid"]/div[1]/div[1]/label/input  ES12
    #Click Search
    Click  id  logisticskits_btn_search
    #Wait for some time for screen to come up
    Sleep  2
    #Click on Dots
    Click  id  logisticskits_menu_action
    #Click on Confirm by carrier
    Click  xpath  //span[contains(.,'Confirm by carrier')]
    #Click on Move to Delivered
    Click  id  confirmbycarrier_btn
    #close the browser on success
    Close Browser


ROBOT_LOG_09

    ### Kit to be used for Matrix TC-484; TC-121; TC-115; TC-117; TC-119; TC-120; TC-122; TC-479 ###
    #Generate  token for admin user
    Create Admin Authentication Endpoint  _admin@qvin.com  secret  123  EMAIL
    #Generate  token for logistics user
    Create Logistics Authentication Endpoint  _logistics@qvin.com  secret  123  EMAIL
    #Generate  token for customer
    Create Doctor Authentication Endpoint   _doctor@qvin.com  secret  123  EMAIL
    #Generate  token for customer
    ${customermobappendpoint}=  Create Customer Authentication Endpoint  _customermobapp@qvin.com  secret  123  EMAIL
    #Generate  token for envswitch customer
    ${customerenvswitchendpoint}=  Create Customer Authentication Endpoint  _envswitch@qvin.com  secret  123  EMAIL
    #Get legal id of customermobapp
    ${legalid}=  get legal id   ${APP_VERSION}  ${TEST_ENV}   _customermobapp@qvin.com
    #Getting group id of San Diego comparative trial
    ${groupid}=  Get Group Id  ${APP_VERSION}  ${TEST_ENV}  San Diego comparative trial
    #Getting participant id of customer mob app
    ${participantid}=  Get Group Participant Id  ${APP_VERSION}  ${TEST_ENV}  ${groupid}    ${legalid}
    #Getting Group participant Approval Status
    ${participantstatus}=  Get Group Participant Status  ${APP_VERSION}  ${TEST_ENV}  ${groupid}    ${legalid}
    #Approving customer mob app as group member if not APPROVED
    Run keyword if  '${participantstatus}' != 'APPROVED'   Approve User    ${APP_VERSION}  ${TEST_ENV}  ${participantid}
    #Open Browser and navigate to the desired URL
    Navigate To And Verify  ${BROWSER}  ${TEST_ENV}/#/site/login  Qvin
    #Click username
    Click  css  input[type='text']
    #Enter username
    Enter Text  css  input[type='text']  _logistics@qvin.com
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
    #Click on Dashboard link
    Click  xpath  //*[@id="logistics_listitem_dashboard"]
    #API call to register QPad
    Register Qpad  ${APP_VERSION}  ${TEST_ENV}  ${customermobappendpoint}  KT17PAD1  _customermobapp@qvin.com
    #API call to mark start collection process of a pad
    Pad Start Collection  ${APP_VERSION}  ${TEST_ENV}  ${customermobappendpoint}  KT17PAD1  _customermobapp@qvin.com  REGISTERED
    #Sleep  so that the next notofication to user can be verified
    Sleep  10
    #API call to mark end collection process of a pad
    Pad End Collection  ${APP_VERSION}  ${TEST_ENV}  ${customermobappendpoint}  KT17PAD1  _customermobapp@qvin.com  IN_USE
    #Sleep  so that the next notofication to user can be verified
    Sleep  30
    #API call to mark start collection process of a pad
    Pad Start Collection  ${APP_VERSION}  ${TEST_ENV}  ${customermobappendpoint}  KT17PAD2  _customermobapp@qvin.com  IN_USE
    #Sleep  so that the next notofication to user can be verified
    Sleep  10
    #API call to mark end collection process of a pad
    Pad End Collection  ${APP_VERSION}  ${TEST_ENV}  ${customermobappendpoint}  KT17PAD2  _customermobapp@qvin.com  IN_USE
    #Sleep  so that the next notofication to user can be verified
    Sleep  30
    #API Call to Ship Kit
    Ship Kit  ${APP_VERSION}  ${TEST_ENV}  ${customermobappendpoint}  KT17
    #Click on Kits link
    Click  xpath  //*[@id="logistics_listitem_kits"]
    #Click on Kits button
    Click  xpath  //*[@id="logistics_listitem_kittotalkits"]
    #Enter Kit name to search
    Enter Text  xpath  //*[@id="logisticskits_input_kitid"]/div[1]/div[1]/label/input  KT17
    #Click Search
    Click  id  logisticskits_btn_search
    #Wait for some time for screen to come up
    Sleep  2
    #Click on Dots
    Click  id  logisticskits_menu_action
    #Click on Confirm by carrier
    Click  xpath  //span[contains(.,'Confirm by carrier')]
    #Click on Move to Delivered
    Click  id  confirmbycarrier_btn
    #Wait for some time for screen to come up
    Sleep  2
    #Click on Dashboard link
    Click  xpath  //*[@id="logistics_listitem_dashboard"]
    Sleep  2
    #Click on Reserved button
    Click  xpath  //*[@id="logisticsdashboard_btn_kitsreserved"]
    #Enter Kit name to search
    Enter Text  xpath  //*[@id="logisticskits_input_kitid"]/div[1]/div[1]/label/input  ES08
    #Click Search
    Click  id  logisticskits_btn_search
    #Wait for some time for screen to come up
    Sleep  2
    #Click on Dots
    Click  id  logisticskits_menu_action
    #Wait for some time for screen to come up
    Sleep  2
    #Click on Confirm by carrier
    Click  xpath  //span[contains(.,'Confirm by carrier(test: fail analysis request)')]
    #Wait for some time for screen to come up
    Sleep  2
    #Click on Confirm By Carrier button
    Click  xpath  //*[@id="confirmbycarrier_btn"]
    #Sleep so that page could loaded
    Sleep  10
    #click on lab dashboard
    Click  xpath  //*[@id="logistics_listitem_dashboard"]
    #click confirmder by carrier button
    Click  xpath  //*[@id="logisticsdashboard_btn_kitsconfirmedbycarrier"]
    #enter text in input bar
    Enter Text  xpath  //*[@id="logisticskits_input_kitid"]/div[1]/div[1]/label/input  ES08
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
    #click on deliver to lab
    Click  xpath  //span[contains(.,'Deliver to Lab')]
    #Wait for some time for screen to come up
    Sleep  2
    #click on Deliver to lab button
    Click  id  delivertolab_btn
    #Wait for some time for screen to come up
    Sleep  2
    #click on lab dashboard
    Click  xpath  //*[@id="logistics_listitem_dashboard"]
    #click Deliver at Lab button
    Click  xpath  //*[@id="logisticsdashboard_btn_kitdeliveredatlab"]
    #search for the Kid Id
    Enter Text  xpath  //*[@id="logisticskits_input_kitid"]/div[1]/div[1]/label/input   ES08
    Sleep  2

    Send Keys  None  RETURN
    Sleep  2
    #Click on 3 dots and  Add use time button under kit detail screen.
    Click   id   logisticskits_menu_action
#    Wait for some time
    Sleep  3
    Wait Until Keyword Succeeds  5x  200ms  Click   xpath  //span[contains(.,'Add use times')]
#    Wait Until Keyword Succeeds  5x  200ms  Click  link  ES08
    Sleep  3
#    #Click on Add use time button under kit detail screen.
#    Click   id   showAddUseTimeButton
    #Wait for some time for screen to come up
    Sleep  2
    #Uncheck the checkbox to remove the second pad
    Click  xpath  //tr[3]/td[2]/*[@id="logistics_padusedcheckbox"]/div[1]/material-ripple
    #Wait for some time for screen to come up
    Sleep  2
    #Get the current date
    ${date}=  Get Current Date  exclude_millis=TRUE
    #Wait for some time for screen to come up
    Sleep  2
    #Get the time element from the current date extracted
    ${time}=  Get Time From Date  ${date}
    #Click on the drop down for Use Time
    Click  xpath  //tr[1]/td[2]/div/material-date-time-picker/material-time-picker/material-dropdown-select/dropdown-button/div/glyph/i
    #Wait for some time for screen to come up
    Sleep  2
    #Click on the input field for Use Time
    Click  xpath   /html/body/div/div[8]/div/div/div[2]/header/div/div/div/material-input/div/div[1]/label/input
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
    Click  xpath  //tr[2]/td[4]/material-date-time-picker/material-time-picker/material-dropdown-select/dropdown-button/div/glyph/i
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
    Click  xpath  //tr[2]/td[6]/material-date-time-picker/material-time-picker/material-dropdown-select/dropdown-button/div/glyph/i
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
    #Take screenshot of the screen
    Capture Page Screenshot
    #Click on MoveToUsed button
    Click  xpath  //*[@id="logisticsactions_btn_movetoused"]
    #Click on YES button
    Click  xpath  //*[@id="logistics_common_btn_yesno"]/material-button[1]/material-ripple

    sleep  2
    ### Kit to be used for Matrix TC-483###
    #click on lab dashboard
    Click  xpath  //*[@id="logistics_listitem_dashboard"]
    #Wait for some time for screen to come up
    Sleep  2

    #Prepare kit for TC-1576
    #register kit for user
    Register QPad  ${APP_VERSION}  ${TEST_ENV}  ${customermobappendpoint}  ES07PAD1  _customermobapp@qvin.com
    #Wait for some time for screen to come up
    Sleep  2
    #click on registered kit
    Click  xpath  //*[@id="logisticsdashboard_btn_kitregistered"]
    #Wait for some time for screen to come up
    Sleep  2
    #enter text in input bar
    Enter text  xpath  //*[@id="logisticskits_input_kitid"]/div[1]/div[1]/label/input   ES07
    #click on search button
    Click  id  logisticskits_btn_search
    #Wait for some time for screen to come up
    Sleep  2
    #click on dots
    Click  id  logisticskits_menu_action
    #Wait for some time for screen to come up
    Sleep  2
    #click on confirm by carrier
    Click  xpath  //span[contains(.,'Confirm by carrier(test: fail analysis request)')]
    #Wait for some time for screen to come up
    Sleep  2
    #Click on Confirm By Carrier button
    Click  xpath  //*[@id="confirmbycarrier_btn"]
    #Sleep so that page could loaded
    Sleep  10
    Click  xpath  //*[@id="logistics_listitem_dashboard"]
    Sleep  2
    Click  id   logisticsdashboard_btn_kitsconfirmedbycarrier
    Sleep  2
    #serach for the kit and click kit link to open kit details
    Enter text  xpath  //*[@id="logisticskits_input_kitid"]/div[1]/div[1]/label/input  ES07
    Send Keys  None  RETURN
    Sleep  2
    #Click on 3 dots and  Add use time button under kit detail screen.
    Click   id   logisticskits_menu_action
    #Wait for some time for screen to come up
    Sleep  3
    Wait Until Keyword Succeeds  5x  200ms  Click   xpath  //span[contains(.,'Add use times')]
#    Wait Until Keyword Succeeds  5x  200ms  Click  link  ES07
#    #wait for screen to show up.
    Sleep  3
#    #Click on Add use time button under kit detail screen.
#    Click   id   showAddUseTimeButton
    #Wait for some time for screen to come up
    Sleep  2
    #Uncheck the checkbox to remove the second pad
    Click  xpath  //tr[3]/td[2]/*[@id="logistics_padusedcheckbox"]/div[1]/material-ripple
    #Wait for some time for screen to come up
    Sleep  2
    #Get the current date
    ${date}=  Get Current Date  exclude_millis=TRUE
    #Wait for some time for screen to come up
    Sleep  2
    #Get the time element from the current date extracted
    ${time}=  Get Time From Date  ${date}
    #Click on the drop down for Use Time
    Click  xpath  //tr[1]/td[2]/div/material-date-time-picker/material-time-picker/material-dropdown-select/dropdown-button/div/glyph/i
    #Wait for some time for screen to come up
    Sleep  2
    #Click on the input field for Use Time
    Click  xpath   /html/body/div/div[8]/div/div/div[2]/header/div/div/div/material-input/div/div[1]/label/input
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
    Click  xpath  //tr[2]/td[4]/material-date-time-picker/material-time-picker/material-dropdown-select/dropdown-button/div/glyph/i
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
    Click  xpath  //tr[2]/td[6]/material-date-time-picker/material-time-picker/material-dropdown-select/dropdown-button/div/glyph/i
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
    #Take screenshot of the screen
    Capture Page Screenshot
    #Click on MoveToUsed button
    Click  xpath  //*[@id="logisticsactions_btn_movetoused"]
    #Click on YES button
    Click  xpath  //*[@id="logistics_common_btn_yesno"]/material-button[1]/material-ripple


    ### Kit to be used for Matrix TC-1577###
    #click on lab dashboard
    Click  xpath  //*[@id="logistics_listitem_dashboard"]
    #Wait for some time for screen to come up
    Sleep  2
    #register kit for user
    Register QPad  ${APP_VERSION}  ${TEST_ENV}  ${customermobappendpoint}  ES09PAD1  _customermobapp@qvin.com
    #Wait for some time for screen to come up
    Sleep  2
    #click on registered kit
    Click  xpath  //*[@id="logisticsdashboard_btn_kitregistered"]
    #Wait for some time for screen to come up
    Sleep  2
    #enter text in input bar
    Enter text  xpath  //*[@id="logisticskits_input_kitid"]/div[1]/div[1]/label/input   ES09
    #click on search button
    Click  id  logisticskits_btn_search
    #Wait for some time for screen to come up
    Sleep  2
    #click on dots
    Click  id  logisticskits_menu_action
    #Wait for some time for screen to come up
    Sleep  2
    #click on confirm by carrier
    Click  xpath  //span[contains(.,'Confirm by carrier(test: fail analysis request)')]
    #Wait for some time for screen to come up
    Sleep  2
    #Click on Confirm By Carrier button
    Click  xpath  //*[@id="confirmbycarrier_btn"]
    #Sleep so that page could loaded
    Sleep  10
    #click on lab dashboard
    Click  xpath  //*[@id="logistics_listitem_dashboard"]
    #Wait for some time for screen to come up
    Sleep  2
    #click confirmder by carrier button
    Click  xpath  //*[@id="logisticsdashboard_btn_kitsconfirmedbycarrier"]
    #enter text in input bar
    Enter Text  xpath  //*[@id="logisticskits_input_kitid"]/div[1]/div[1]/label/input  ES09
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
    #click on deliver to lab
    Click  xpath  //span[contains(.,'Deliver to Lab')]
    #Wait for some time for screen to come up
    Sleep  2
    #click on Deliver to lab button
    Click  id  delivertolab_btn
    #Wait for some time for screen to come up
    Sleep  2

    ### Kit to be used for Matrix TC-489###
    #Register the Qpad for the mentioned customer
    Register Qpad  ${APP_VERSION}  ${TEST_ENV}  ${customermobappendpoint}  ES14PAD2  _customermobapp@qvin.com
    #API call to mark start collection process of a pad
    Pad Start Collection  ${APP_VERSION}  ${TEST_ENV}  ${customermobappendpoint}  ES14PAD2  _customermobapp@qvin.com  REGISTERED
    #Sleep  so that the next notofication to user can be verified
    Sleep  10
    #API call to mark end collection process of a pad
    Pad End Collection  ${APP_VERSION}  ${TEST_ENV}  ${customermobappendpoint}  ES14PAD2  _customermobapp@qvin.com  IN_USE
    #Sleep  so that the next notofication to user can be verified
    Sleep  30
    #API call to mark start collection process of a pad
    Pad Start Collection   ${APP_VERSION}  ${TEST_ENV}  ${customermobappendpoint}  ES14PAD1  _customermobapp@qvin.com  IN_USE
    #Sleep  so that the next notofication to user can be verified
    Sleep  10
    #API call to mark end collection process of a pad
    Pad End Collection  ${APP_VERSION}  ${TEST_ENV}  ${customermobappendpoint}  ES14PAD1  _customermobapp@qvin.com  IN_USE
    #Sleep  so that the next notofication to user can be verified
    Sleep  30
    #Click on Dashboard link
    Click  xpath  //*[@id="logistics_listitem_dashboard"]
    #Wait for some time for screen to come up
    Sleep  2
    #Sleep so that page could loaded
    Sleep  3
    #clicking total kits
    Click  xpath  //*[@id="logisticsdashboard_btn_kitstotal"]
    #Enter Kit name to search
    Enter Text  xpath  //*[@id="logisticskits_input_kitid"]/div[1]/div[1]/label/input  ES14
    #Click Search
    Click  id  logisticskits_btn_search
    #Wait for some time for screen to come up
    Sleep  2
    #Click on Dots
    Click  id  logisticskits_menu_action
    #Click on Confirm by carrier
    Click  xpath  //span[contains(.,'Confirm by carrier')]
    #Click on Move to Delivered
    Click  id  confirmbycarrier_btn
    #Click on Dashboard link
    Click  xpath  //*[@id="logistics_listitem_dashboard"]
    #Wait for some time for screen to come up
    Sleep  2
    #Click on Confirmed by carrier
    Click  xpath  //*[@id="logisticsdashboard_btn_kitsconfirmedbycarrier"]
    #Sleep so that page could loaded
    Sleep  3
    #Enter Kit name to search
    Enter Text  xpath  //*[@id="logisticskits_input_kitid"]/div[1]/div[1]/label/input  ES14
    #Click Search
    Click  id  logisticskits_btn_search
    #Wait for some time for screen to come up
    Sleep  2
    #Click on Dots
    Click  id  logisticskits_menu_action
    #Click on Expire kit
    Click  xpath  //span[contains(.,'Expire kit')]
    #Click on YES button
    Click  xpath  //*[@id="logistics_common_btn_yesno"]/material-button[1]/material-ripple
    #Wait for some time for screen to come up
    Sleep  2
    ### Kit to be used for Matrix TC-488###
    #Register the Qpad for the mentioned customer
    Register Qpad  ${APP_VERSION}  ${TEST_ENV}  ${customermobappendpoint}  ES15PAD2  _customermobapp@qvin.com
    #API call to mark start collection process of a pad
    Pad Start Collection  ${APP_VERSION}  ${TEST_ENV}  ${customermobappendpoint}  ES15PAD2  _customermobapp@qvin.com  REGISTERED
    #Sleep  so that the next notofication to user can be verified
    Sleep  10
    #API call to mark end collection process of a pad
    Pad End Collection  ${APP_VERSION}  ${TEST_ENV}  ${customermobappendpoint}  ES15PAD2  _customermobapp@qvin.com  IN_USE
    #Sleep  so that the next notofication to user can be verified
    Sleep  30
    #API call to mark start collection process of a pad
    Pad Start Collection   ${APP_VERSION}  ${TEST_ENV}  ${customermobappendpoint}  ES15PAD1  _customermobapp@qvin.com  IN_USE
    #Sleep  so that the next notofication to user can be verified
    Sleep  10
    #API call to mark end collection process of a pad
    Pad End Collection  ${APP_VERSION}  ${TEST_ENV}  ${customermobappendpoint}  ES15PAD1  _customermobapp@qvin.com  IN_USE
    #API call to ship kit
    Ship Kit  ${APP_VERSION}  ${TEST_ENV}   ${customermobappendpoint}  ES15
    #Sleep  so that the next notofication to user can be verified
    Sleep  30
    #Click on Dashboard link
    Click  xpath  //*[@id="logistics_listitem_dashboard"]
    #Wait for some time for screen to come up
    Sleep  2
    #Click on Shipped by customer
    Click  xpath  //*[@id="logisticsdashboard_btn_kitshippedbycustomer"]
    #Sleep so that page could loaded
    Sleep  3
    #Enter Kit name to search
    Enter Text  xpath  //*[@id="logisticskits_input_kitid"]/div[1]/div[1]/label/input  ES15
    #Click Search
    Click  id  logisticskits_btn_search
    #Wait for some time for screen to come up
    Sleep  2
    #Click on Dots
    Click  id  logisticskits_menu_action
    #Click on Expire kit
    Click  xpath  //span[contains(.,'Expire kit')]
    #Click on YES button
    Click  xpath  //*[@id="logistics_common_btn_yesno"]/material-button[1]/material-ripple
    #Wait for some time for screen to come up
    Sleep  2
    ### Kit to be used for Matrix TC-120###
    #Register the Qpad for the mentioned customer
    Register Qpad  ${APP_VERSION}  ${TEST_ENV}  ${customerenvswitchendpoint}  ES06PAD1  _envswitch@qvin.com
    #API call to mark start collection process of a pad
    Pad Start Collection  ${APP_VERSION}  ${TEST_ENV}  ${customerenvswitchendpoint}  ES06PAD1  _envswitch@qvin.com  REGISTERED
    #Sleep  so that the next notofication to user can be verified
    Sleep  10
    #Click on Dashboard
    Click  xpath  //*[@id="logistics_listitem_dashboard"]
    #Wait for some time for screen to come up
    Sleep  2
    #Click on Kits button
#    Click  xpath  //*[@id="logistics_listitem_kits"]
    #Sleep so that page could loaded
    Sleep  3
    #clicking total kits
    Click  xpath  //*[@id="logisticsdashboard_btn_kitstotal"]
    #Enter Kit name to search
    Enter Text  xpath  //*[@id="logisticskits_input_kitid"]/div[1]/div[1]/label/input  ES06
    #Click Search
    Click  id  logisticskits_btn_search
    #Wait for some time for screen to come up
    Sleep  2
    #Click Link ES06
    Wait Until Keyword Succeeds  5x  200ms  Click  link  ES06
#    #Verify Device status "Start collection " for Pad 1
#    Verify Text In Table  xpath  /html/body/app/logistic/div/div/kit-detail/div[2]/card[6]/div[2]/div/devices/table/div/div/table   NotApplicable  ES06PAD1  4  Start collection
#    #Verify Device status "Empty" for Pad 2
#    Verify Text In Table  xpath  /html/body/app/logistic/div/div/kit-detail/div[2]/card[6]/div[2]/div/devices/table/div/div/table   NotApplicable  ES06PAD2  4  Empty


    #Kit prepare for TC-1569
    Click  xpath  //*[@id="logistics_listitem_dashboard"]
    #Wait for some time for screen to come up
    Sleep  2
    #Wait for some time for screen to come up
    Sleep  2
    #Click on Reserved button
    Click  xpath  //*[@id="logisticsdashboard_btn_kitsreserved"]
    #Enter Kit name to search
    Enter Text  xpath  //*[@id="logisticskits_input_kitid"]/div[1]/div[1]/label/input  ES01
    #Click Search
    Click  id  logisticskits_btn_search
    #Wait for some time for screen to come up
    Sleep  2
    #Click on Dots
    Click  id  logisticskits_menu_action
    #Wait for some time for screen to come up
    Sleep  2
    #Click on Confirm by carrier
    Click  xpath  //span[contains(.,'Confirm by carrier(test: fail analysis request)')]
    #Wait for some time for screen to come up
    Sleep  2
    #Click on Confirm By Carrier button
    Click  xpath  //*[@id="confirmbycarrier_btn"]
    #Sleep so that page could loaded
    Sleep  3
    Click  xpath  //*[@id="logistics_listitem_dashboard"]
    Sleep  3
    Click   id  logisticsdashboard_btn_kitsconfirmedbycarrier
    Sleep  2
    #search for Kit on confirm by carrier tab
    Enter Text  xpath  //*[@id="logisticskits_input_kitid"]/div[1]/div[1]/label/input  ES01
    Sleep  2
    Send Keys  None  RETURN
    #Verify kit on confirm by carrier screen
    Verify  ES01
    #Click kit id to check status
    #Click on 3 dots and  Add use time button under kit detail screen.
    Click   id   logisticskits_menu_action
    #Wait for some time
    Sleep  3
    Wait Until Keyword Succeeds  5x  200ms  Click   xpath  //span[contains(.,'Add use times')]
    #Wait Until Keyword Succeeds  5x  200ms  Click  link  ES01
    Sleep  3
    #Click on Add use time button under kit detail screen.
    #Click   id   showAddUseTimeButton
    #Wait for some time for screen to come up
    Sleep  2
    #Uncheck the checkbox to remove the second pad
    Click  xpath  //tr[3]/td[2]/*[@id="logistics_padusedcheckbox"]/div[1]/material-ripple
    #Wait for some time for screen to come up
    Sleep  2
    #Get the current date
    ${date}=  Get Current Date  exclude_millis=TRUE
    #Wait for some time for screen to come up
    Sleep  2
    #Get the time element from the current date extracted
    ${time}=  Get Time From Date  ${date}
    #Click on the drop down for Use Time
    Click  xpath  //tr[1]/td[2]/div/material-date-time-picker/material-time-picker/material-dropdown-select/dropdown-button/div/glyph/i
    #Wait for some time for screen to come up
    Sleep  2
    #Click on the input field for Use Time
    Click  xpath   /html/body/div/div[8]/div/div/div[2]/header/div/div/div/material-input/div/div[1]/label/input
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
    Click  xpath  //tr[2]/td[4]/material-date-time-picker/material-time-picker/material-dropdown-select/dropdown-button/div/glyph/i
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
    Click  xpath  //tr[2]/td[6]/material-date-time-picker/material-time-picker/material-dropdown-select/dropdown-button/div/glyph/i
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
    #Take screenshot of the screen
    Capture Page Screenshot
    #Click on MoveToUsed button
    Click  xpath  //*[@id="logisticsactions_btn_movetoused"]
    #Click on YES button
    Click  xpath  //*[@id="logistics_common_btn_yesno"]/material-button[1]/material-ripple

    sleep  2

    #Prepare kit for TC-1570

    #Click on Dashboard link
    Click  xpath  //*[@id="logistics_listitem_dashboard"]
    Sleep  2
    #Click on Reserved button
    Click  xpath  //*[@id="logisticsdashboard_btn_kitsreserved"]
    #Enter Kit name to search
    Enter Text  xpath  //*[@id="logisticskits_input_kitid"]/div[1]/div[1]/label/input  ES02
    #Click Search
    Click  id  logisticskits_btn_search
    #Wait for some time for screen to come up
    Sleep  2
    #Click on Dots
    Click  id  logisticskits_menu_action
    #Wait for some time for screen to come up
    Sleep  2
    #Click on Confirm by carrier
    Click  xpath  //span[contains(.,'Confirm by carrier(test: fail analysis request)')]
    #Wait for some time for screen to come up
    Sleep  2
    #Click on Confirm By Carrier button
    Click  xpath  //*[@id="confirmbycarrier_btn"]
    #Sleep so that page could loaded
    Sleep  10
    #click on lab dashboard
    Click  xpath  //*[@id="logistics_listitem_dashboard"]
    #click confirmder by carrier button
    Click  xpath  //*[@id="logisticsdashboard_btn_kitsconfirmedbycarrier"]
    #enter text in input bar
    Enter Text  xpath  //*[@id="logisticskits_input_kitid"]/div[1]/div[1]/label/input  ES02
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
    #click on deliver to lab
    Click  xpath  //span[contains(.,'Deliver to Lab')]
    #Wait for some time for screen to come up
    Sleep  2
    #click on Deliver to lab button
    Click  id  delivertolab_btn
    #Wait for some time for screen to come up
    Sleep  2
    #CLick Dashboard
    Click  xpath  //*[@id="logistics_listitem_dashboard"]
    #Wait for some time for screen to come up
    Sleep  2
    Click  id  logisticsdashboard_btn_kitdeliveredatlab
    #search for the Kid Id
    Enter Text  xpath  //*[@id="logisticskits_input_kitid"]/div[1]/div[1]/label/input   ES02
    Sleep  2
    #click on search button
    Click  id  logisticskits_btn_search
    #Verify kit is on delivered at lab screen
    Verify  ES02

    #Prepare kit for TC-1573
    #register kit for user
    Register QPad  ${APP_VERSION}  ${TEST_ENV}  ${customermobappendpoint}  ES03PAD1  _customermobapp@qvin.com
    #Wait for some time for screen to come up
    Sleep  2
    #click on lab dashboard
    Click  xpath  //*[@id="logistics_listitem_dashboard"]

    #click on registered kit
    Click  xpath  //*[@id="logisticsdashboard_btn_kitregistered"]
    #Wait for some time for screen to come up
    Sleep  2
    #enter text in input bar
    Enter text  xpath  //*[@id="logisticskits_input_kitid"]/div[1]/div[1]/label/input   ES03
    #click on search button
    Click  id  logisticskits_btn_search
    #Wait for some time for screen to come up
    Sleep  2
    #click on dots
    Click  id  logisticskits_menu_action
    #Wait for some time for screen to come up
    Sleep  2
    #click on confirm by carrier
    Click  xpath  //span[contains(.,'Confirm by carrier(test: fail analysis request)')]
    #Wait for some time for screen to come up
    Sleep  2
    #Click on Confirm By Carrier button
    Click  xpath  //*[@id="confirmbycarrier_btn"]
    #Sleep so that page could loaded
    Sleep  3
    #CLick on dashboard
    Click  xpath  //*[@id="logistics_listitem_dashboard"]
    Sleep  2
    #CLick  confirm by carrier on dashboard
    Click  id   logisticsdashboard_btn_kitsconfirmedbycarrier
    Sleep  2
    #serach for the kit
    Enter text  xpath  //*[@id="logisticskits_input_kitid"]/div[1]/div[1]/label/input  ES03
    Send Keys  None  RETURN
    Sleep  2

    #Veify kit on screen
    Verify  ES03

    #CLick kit link to check status
    Wait Until Keyword Succeeds  5x  200ms  Click  link  ES03
    #Verify kit status
    Verify Text In Locator  Xpath  /html/body/app/logistic/div/div/kit-detail/div[2]/card[2]/div[2]/order-details/table/tr[5]/td[2]    Shipped
    Sleep  5


    #Prepare kit for TC-1578
    #register kit for user
    Register QPad  ${APP_VERSION}  ${TEST_ENV}  ${customermobappendpoint}  ES13PAD1  _customermobapp@qvin.com
    #Wait for some time for screen to come up
    Sleep  2
    #click on lab dashboard
    Click  xpath  //*[@id="logistics_listitem_dashboard"]
    #click on registered kit
    Click  xpath  //*[@id="logisticsdashboard_btn_kitregistered"]
    #Wait for some time for screen to come up
    Sleep  2
    #enter text in input bar
    Enter text  xpath  //*[@id="logisticskits_input_kitid"]/div[1]/div[1]/label/input   ES13
    #click on search button
    Click  id  logisticskits_btn_search
    #Wait for some time for screen to come up
    Sleep  2
    #click on dots
    Click  id  logisticskits_menu_action
    #Wait for some time for screen to come up
    Sleep  2
    #click on confirm by carrier
    Click  xpath  //span[contains(.,'Confirm by carrier(test: fail analysis request)')]
    #Wait for some time for screen to come up
    Sleep  2
    #Click on Confirm By Carrier button
    Click  xpath  //*[@id="confirmbycarrier_btn"]
    #Sleep so that page could loaded
    Sleep  3
    #Click dashboard
    Click  xpath  //*[@id="logistics_listitem_dashboard"]
    Sleep  2
    #CLick  confirm by carrier on dashboard
    Click  id   logisticsdashboard_btn_kitsconfirmedbycarrier
    Sleep  2
    #serach for the kit
    Enter text  xpath  //*[@id="logisticskits_input_kitid"]/div[1]/div[1]/label/input  ES13
    Send Keys  None  RETURN
    Sleep  2
    #click on dots
    Click  id  logisticskits_menu_action
    #Wait for some time for screen to come up
    Sleep  2
    #click on deliver to lab
    Click  xpath  //span[contains(.,'Deliver to Lab')]
    #Wait for some time for screen to come up
    Sleep  2
    #click on Deliver to lab button
    Click  id  delivertolab_btn
    #CLick on dashboard
    Click  xpath  //*[@id="logistics_listitem_dashboard"]
    #Wait for some time for screen to come up
    Sleep  2
    Click  id  logisticsdashboard_btn_kitdeliveredatlab

    #search for the Kid Id
    Enter Text  xpath  //*[@id="logisticskits_input_kitid"]/div[1]/div[1]/label/input   ES13
    Sleep  2
    #click on search button
    Click  id  logisticskits_btn_search
    #Verify kit is on delivered at lab screen
    Verify  ES13
    #Click on 3 dots and  Add use time button under kit detail screen.
    Click   id   logisticskits_menu_action
    #Wait for some time
    Sleep  3
    Wait Until Keyword Succeeds  5x  200ms  Click   xpath  //span[contains(.,'Add use times')]

    #Click kit id to check status
#    Wait Until Keyword Succeeds  5x  200ms  Click  link  ES13
    Sleep  3
#    #Click on Add use time button under kit detail screen.
#    Click   id   showAddUseTimeButton
    #Wait for some time for screen to come up
    Sleep  2
    #Uncheck the checkbox to remove the second pad
    Click  xpath  //tr[3]/td[2]/*[@id="logistics_padusedcheckbox"]/div[1]/material-ripple
    #Wait for some time for screen to come up
    Sleep  2
    #Get the current date
    ${date}=  Get Current Date  exclude_millis=TRUE
    #Wait for some time for screen to come up
    Sleep  2
    #Get the time element from the current date extracted
    ${time}=  Get Time From Date  ${date}
    #Click on the drop down for Use Time
    Click  xpath  //tr[1]/td[2]/div/material-date-time-picker/material-time-picker/material-dropdown-select/dropdown-button/div/glyph/i
    #Wait for some time for screen to come up
    Sleep  2
    #Click on the input field for Use Time
    Click  xpath   /html/body/div/div[8]/div/div/div[2]/header/div/div/div/material-input/div/div[1]/label/input
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
    Click  xpath  //tr[2]/td[4]/material-date-time-picker/material-time-picker/material-dropdown-select/dropdown-button/div/glyph/i
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
    Click  xpath  //tr[2]/td[6]/material-date-time-picker/material-time-picker/material-dropdown-select/dropdown-button/div/glyph/i
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
    #Take screenshot of the screen
    Capture Page Screenshot
    #Click on MoveToUsed button
    Click  xpath  //*[@id="logisticsactions_btn_movetoused"]
    #Click on YES button
    Click  xpath  //*[@id="logistics_common_btn_yesno"]/material-button[1]/material-ripple

    sleep  2

    #Prepare kit for TC-340
    #Register the Qpad for the mentioned customer
    Register Qpad  ${APP_VERSION}  ${TEST_ENV}  ${customermobappendpoint}  MA15PAD1  _customermobapp@qvin.com
    #API call to mark start collection process of a pad
    Pad Start Collection  ${APP_VERSION}  ${TEST_ENV}   ${customermobappendpoint}  MA15PAD1  _customermobapp@qvin.com  REGISTERED
    #Sleep  so that the next notofication to user can be verified
    Sleep  10
    #Click on Dashboard link
    Click  xpath  //*[@id="logistics_listitem_dashboard"]
    #Click on Kits in Use button
    Click  xpath  //*[@id="logisticsdashboard_btn_kitsinuse"]
    #Enter Kit name to search
    Enter Text  xpath  //*[@id="logisticskits_input_kitid"]/div[1]/div[1]/label/input  MA15
    #Click Search
    Click  id  logisticskits_btn_search
    #Wait for some time for screen to come up
    Sleep  2
    #Click on Dots
    Click  id  logisticskits_menu_action
    #Click on confirm by carrier
    Click  xpath  //span[contains(.,'Confirm by carrier')]
    #Click on Confirm Shipment button
    Click  xpath  //*[@id="confirmbycarrier_btn"]
    #Click on Dashboard link
    Click  xpath  //*[@id="logistics_listitem_dashboard"]
    #Click on Shipped By Customer button
    Click  xpath  //*[@id="logisticsdashboard_btn_kitsconfirmedbycarrier"]
    #Enter Kit name to search
    Enter Text  xpath  //*[@id="logisticskits_input_kitid"]/div[1]/div[1]/label/input  MA15
    #Click Search
    Click  id  logisticskits_btn_search
    #Wait for some time for screen to come up
    Sleep  2
    #Click on Dots
    Click  id  logisticskits_menu_action
    #Click on Reject by Logistics
    Click  xpath  //span[contains(.,'Deliver to Lab')]
    Sleep   2
    #Click on deliver to lab button
    Click  xpath  //*[@id="delivertolab_btn"]
    Sleep   2
    #Click on Dashboard
    Click  xpath  //*[@id="logistics_listitem_dashboard"]
    #Wait for some time for screen to come up
    Sleep  2
    #Click on Kits button
    #Click  xpath  //*[@id="logistics_listitem_kits"]
    #Sleep so that page could loaded
    Sleep  3
    #clicking total kits
    Click  xpath  //*[@id="logisticsdashboard_btn_kitstotal"]
    #Enter Kit name to search
    Enter Text  xpath  //*[@id="logisticskits_input_kitid"]/div[1]/div[1]/label/input  MA15
    #Click Search
    Click  id  logisticskits_btn_search
    #Wait for some time for screen to come up
    Sleep  2
    #Click Link MA15
    Wait Until Keyword Succeeds  5x  200ms  Click  link  MA15
    #veriy status of kit
    Sleep  5
#    #Verify Device status "Start collection " for Pad 1
#    Verify Text In Table  xpath  //*[@id="smarttable_device_component"]/div/div/table  NotApplicable  MA15PAD1  3  Start collection
#    #Verify Device status "Empty" for Pad 2
#    Verify Text In Table  xpath  //*[@id="smarttable_device_component"]/div/div/table  NotApplicable  MA15PAD2  3  Empty
    Sleep   4
    ##TC-103####
    #Register the Qpad for the mentioned customer
    Register Qpad  ${APP_VERSION}  ${TEST_ENV}  ${customermobappendpoint}  MA14PAD2  _customermobapp@qvin.com
    #API call to mark start collection process of a pad
    Pad Start Collection  ${APP_VERSION}  ${TEST_ENV}   ${customermobappendpoint}  MA14PAD2  _customermobapp@qvin.com  REGISTERED
    #Sleep  so that the next notofication to user can be verified
    Sleep  10
    #API call to mark end collection process of a pad
    Pad End Collection  ${APP_VERSION}  ${TEST_ENV}  ${customermobappendpoint}  MA14PAD2  _customermobapp@qvin.com  IN_USE
    #Sleep  so that the next notofication to user can be verified
    Sleep  30
    #Click on Dashboard link
    Click  xpath  //*[@id="logistics_listitem_dashboard"]
    #Wait for some time for screen to come up
    Sleep  2
    Click   xpath  //*[@id="logisticsdashboard_btn_kitsinuse"]
    Sleep  3
    Enter Text  xpath   //*[@id="logisticskits_input_kitid"]/div[1]/div[1]/label/input  MA14
    Click  id  logisticskits_btn_search
    Sleep  2
    #click on 3 click assign dots
    Click  id  logisticskits_menu_action
    #Click on Confirm by carrier
    Click  xpath  //span[contains(.,'Shipped by customer')]
    Sleep  2
    #Select Lost from drop down
    Click  xpath  /html/body/div/div[6]/material-dialog/focus-trap/div[2]/div/main/customer-shipment/div[2]/table/tr[2]/td[3]/material-dropdown-select/dropdown-button/div/glyph/i
    Click  xpath  /html/body/div/div[8]/div/div/div[2]/div/material-list/material-select-item[2]
    Sleep  3
    #Click on confirm customer shipment
    Click  id  logisticsactions_btn_confirmshipment
    Sleep  3
    ##Click on Dashboard link
    Click  xpath  //*[@id="logistics_listitem_dashboard"]
    #Wait for some time for screen to come up
    Sleep  2
    #Click on Shipped by customer
    Click  xpath  //*[@id="logisticsdashboard_btn_kitshippedbycustomer"]
    #Sleep so that page could loaded
    Sleep  3
    #Enter Kit name to search
    Enter Text  xpath  //*[@id="logisticskits_input_kitid"]/div[1]/div[1]/label/input  MA14
    #Click Search
    Click  id  logisticskits_btn_search
    #Wait for some time for screen to come up
    Sleep  2
    #Clcik on Assign Dots
    Click  id  logisticskits_menu_action
    #Click on Confirm by carrier
    Click  xpath  //span[contains(.,'Confirm by carrier')]
    #Click on Move to Delivered
    Click  id  confirmbycarrier_btn
    Sleep  2
    ##Click on Dashboard link
    Click  xpath  //*[@id="logistics_listitem_dashboard"]
    #Wait for some time for screen to come up
    Sleep  2
    #Click Confirm by carrier kits
    Click  xpath  //*[@id="logisticsdashboard_btn_kitsconfirmedbycarrier"]
    Sleep  4
    ##Enter Kit name to search
    Enter Text  xpath  //*[@id="logisticskits_input_kitid"]/div[1]/div[1]/label/input  MA14
    #Click Search
    Click  id  logisticskits_btn_search
    #Wait for some time for screen to come up
    Sleep  2
    #Clcik on Assign Dots
    Click  id  logisticskits_menu_action
    #Click on Confirm by carrier
    Click  xpath  //span[contains(.,'Deliver to Lab')]
    #Click on Move to Delivered
    Click  id  delivertolab_btn
    #Wait for some time for screen to come up
    Sleep  1
    ##TC-102####
    #Register the Qpad for the mentioned customer
    Register Qpad  ${APP_VERSION}  ${TEST_ENV}  ${customermobappendpoint}  MA13PAD1  _customermobapp@qvin.com
    #API call to mark start collection process of a pad
    Pad Start Collection  ${APP_VERSION}  ${TEST_ENV}   ${customermobappendpoint}  MA13PAD1  _customermobapp@qvin.com  REGISTERED
    #Sleep  so that the next notofication to user can be verified
    Sleep  10
    #API call to mark end collection process of a pad
    Pad End Collection  ${APP_VERSION}  ${TEST_ENV}  ${customermobappendpoint}  MA13PAD1  _customermobapp@qvin.com  IN_USE
    #Sleep  so that the next notofication to user can be verified
    Sleep  30
    Click  xpath  //*[@id="logistics_listitem_dashboard"]
    #Wait for some time for screen to come up
    Sleep  2
    Click   xpath  //*[@id="logisticsdashboard_btn_kitsinuse"]
    Sleep  3
    Enter Text  xpath   //*[@id="logisticskits_input_kitid"]/div[1]/div[1]/label/input  MA13
    Click  id  logisticskits_btn_search
    Sleep  2
    #click on 3 click assign dots
    Click  id  logisticskits_menu_action
    #Click on Confirm by carrier
    Click  xpath  //span[contains(.,'Shipped by customer')]
    Sleep  2
    #Select Lost from drop down
    Click  xpath  /html/body/div/div[6]/material-dialog/focus-trap/div[2]/div/main/customer-shipment/div[2]/table/tr[2]/td[3]/material-dropdown-select/dropdown-button/div/glyph/i
    Click  xpath  /html/body/div/div[8]/div/div/div[2]/div/material-list/material-select-item[2]
    Sleep  3
    #Click on confirm customer shipment
    Click  id  logisticsactions_btn_confirmshipment
    Sleep  3
    ##Click on Dashboard link
    Click  xpath  //*[@id="logistics_listitem_dashboard"]
    #Wait for some time for screen to come up
    Sleep  2
    #Click on Shipped by customer
    Click  xpath  //*[@id="logisticsdashboard_btn_kitshippedbycustomer"]
    #Sleep so that page could loaded
    Sleep  3
    #Enter Kit name to search
    Enter Text  xpath  //*[@id="logisticskits_input_kitid"]/div[1]/div[1]/label/input  MA13
    #Click Search
    Click  id  logisticskits_btn_search
    #Wait for some time for screen to come up
    Sleep  2
    #Clcik on Assign Dots
    Click  id  logisticskits_menu_action
    #Click on Confirm by carrier
    Click  xpath  //span[contains(.,'Confirm by carrier')]
    #Click on Move to Delivered
    Click  id  confirmbycarrier_btn
    Sleep  2
    ##Click on Dashboard link
    Click  xpath  //*[@id="logistics_listitem_dashboard"]
    #Wait for some time for screen to come up
    Sleep  2
    #Click Confirm by carrier kits
    Click  xpath  //*[@id="logisticsdashboard_btn_kitsconfirmedbycarrier"]
    Sleep  4
    ##Enter Kit name to search
    Enter Text  xpath  //*[@id="logisticskits_input_kitid"]/div[1]/div[1]/label/input  MA13
    #Click Search
    Click  id  logisticskits_btn_search
    #Wait for some time for screen to come up
    Sleep  2
    #Clcik on Assign Dots
    Click  id  logisticskits_menu_action
    #Click on Confirm by carrier
    Click  xpath  //span[contains(.,'Deliver to Lab')]
    #Click on Move to Delivered
    Click  id  delivertolab_btn
    #Wait for some time for screen to come up
    Sleep  1
    ##TC-1241###start here
    #Register the Qpad for the mentioned customer
    Register Qpad  ${APP_VERSION}  ${TEST_ENV}  ${customermobappendpoint}  TA08PAD1  _customermobapp@qvin.com
    #API call to mark start collection process of a pad 1
    Pad Start Collection  ${APP_VERSION}  ${TEST_ENV}   ${customermobappendpoint}  TA08PAD1  _customermobapp@qvin.com  REGISTERED
    #Sleep  so that the next notofication to user can be verified
    Sleep  10
    #API call to mark end collection process of a pad
    Pad End Collection  ${APP_VERSION}  ${TEST_ENV}  ${customermobappendpoint}  TA08PAD1  _customermobapp@qvin.com  IN_USE
    #Sleep  so that the next notofication to user can be verified
    Sleep  30
    #API call to mark start collection process of a pad 2
    Pad Start Collection  ${APP_VERSION}  ${TEST_ENV}   ${customermobappendpoint}  TA08PAD2  _customermobapp@qvin.com  IN_USE
    #Sleep  so that the next notofication to user can be verified
    Sleep  10
    #API call to mark end collection process of a pad 2
    Pad End Collection  ${APP_VERSION}  ${TEST_ENV}  ${customermobappendpoint}  TA08PAD2  _customermobapp@qvin.com  IN_USE
    #Sleep  so that the next notofication to user can be verified
    Sleep  30
    #Click on Dashboard link
    Click  xpath  //*[@id="logistics_listitem_dashboard"]
    #Wait for some time for screen to come up
    Sleep  2
    Click   xpath  //*[@id="logisticsdashboard_btn_kitsinuse"]
    Sleep  3
    Enter Text  xpath   //*[@id="logisticskits_input_kitid"]/div[1]/div[1]/label/input  TA08
    Click  id  logisticskits_btn_search
    Sleep  2
    #click on 3 click assign dots
    Click  id  logisticskits_menu_action
    #Click on Confirm by carrier
    Click  xpath  //span[contains(.,'Shipped by customer')]
    Sleep  3
    #Click on confirm customer shipment
    Click  id  logisticsactions_btn_confirmshipment
    Sleep  3
    ##Click on Dashboard link
    Click  xpath  //*[@id="logistics_listitem_dashboard"]
    #Wait for some time for screen to come up
    Sleep  2
    #Click on Shipped by customer
    Click  xpath  //*[@id="logisticsdashboard_btn_kitshippedbycustomer"]
    #Sleep so that page could loaded
    Sleep  3
    #Enter Kit name to search
    Enter Text  xpath  //*[@id="logisticskits_input_kitid"]/div[1]/div[1]/label/input  TA08
    #Click Search
    Click  id  logisticskits_btn_search
    #Wait for some time for screen to come up
    Sleep  2
    #Clcik on Assign Dots
    Click  id  logisticskits_menu_action
    #Click on Confirm by carrier
    Click  xpath  //span[contains(.,'Confirm by carrier')]
    #Click on Move to Delivered
    Click  id  confirmbycarrier_btn
    Sleep  2
    ##Click on Dashboard link
    Click  xpath  //*[@id="logistics_listitem_dashboard"]
    #Wait for some time for screen to come up
    Sleep  2
    #Click Confirm by carrier kits
    Click  xpath  //*[@id="logisticsdashboard_btn_kitsconfirmedbycarrier"]
    Sleep  4
    ##Enter Kit name to search
    Enter Text  xpath  //*[@id="logisticskits_input_kitid"]/div[1]/div[1]/label/input  TA08
    #Click Search
    Click  id  logisticskits_btn_search
    #Wait for some time for screen to come up
    Sleep  2
    #Clcik on Assign Dots
    Click  id  logisticskits_menu_action
    #Click on Confirm by carrier
    Click  xpath  //span[contains(.,'Deliver to Lab')]
    #Click on Move to Delivered
    Click  id  delivertolab_btn
    #Wait for some time for screen to come up
    ##TC-1242###start here
    #Register the Qpad for the mentioned customer
    Register Qpad  ${APP_VERSION}  ${TEST_ENV}  ${customermobappendpoint}  TA09PAD1  _customermobapp@qvin.com
    #API call to mark start collection process of a pad 1
    Pad Start Collection  ${APP_VERSION}  ${TEST_ENV}   ${customermobappendpoint}  TA09PAD1  _customermobapp@qvin.com  REGISTERED
    #Sleep  so that the next notofication to user can be verified
    Sleep  10
    #API call to mark end collection process of a pad
    Pad End Collection  ${APP_VERSION}  ${TEST_ENV}  ${customermobappendpoint}  TA09PAD1  _customermobapp@qvin.com  IN_USE
    #Sleep  so that the next notofication to user can be verified
    Sleep  30
    #API call to mark start collection process of a pad 2
    Pad Start Collection  ${APP_VERSION}  ${TEST_ENV}   ${customermobappendpoint}  TA09PAD2  _customermobapp@qvin.com  IN_USE
    #Sleep  so that the next notofication to user can be verified
    Sleep  10
    #API call to mark end collection process of a pad 2
    Pad End Collection  ${APP_VERSION}  ${TEST_ENV}  ${customermobappendpoint}  TA09PAD2  _customermobapp@qvin.com  IN_USE
    #Sleep  so that the next notofication to user can be verified
    Sleep  30
    #Click on Dashboard link
    Click  xpath  //*[@id="logistics_listitem_dashboard"]
    #Wait for some time for screen to come up
    Sleep  2
    Click   xpath  //*[@id="logisticsdashboard_btn_kitsinuse"]
    Sleep  3
    Enter Text  xpath   //*[@id="logisticskits_input_kitid"]/div[1]/div[1]/label/input  TA09
    Click  id  logisticskits_btn_search
    Sleep  2
    #click on 3 click assign dots
    Click  id  logisticskits_menu_action
    #Click on Confirm by carrier
    Click  xpath  //span[contains(.,'Shipped by customer')]
    Sleep  3
    #Click on confirm customer shipment
    Click  id  logisticsactions_btn_confirmshipment
    Sleep  3
    ##Click on Dashboard link
    Click  xpath  //*[@id="logistics_listitem_dashboard"]
    #Wait for some time for screen to come up
    Sleep  2
    #Click on Shipped by customer
    Click  xpath  //*[@id="logisticsdashboard_btn_kitshippedbycustomer"]
    #Sleep so that page could loaded
    Sleep  3
    #Enter Kit name to search
    Enter Text  xpath  //*[@id="logisticskits_input_kitid"]/div[1]/div[1]/label/input  TA09
    #Click Search
    Click  id  logisticskits_btn_search
    #Wait for some time for screen to come up
    Sleep  2
    #Clcik on Assign Dots
    Click  id  logisticskits_menu_action
    #Click on Confirm by carrier
    Click  xpath  //span[contains(.,'Confirm by carrier')]
    #Click on Move to Delivered
    Click  id  confirmbycarrier_btn
    Sleep  2
    ##Click on Dashboard link
    Click  xpath  //*[@id="logistics_listitem_dashboard"]
    #Wait for some time for screen to come up
    Sleep  2
    #Click Confirm by carrier kits
    Click  xpath  //*[@id="logisticsdashboard_btn_kitsconfirmedbycarrier"]
    Sleep  4
    ##Enter Kit name to search
    Enter Text  xpath  //*[@id="logisticskits_input_kitid"]/div[1]/div[1]/label/input  TA09
    #Click Search
    Click  id  logisticskits_btn_search
    #Wait for some time for screen to come up
    Sleep  2
    #Clcik on Assign Dots
    Click  id  logisticskits_menu_action
    #Click on Confirm by carrier
    Click  xpath  //span[contains(.,'Deliver to Lab')]
    #Click on Move to Delivered
    Click  id  delivertolab_btn
    #Wait for some time for screen to come up
    ##TC-1243###start here
    #Register the Qpad for the mentioned customer
    Register Qpad  ${APP_VERSION}  ${TEST_ENV}  ${customermobappendpoint}  TA10PAD1  _customermobapp@qvin.com
    #API call to mark start collection process of a pad 1
    Pad Start Collection  ${APP_VERSION}  ${TEST_ENV}   ${customermobappendpoint}  TA10PAD1  _customermobapp@qvin.com  REGISTERED
    #Sleep  so that the next notofication to user can be verified
    Sleep  10
    #API call to mark end collection process of a pad
    Pad End Collection  ${APP_VERSION}  ${TEST_ENV}  ${customermobappendpoint}  TA10PAD1  _customermobapp@qvin.com  IN_USE
    #Sleep  so that the next notofication to user can be verified
    Sleep  30
    #API call to mark start collection process of a pad 2
    Pad Start Collection  ${APP_VERSION}  ${TEST_ENV}   ${customermobappendpoint}  TA10PAD2  _customermobapp@qvin.com  IN_USE
    #Sleep  so that the next notofication to user can be verified
    Sleep  10
    #API call to mark end collection process of a pad 2
    Pad End Collection  ${APP_VERSION}  ${TEST_ENV}  ${customermobappendpoint}  TA10PAD2  _customermobapp@qvin.com  IN_USE
    #Sleep  so that the next notofication to user can be verified
    Sleep  30
    #Click on Dashboard link
    Click  xpath  //*[@id="logistics_listitem_dashboard"]
    #Wait for some time for screen to come up
    Sleep  2
    Click   xpath  //*[@id="logisticsdashboard_btn_kitsinuse"]
    Sleep  3
    Enter Text  xpath   //*[@id="logisticskits_input_kitid"]/div[1]/div[1]/label/input  TA10
    Click  id  logisticskits_btn_search
    Sleep  2
    #click on 3 click assign dots
    Click  id  logisticskits_menu_action
    #Click on Confirm by carrier
    Click  xpath  //span[contains(.,'Shipped by customer')]
    Sleep  3
    #Click on confirm customer shipment
    Click  id  logisticsactions_btn_confirmshipment
    Sleep  3
    ##Click on Dashboard link
    Click  xpath  //*[@id="logistics_listitem_dashboard"]
    #Wait for some time for screen to come up
    Sleep  2
    #Click on Shipped by customer
    Click  xpath  //*[@id="logisticsdashboard_btn_kitshippedbycustomer"]
    #Sleep so that page could loaded
    Sleep  3
    #Enter Kit name to search
    Enter Text  xpath  //*[@id="logisticskits_input_kitid"]/div[1]/div[1]/label/input  TA10
    #Click Search
    Click  id  logisticskits_btn_search
    #Wait for some time for screen to come up
    Sleep  2
    #Clcik on Assign Dots
    Click  id  logisticskits_menu_action
    #Click on Confirm by carrier
    Click  xpath  //span[contains(.,'Confirm by carrier')]
    #Click on Move to Delivered
    Click  id  confirmbycarrier_btn
    Sleep  2
    ##Click on Dashboard link
    Click  xpath  //*[@id="logistics_listitem_dashboard"]
    #Wait for some time for screen to come up
    Sleep  2
    #Click Confirm by carrier kits
    Click  xpath  //*[@id="logisticsdashboard_btn_kitsconfirmedbycarrier"]
    Sleep  4
    ##Enter Kit name to search
    Enter Text  xpath  //*[@id="logisticskits_input_kitid"]/div[1]/div[1]/label/input  TA10
    #Click Search
    Click  id  logisticskits_btn_search
    #Wait for some time for screen to come up
    Sleep  2
    #Clcik on Assign Dots
    Click  id  logisticskits_menu_action
    #Click on Confirm by carrier
    Click  xpath  //span[contains(.,'Deliver to Lab')]
    #Click on Move to Delivered
    Click  id  delivertolab_btn
    #Wait for some time for screen to come up
    Sleep  4
   #close browser
    close browser

