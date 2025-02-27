*** Settings ***
Documentation  This is a test suite for Elevate Derm Registration
Resource  ../data/GlobalVariables.robot
Resource    ../resources/PageActions.robot
Resource    ../resources/CustomActions.robot
*** Variables ***


*** Test Cases ***


AT_ELEVATED_01
# Test case to setup 2fa as false
    #Open Browser and navigate to the desired URL
    Navigate To And Verify  ${BROWSER}  ${TEST_URL}  Welcome
    Sleep  5
    Click  xpath  /html/body/div[1]/div/div/div/div/section/div[2]/div/div/div/div/div/div[2]/i
    #Click Rapids Spring
    Click  xpath  //a[contains(.,'RAPIDS Registration')]
    Sleep  5
    #Verify text on page
    Verify Text In Locator  element  <span class="">Register Now</span>  Register Now
    #Click Register button
    Click  element <span class="">Register Now</span>

#    Enter Text  css  input[type='text']  _admin@qvin.com
#    #Click password
#    Click  css  input[type='password']
#    #Enter password
#    Enter Text  css  input[type='password']  secret
#    #Click Login button
#    Click  id  login_btn_signin
#    #Click 2facode input text
#    Click  id  login_input_2facode
#    # Enter 2FA code
#    Enter Text  xpath  //*[@id="login_input_2facode"]/div[1]/div[1]/label/input  123
#    #Click Login button
#    Click  id  login_btn_signin
#    # Click Variables from left list item in Admin dashboard.
#    Click  xpath  //*[@id="variables_list_item"]
#    #Search for the variable and click on the Actions menu item
#    Click Cell In Table  xpath  //*[@id="variables_smart_table"]/div/div/table  //*[@id="variables_menu_action"]/material-button  NotApplicable  2fa.enabled
#    # Click on Edit variable menu item
#    Click  xpath  //material-select-item[contains(.,'Edit variable')]
#    # Click on variable input to be edited
#    Click  xpath  //*[@id="input_variable_value"]/div[1]/div[1]/label/input
#    #Send keys Ctrl+a for selecting all text
#    Send Keys  None  CTRL+a
#    #Send keys DELETE for deleting all text
#    Send Keys  None  DELETE
#    #Send keys for adding time value
#    Send Keys  None  false
#    #Click SAVE button
#    Click  xpath  //*[@id="button_save"]/material-ripple
#    #Wait for some time for screen to come up
    Sleep  2
    #Close the Browser being used for test.
    Close Browser