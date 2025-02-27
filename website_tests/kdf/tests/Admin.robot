*** Settings ***
Documentation  This is a test suite for Qurasense GUI Testing
Resource  ../data/GlobalVariables.robot
Resource    ../resources/PageActions.robot
Resource    ../resources/CustomActions.robot
*** Variables ***


*** Test Cases ***


AT_ADM_01
# Test case to setup 2fa as false
    #Open Browser and navigate to the desired URL
    Navigate To And Verify  ${BROWSER}  ${TEST_URL}/#/site/login  Qvin
    #Click username
    Click  css  input[type='text']
    #Enter username
    Enter Text  css  input[type='text']  _admin@qvin.com
    #Click password
    Click  css  input[type='password']
    #Enter password
    Enter Text  css  input[type='password']  secret
    #Click Login button
    Click  id  login_btn_signin
    #Click 2facode input text
    Click  id  login_input_2facode
    # Enter 2FA code
    Enter Text  xpath  //*[@id="login_input_2facode"]/div[1]/div[1]/label/input  123
    #Click Login button
    Click  id  login_btn_signin
    # Click Variables from left list item in Admin dashboard.
    Click  xpath  //*[@id="variables_list_item"]
    #Search for the variable and click on the Actions menu item
    Click Cell In Table  xpath  //*[@id="variables_smart_table"]/div/div/table  //*[@id="variables_menu_action"]/material-button  NotApplicable  2fa.enabled
    # Click on Edit variable menu item
    Click  xpath  //material-select-item[contains(.,'Edit variable')]
    # Click on variable input to be edited
    Click  xpath  //*[@id="input_variable_value"]/div[1]/div[1]/label/input
    #Send keys Ctrl+a for selecting all text
    Send Keys  None  CTRL+a
    #Send keys DELETE for deleting all text
    Send Keys  None  DELETE
    #Send keys for adding time value
    Send Keys  None  false
    #Click SAVE button
    Click  xpath  //*[@id="button_save"]/material-ripple
    #Wait for some time for screen to come up
    Sleep  2
    #Close the Browser being used for test.
    Close Browser


AT_ADM_02
#Test case to settup communication schema
    #Open Browser and navigate to the desired URL
    Navigate To And Verify   ${BROWSER}  ${DASHBOARD_URL}/#/site/login  Qvin
    #Click username
    Click  css  input[type='text']
    #Enter username
    Enter Text  css  input[type='text']  _admin@qvin.com
    #Click password
    Click  css  input[type='password']
    #Enter password
    Enter Text  css  input[type='password']  secret
    #Click Login button
    Click  id  login_btn_signin
    #Click 2facode input text
    Click  id  login_input_2facode
    # Enter 2FA code
    Enter Text  xpath  //*[@id="login_input_2facode"]/div[1]/div[1]/label/input  123
    #Click Login button
    Click  id  login_btn_signin
    #click communication schema
    Click  xpath  //*[@id="communication_list_item"]
    #clicking 3 dots menu for the reminder to schedule(nurse) for nurse email
    Click Cell In Table  xpath  //*[@id="smarttable_notification_events"]/div/div/table  //*[@id="notification_menu_action"]  10  Reminder to schedule(collector,)  Slack
    #clcik edit button in 3 dots menu
    Click   xpath   //span[contains(.,'Edit')]
    #clicking on dropdown to select product type
    Click   xpath   //*[@id="textnotification_bundledropdown"]
    #wait for page to appear
    Sleep   2
    #check checkbox for the product San Diego Comparative trial
    Click   xpath   //span[contains(.,'Bundle_QPAD_PP_A1C')]
    #wait for the product to select
    Sleep   2
    #click on save button
    Click  id  textnotification_save_btn
    #wait for some time for the page to load
    Sleep  3
    #clicking 3 dots menu for the reminder to schedule(nurse) for Slack kit update
    Click Cell In Table  xpath  //*[@id="smarttable_notification_events"]/div/div/table  //*[@id="notification_menu_action"]  10  Physician approval required for analysis  Slack
    #clcik edit button in 3 dots menu
    Click   xpath   //span[contains(.,'Edit')]
    #clicking on dropdown to select product type
    Click   xpath   //*[@id="textnotification_bundledropdown"]
    #wait for page to appear
    Sleep   2
    #check checkbox for the product San Diego Comparative trial
    Click   xpath   //span[contains(.,'Bundle_QPAD_PP_A1C')]
    #click on save button
    Click  id  textnotification_save_btn
    #wait for the page to load  completely
    sleep   5
    #closing browser
    close browser

AT_ADM_03
#Test case to creare part(kit)
    #Open Browser and navigate to the desired URL
    Navigate To And Verify  ${BROWSER}  ${DASHBOARD_URL}/#/site/login  Qvin
    #Click username
    Click  css  input[type='text']
    #Enter username
    Enter Text  css  input[type='text']  _admin@qvin.com
    #Click password
    Click  css  input[type='password']
    #Enter password
    Enter Text  css  input[type='password']  secret
    #Click Login button
    Click  id  login_btn_signin
    #Click 2facode input text
    Click  id  login_input_2facode
    # Enter 2FA code
    Enter Text  xpath  //*[@id="login_input_2facode"]/div[1]/div[1]/label/input  123
    #Click Login button
    Click  id  login_btn_signin
    # Click Variables from left list item in Admin dashboard.
    Click  xpath  //*[@id="part_list_item"]
    #Click Add Part
    Click  xpath  /html/body/app/admin/div/div/parts/div/material-button/material-ripple

    # Click on Part ID Input
    Click  xpath  //*[@id="default-acx-overlay-container"]/div[6]/material-dialog/focus-trap/div[2]/div/main/update-part/form/table/tr[1]/td[2]/material-input/div[1]/div[1]/label/input
    # Click on variable input to be Added
    Enter Text  xpath  //*[@id="default-acx-overlay-container"]/div[6]/material-dialog/focus-trap/div[2]/div/main/update-part/form/table/tr[1]/td[2]/material-input/div[1]/div[1]/label/input  Q-155-02
    # Click Dropdown for Type.
    Click  xpath  //*[@id="default-acx-overlay-container"]/div[6]/material-dialog/focus-trap/div[2]/div/main/update-part/form/table/tr[2]/td[2]/div/material-dropdown-select/dropdown-button
    # Select type as "Kit".
    Click  xpath  //material-select-item[contains(.,'Kit')]
    # Click Lot Id Prefix Input
    Click  xpath  //*[@id="default-acx-overlay-container"]/div[6]/material-dialog/focus-trap/div[2]/div/main/update-part/form/table/tr[3]/td[2]/material-input/div[1]/div[1]/label/input
    # Click on variable input to be added
    Enter Text  xpath  //*[@id="default-acx-overlay-container"]/div[6]/material-dialog/focus-trap/div[2]/div/main/update-part/form/table/tr[3]/td[2]/material-input/div[1]/div[1]/label/input  k
    # Click Order Num Input
    Click  xpath  //*[@id="default-acx-overlay-container"]/div[6]/material-dialog/focus-trap/div[2]/div/main/update-part/form/table/tr[4]/td[2]/material-input/div[1]/div[1]/label/input
    # Click on variable input to be added
    Enter Text  xpath  //*[@id="default-acx-overlay-container"]/div[6]/material-dialog/focus-trap/div[2]/div/main/update-part/form/table/tr[4]/td[2]/material-input/div[1]/div[1]/label/input  22
    # Click GSTIN Input
    Click  xpath  //*[@id="default-acx-overlay-container"]/div[6]/material-dialog/focus-trap/div[2]/div/main/update-part/form/table/tr[5]/td[2]/material-input/div[1]/div[1]/label/input
    # Click on variable input to be added
    Enter Text  xpath  //*[@id="default-acx-overlay-container"]/div[6]/material-dialog/focus-trap/div[2]/div/main/update-part/form/table/tr[5]/td[2]/material-input/div[1]/div[1]/label/input  GTIN23410

    # Click "Save" button
    Click  xpath  //*[@id="default-acx-overlay-container"]/div[6]/material-dialog/focus-trap/div[2]/div/main/update-part/form/div/material-button/material-ripple

    Sleep  10
    #Close the Browser being used for test.
    Close Browser



AT_ADM_04
#Test case to creare part(pad)
    #Open Browser and navigate to the desired URL
    Navigate To And Verify  ${BROWSER}  ${DASHBOARD_URL}/#/site/login  Qvin
    #Click username
    Click  css  input[type='text']
    #Enter username
    Enter Text  css  input[type='text']  _admin@qvin.com
    #Click password
    Click  css  input[type='password']
    #Enter password
    Enter Text  css  input[type='password']  secret
    #Click Login button
    Click  id  login_btn_signin
    #Click 2facode input text
    Click  id  login_input_2facode
    # Enter 2FA code
    Enter Text  xpath  //*[@id="login_input_2facode"]/div[1]/div[1]/label/input  123
    #Click Login button
    Click  id  login_btn_signin
    # Click Variables from left list item in Admin dashboard.
    Click  xpath  //*[@id="part_list_item"]
    #Click Add Part
    Click  xpath  /html/body/app/admin/div/div/parts/div/material-button/material-ripple

    # Click on Part ID Input
    Click  xpath  //*[@id="default-acx-overlay-container"]/div[6]/material-dialog/focus-trap/div[2]/div/main/update-part/form/table/tr[1]/td[2]/material-input/div[1]/div[1]/label/input
    # Click on variable input to be Added
    Enter Text  xpath  //*[@id="default-acx-overlay-container"]/div[6]/material-dialog/focus-trap/div[2]/div/main/update-part/form/table/tr[1]/td[2]/material-input/div[1]/div[1]/label/input  Q-156-09
    # Click Dropdown for Type.
    Click  xpath  //*[@id="default-acx-overlay-container"]/div[6]/material-dialog/focus-trap/div[2]/div/main/update-part/form/table/tr[2]/td[2]/div/material-dropdown-select/dropdown-button
    # Select type as "Kit".
    Click  xpath  //material-select-item[contains(.,'Return pouch')]
    # Click Lot Id Prefix Input
    Click  xpath  //*[@id="default-acx-overlay-container"]/div[6]/material-dialog/focus-trap/div[2]/div/main/update-part/form/table/tr[3]/td[2]/material-input/div[1]/div[1]/label/input
    # Click on variable input to be added
    Enter Text  xpath  //*[@id="default-acx-overlay-container"]/div[6]/material-dialog/focus-trap/div[2]/div/main/update-part/form/table/tr[3]/td[2]/material-input/div[1]/div[1]/label/input  r
    # Click Order Num Input
    Click  xpath  //*[@id="default-acx-overlay-container"]/div[6]/material-dialog/focus-trap/div[2]/div/main/update-part/form/table/tr[4]/td[2]/material-input/div[1]/div[1]/label/input
    # Click on variable input to be added
    Enter Text  xpath  //*[@id="default-acx-overlay-container"]/div[6]/material-dialog/focus-trap/div[2]/div/main/update-part/form/table/tr[4]/td[2]/material-input/div[1]/div[1]/label/input  23
    # Click GSTIN Input
    Click  xpath  //*[@id="default-acx-overlay-container"]/div[6]/material-dialog/focus-trap/div[2]/div/main/update-part/form/table/tr[5]/td[2]/material-input/div[1]/div[1]/label/input
#    # Click on variable input to be added
#    Enter Text  xpath  //*[@id="default-acx-overlay-container"]/div[6]/material-dialog/focus-trap/div[2]/div/main/update-part/form/table/tr[5]/td[2]/material-input/div[1]/div[1]/label/input  GTIN

    # Click "Save" button
    Click  xpath  //*[@id="default-acx-overlay-container"]/div[6]/material-dialog/focus-trap/div[2]/div/main/update-part/form/div/material-button/material-ripple

    Sleep  5
    #Close the Browser being used for test.
    Close Browser


AT_ADM_05
#Test case to create laboratory organization

    #Open Browser and navigate to the desired URL
    Navigate To And Verify  ${BROWSER}  ${DASHBOARD_URL}/#/site/login  Qvin
    #Click username
    Click  css  input[type='text']
    #Enter username
    Enter Text  css  input[type='text']  _admin@qvin.com
    #Click password
    Click  css  input[type='password']
    #Enter password
    Enter Text  css  input[type='password']  secret
    #Click Login button
    Click  id  login_btn_signin
    #Click 2facode input text
    Click  id  login_input_2facode
    # Enter 2FA code
    Enter Text  xpath  //*[@id="login_input_2facode"]/div[1]/div[1]/label/input  123
    #Click Login button
    Click  id  login_btn_signin
    # Click Orgsnisation from left list item in Admin dashboard.
    Click  xpath   /html/body/app/admin/material-drawer/material-list/div/material-list-item[3]
    # Click on create new organization
    Click  xpath  /html/body/app/admin/div/div/organizations/section[2]/div[2]/material-button/material-ripple
    #Click and enter on name input
    Click  xpath  //*[@id="org_name_input"]/div/div[1]/label/input
    Enter Text  xpath  //*[@id="org_name_input"]/div/div[1]/label/input   MergeLabOrg
    #Click and select lab on dropdown to select organisation type
    Click  xpath  //*[@id="org_type_select_dropdown"]/dropdown-button
    Click  xpath  //material-select-item[contains(.,'Laboratory')]
    #Click  and slelect lab loaction form dropdown
    Click  xpath  //*[@id="dendi_lab_select_dropdown"]/dropdown-button
    Click  xpath  //material-select-item[contains(.,'Qvin Labs - Merge')]
    #Click  and slelect lab account from dropdown
    Click  xpath  //*[@id="dendi_account_select_dropdown"]/dropdown-button
    Click  xpath  //material-select-item[contains(.,'CLIA (Qvin) - Merge')]
    #Click  and slelect lab provider from dropdown
    Click  xpath  //*[@id="dendi_provider_select_dropdown"]/dropdown-button
    Click  xpath  //material-select-item[contains(.,'Jennifer Frangos - Merge')]
    #Click  and enter address
    Click  xpath  //*[@id="org_address_input"]/form/div[1]/material-input/div[1]/div[1]/label/input
    Enter Text  xpath  //*[@id="org_address_input"]/form/div[1]/material-input/div[1]/div[1]/label/input  255 Warren Street
    #Click  and enter address
    Click  xpath  //*[@id="org_address_input"]/form/div[3]/material-input/div[1]/div[1]/label/input
    Enter Text  xpath  //*[@id="org_address_input"]/form/div[3]/material-input/div[1]/div[1]/label/input  Jersey City
    #Click  and enter address
    Click  xpath  //*[@id="org_address_input"]/form/div[4]/material-input/div[1]/div[1]/label/input
    Enter Text  xpath  //*[@id="org_address_input"]/form/div[4]/material-input/div[1]/div[1]/label/input   07302
    #Click  and select country from dropdown
    Click  xpath  //*[@id="org_address_input"]/form/div[5]/material-dropdown-select/dropdown-button
    Click  xpath  //material-select-item[contains(.,'United States')]
    #Click  and select state from dropdown
    Click  xpath  //*[@id="org_address_input"]/form/div[6]/material-dropdown-select/dropdown-button
    Click  xpath  //material-select-item[contains(.,'New Jersey')]

    Click  xpath  //*[@id="org_save_button"]



