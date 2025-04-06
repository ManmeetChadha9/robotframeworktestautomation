*** Settings ***
Documentation  This is a test suite for Qurasense GUI Testing
Resource  ../data/global_variables.robot
Resource    ../resources/page_actions.robot
Resource    ../resources/custom_actions.robot
*** Variables ***

*** Test Cases ***

ROBOT_TS_01
    #Generate  token for admin user
    Create Admin Authentication Endpoint  _admin@qvin.com  secret  123  EMAIL
    # get wizard id from admin dashboard
    ${wizard_id}=   Get Wizard ID    ${APP_VERSION}  ${TEST_ENV}     SignUpA1CTrial
    #Open Browser and navigate to the desired URL
    Navigate To  ${BROWSER}  ${TEST_ENV}/#/site/wizard/${wizard_id}
    #Clicks the button for 'Sign Up'
    #Click  xpath  /html/body/app/site/div/home/section0/section/article/div[1]/button[1]
    #Clicks the button for 'Do not have an account'
    #Click  xpath  /html/body/app/site/div/check_account/section/form/material-button[2]/material-ripple
    #Verifies the existence of page asking about regular periods
    Verify  Do you have your period regularly?
    #Click button YES to confirm regular periods
    Click  xpath  //button[contains(.,'Yes')]
    #Verifies the existence of page asking about diabetes
    Verify  Do you have diabetes?
    #Click button YES to confirm diabetes
    Click  xpath  //button[contains(.,'Yes')]
    #Verifies the existence of Congratulations page
    Verify  Congratulations
    #Clicks on NEXT button to continue user registration
    Click  xpath  //button[contains(.,'Next')]
    #Verifies the existence of Type of Diabetes page.
    Verify  Which type of diabetes do you have?
    #Check the checkbox for Type 2 diabetes
    Check Checkbox  id  wizard_diabetes_chktype2
    #Click Next button after providing diabetes type
    Click  xpath  //button[contains(.,'Next')]
    #Verify the existence of A1C results page.
    Verify  A1C
    #Click on the input field for A1C result.
    Click  xpath  //*[@id="wizard_a1c_value"]/div[1]/div[1]/label/input
    #Input the value of last A1C assay result
    Enter Text  xpath  //*[@id="wizard_a1c_value"]/div[1]/div[1]/label/input  23
    #Click for selecting months, before which a1c test was done.
    Click  id  wizard_a1c_months
    #Select months before which a1c test was conducted.
    Select From List  id  wizard_a1c_months  6
    #Click for selecting years, before which a1c test was done.
    Click  id  wizard_a1c_years
    #Select years before which a1c test was conducted.
    Select From List  id  wizard_a1c_years  0
    #Clicks the Next Button after providing A1C details
    Click  xpath  //button[contains(.,'Next')]
    #Verifies the text 'What is your weight?', on the page.
    Verify  What is your weight?
    #Click the input_text field for weight.
    Click  xpath  //*[@id="wizard_weight_value"]/div/label/input
    #Enter the input value for weight.
    Enter Text  xpath  //*[@id="wizard_weight_value"]/div/label/input  123
    #Click the input_text field for weight.
    Click  xpath  //*[@id="wizard_weight_value"]/div/label/input
    #Clicks the Next Button after providing weight details
    Click  xpath  //button[contains(.,'Next')]
    #Verify the page for first day of last period
    Verify  First day of your most recent period
    #Clicks the Next Button after providing last period details
    Click  xpath  //button[contains(.,'Next')]
    #Verifies the existence of text 'Typical length of period' on the page.
    Verify  Typical length of period
    #Click the number picker and increment the length of period
    Click  css  .number-picker-increment
    #Clicks an element
    Click  xpath  //button[contains(.,'Next')]
    #Verifies the existence of text 'Typical length of cycle' on the page.
    Verify  Typical length of cycle
    #Click the number picker and decrement the length of cycle
    Click  css  .number-picker-decrement
    #Clicks the Next Button after providing typical cycle details
    Click  xpath  //button[contains(.,'Next')]
    #Verify the DOB screen
    Verify  When is your birthday?
    #Click on the text box to enter DOB
    Click  xpath  //input[@type='text']
    #Enter the input value for DOB
    Enter Text  xpath  //input[@type='text']  12012000
    #Clicks the Next Button after providing DOB.
    Click  xpath  //button[contains(.,'Next')]
    #Verify the page for providing full name
    Verify  Please enter your full name
    #Enter the input value for user's first name.
    Enter Text  xpath  //*[@id="wizard_name_first"]/div[1]/div[1]/label/input  _TestCustomer1_FirstName
    #Enter the input value for user's last name.
    Enter Text  xpath  //*[@id="wizard_name_last"]/div[1]/div[1]/label/input  _TestCustomer1_LastName
    #Clicks the Next Button after providing user name.
    Click  xpath  //button[contains(.,'Next')]
    #Click on the input text field for user street address
    Click  xpath  //*[@id="wizard_address_street"]/div[1]/div[1]/label/input
    #Enter the input value for user's street address
    Enter Text  xpath  //*[@id="wizard_address_street"]/div[1]/div[1]/label/input  255, Warren Street
    #Click on the input text field for user's city
    Click  xpath  //*[@id="wizard_address_city"]/div[1]/div[1]/label/input
    #Enter the input value for user's city
    Enter Text  xpath  //*[@id="wizard_address_city"]/div[1]/div[1]/label/input  Jersey City
    #Click on the input text field for user's zipcode
    Click  xpath  //*[@id="wizard_address_zipcode"]/div[1]/div[1]/label/input
    #Enter the input value for user's zipcode
    Enter Text  xpath  //*[@id="wizard_address_zipcode"]/div[1]/div[1]/label/input  07302
    #Click on Select list for country
    Click  id  wizard_address_country
    #Select the desired country
    Click  xpath  //material-select-dropdown-item[contains(.,'United States')]
    #Click on Select list for state
    Click  id  wizard_address_state
    #Select the desired state
    Click  xpath  //material-select-dropdown-item[contains(.,'New Jersey')]
    #Click on NEXT button after providing address details
    Click  xpath  //button[contains(.,'Next')]
    #Verify the existence of page for Phone Number
    Verify  Phone number
    #clicking on dropdown country select
    Click  xpath  //*[@id="phone_code_select"]
    #selecting country from dropdown
    Click  xpath  //material-select-dropdown-item[contains(.,'United States')]
    #Enter the input value for phone number
    Enter Text  xpath  //*[@id="wizard_phone_number"]/material-input/div/div[1]/label/input   8588588588
    #click send verification code
    Click  xpath   //*[@id="common_btn_sendcodeinput"]
    #entering verification code
    Enter Text  xpath  //*[@id="wizard_phone_verification_code"]/div[1]/div[1]/label/input   123
    #Click on NEXT button after providing phone number
    Click  xpath  //button[contains(.,'Next')]
    #Verify the existence of email page
    Verify  E-mail
    #Enter the valid input value for email
    Enter Text  xpath  //*[@id="wizard_email"]/div[1]/div[1]/label/input  _TestCustomer1@gmail.com
    #Click on NEXT button after providing email
    Click  xpath  //button[contains(.,'Next')]
    #Verify the existence of password page
    Verify  Choose a password
    #Enter the valid input value for password
    Enter Text  xpath  //*[@id="wizard_password"]/div[1]/div[1]/label/input  Password@1234
    #Confirm the valid input value for password
    Enter Text  xpath  //*[@id="wizard_confirm_password"]/div[1]/div[1]/label/input  Password@1234
    #Click on NEXT button after providing password
    Click  xpath  //button[contains(.,'Next')]
    #Verify the existence of Consent Page
    Verify  You need to read and agree to the following consents
    #Check the checkbox for first consent
    Check Checkbox  xpath  /html/body/app/site/div/wizard/div/div[1]/step-component/consent-step-component/section/div/span[1]/material-checkbox/div[1]/material-ripple
    #Check the checkbox for second consent
    Check Checkbox  xpath  /html/body/app/site/div/wizard/div/div[1]/step-component/consent-step-component/section/div/span[2]/material-checkbox/div[1]/material-ripple
    #Check the checkbox for third consent
    Check Checkbox  xpath  /html/body/app/site/div/wizard/div/div[1]/step-component/consent-step-component/section/div/span[3]/material-checkbox/div[1]/material-ripple
    #Click the NEXT button after providing all consents
    Click  xpath  //button[contains(.,'Next')]
    #Wait for some time for screen to come up
    Sleep  2
    #Verify the page for booking a phone call
    Verify  Book a phone call!
    #Click the DONE button on the 'Book a phone call' page
    Click  xpath  //button[contains(.,'Done')]
    #Close the Browser being used for test.
    Close Browser

ROBOT_TS_02
     #Generate  token for admin user
    Create Admin Authentication Endpoint  _admin@qvin.com  secret  123  EMAIL
    # get wizard id from admin dashboard
    ${wizard_id}=   Get Wizard ID    ${APP_VERSION}  ${TEST_ENV}     SignUpA1CTrial
    #${wizard_value}=    c259a04d-8fdb-4a22-9e04-1f0f36860bb2
    #Open Browser and navigate to the desired URL
    Navigate To  ${BROWSER}  ${TEST_ENV}/#/site/wizard/${wizard_id}
    #Clicks the button for 'Sign Up'
    #Click  xpath  /html/body/app/site/div/home/section0/section/article/div[1]/button[1]
    #Clicks the button for 'Do not have an account'
    #Click  xpath  /html/body/app/site/div/check_account/section/form/material-button[2]/material-ripple
    #Verifies the existence of page asking about regular periods
    Verify  Do you have your period regularly?
    #Click button YES to confirm regular periods
    Click  xpath  //button[contains(.,'Yes')]
    #Verifies the existence of page asking about diabetes
    Verify  Do you have diabetes?
    #Click button YES to confirm diabetes
    Click  xpath  //button[contains(.,'Yes')]
    #Verifies the existence of Congratulations page
    Verify  Congratulations
    #Clicks on NEXT button to continue user registration
    Click  xpath  //button[contains(.,'Next')]
    #Verifies the existence of Type of Diabetes page.
    Verify  Which type of diabetes do you have?
    #Check the checkbox for Type 1 diabetes
    Check Checkbox  id  wizard_diabetes_chktype1
    #Check the checkbox for Type 2 diabetes
    Check Checkbox  id  wizard_diabetes_chktype2
    #Click Next button after providing diabetes type
    Click  xpath  //button[contains(.,'Next')]
    #Verify the existence of A1C results page.
    Verify  A1C
    #Click on the input field for A1C result.
    Click  xpath  //*[@id="wizard_a1c_value"]/div[1]/div[1]/label/input
    #Input the value of last A1C assay result
    Enter Text  xpath  //*[@id="wizard_a1c_value"]/div[1]/div[1]/label/input  1123
    #Click for selecting months, before which a1c test was done.
    Click  id  wizard_a1c_months
    #Select months before which a1c test was conducted.
    Select From List  id  wizard_a1c_months  10
    #Click for selecting years, before which a1c test was done.
    Click  id  wizard_a1c_years
    #Select years before which a1c test was conducted.
    Select From List  id  wizard_a1c_years  5
    #Clicks the Next Button after providing A1C details
    Click  xpath  //button[contains(.,'Next')]
    #Verify the message if invalid % of A1C value provided
    Verify  Value must be in interval 0% - 100%
    #Click the input_text field for weight.
    Click  xpath  //*[@id="wizard_a1c_value"]/div[1]/div[1]/label/input
    #Enter the input value for weight.
    Enter Text  xpath  //*[@id="wizard_a1c_value"]/div[1]/div[1]/label/input  34
    #Click the input_text field for weight.
    Click  xpath  //button[contains(.,'Next')]
    #Verifies the text 'What is your weight?', on the page.
    Verify  What is your weight?
    #Click the input_text field for weight.
    Click  xpath  //*[@id="wizard_weight_value"]/div/label/input
    #Enter the input value for weight.
    Enter Text  xpath  //*[@id="wizard_weight_value"]/div/label/input  123234
    #Clicks the Next Button after providing weight details
    Click  xpath  //button[contains(.,'Next')]
    #Verify the message if invalid weight value provided
    Verify  Invalid value provided. Value must be bigger than 50 lbs and smaller than 600 lbs
    #Click the input_text field for weight.
    Click  xpath  //*[@id="wizard_weight_value"]/div/label/input
    #Enter the input value for weight.
    Enter Text  xpath  //*[@id="wizard_weight_value"]/div/label/input  145
    #Clicks the Next Button after providing weight details
    Click  xpath  //button[contains(.,'Next')]
    #Verify the page for first day of last period
    Verify  First day of your most recent period
    #Clicks the Next Button after providing last period details
    Click  xpath  //button[contains(.,'Next')]
    #Verifies the existence of text 'Typical length of period' on the page.
    Verify  Typical length of period
    #Click the number picker and decrement the length of period
    Click  css  .number-picker-decrement
    #Clicks the Next Button after providing typical period details
    Click  xpath  //button[contains(.,'Next')]
    #Verifies the existence of text 'Typical length of cycle' on the page.
    Verify  Typical length of cycle
    #Click the number picker and increment the length of cycle
    Click  css  .number-picker-increment
    #Clicks the Next Button after providing typical cycle details
    Click  xpath  //button[contains(.,'Next')]
    #Verify the DOB screen
    Verify  When is your birthday?
    #Enter the input value for DOB
    Enter Text  xpath  //input[@type='text']  12012009
    #Clicks the Next Button after providing DOB.
    Click  xpath  //button[contains(.,'Next')]
    #Verify the message if invalid DOB value provided
    Verify  Sorry, you have to be between 18 and 60 years old
    #Enter the input value for DOB
    Enter Text  xpath  //input[@type='text']  12012000
    #Clicks the Next Button after providing DOB.
    Click  xpath  //button[contains(.,'Next')]
    #Verify the page for providing full name
    Verify  Please enter your full name
    #Enter the input value for user's first name.
    Enter Text  xpath  //*[@id="wizard_name_first"]/div[1]/div[1]/label/input  _TestCustomer2_FirstName
    #Enter the input value for user's last name.
    Enter Text  xpath  //*[@id="wizard_name_last"]/div[1]/div[1]/label/input  _TestCustomer2_LastName
    #Clicks the Next Button after providing user name.
    Click  xpath  //button[contains(.,'Next')]
    #Click on the input text field for user street address
    Click  xpath  //*[@id="wizard_address_street"]/div[1]/div[1]/label/input
    #Enter the input value for user's street address
    Enter Text  xpath  //*[@id="wizard_address_street"]/div[1]/div[1]/label/input  115, 16th Street
    #Click on the input text field for user's city
    Click  xpath  //*[@id="wizard_address_city"]/div[1]/div[1]/label/input
    #Enter the input value for user's city
    Enter Text  xpath  //*[@id="wizard_address_city"]/div[1]/div[1]/label/input  _TestCustomer2_City
    #Click on the input text field for user's zipcode
    Click  xpath  //*[@id="wizard_address_zipcode"]/div[1]/div[1]/label/input
    #Enter the input value for user's zipcode
    Enter Text  xpath  //*[@id="wizard_address_zipcode"]/div[1]/div[1]/label/input  AAAASSSSDDDDFFFFHHHH778900123456789
    #Click on Select list for country
    Click  xpath  //span[contains(.,'Select country')]
    #Select the desired country
    Click  xpath  //material-select-dropdown-item[contains(.,'Indonesia')]
    #Click on NEXT button after providing address details
    Click  xpath  //button[contains(.,'Next')]
    #Verify the existence of page for Phone Number
    Verify  Phone number
    #clicking on dropdown country select
    Click  xpath  //*[@id="phone_code_select"]
    #selecting country from dropdown
    Click  xpath  //material-select-dropdown-item[contains(.,'Indonesia')]
    #Enter the input value for phone number
    Enter Text  xpath  //*[@id="wizard_phone_number"]/material-input/div/div[1]/label/input   8888888888
    #click send verification code
    Click  xpath   //*[@id="common_btn_sendcodeinput"]
    #entering verification code
    Enter Text  xpath  //*[@id="wizard_phone_verification_code"]/div[1]/div[1]/label/input   123
    #Click on NEXT button after providing phone number
    Click  xpath  //button[contains(.,'Next')]
    #Verify the existence of email page
    Verify  E-mail
    #Enter the in-valid input value for email
    Enter Text  xpath  //*[@id="wizard_email"]/div[1]/div[1]/label/input  _TestCustomer2_gmail.com
    #Click on NEXT button after providing email
    Click  xpath  //button[contains(.,'Next')]
    #Verify the message to handle bad email
    Verify  Bad email format
    #Enter the valid input value for email
    Enter Text  xpath  //input[@type='text']  _TestCustomer2@gmail.com
    #Click on NEXT button after providing email
    Click  xpath  //button[contains(.,'Next')]
    #Verify the existence of password page
    Verify  Choose a password
    #Enter the valid input value for password
    Enter Text  xpath  //*[@id="wizard_password"]/div[1]/div[1]/label/input  Password@1234
    #Confirm the valid input value for password
    Enter Text  xpath  //*[@id="wizard_confirm_password"]/div[1]/div[1]/label/input  Password@1234
    #Click on NEXT button after providing password
    Click  xpath  //button[contains(.,'Next')]
    #Verify the existence of Consent Page
    Verify  You need to read and agree to the following consents
    #Check the checkbox for first consent
    Check Checkbox  xpath  /html/body/app/site/div/wizard/div/div[1]/step-component/consent-step-component/section/div/span[1]/material-checkbox/div[1]/material-ripple
    #Check the checkbox for second consent
    Check Checkbox  xpath  /html/body/app/site/div/wizard/div/div[1]/step-component/consent-step-component/section/div/span[2]/material-checkbox/div[1]/material-ripple
    #Check the checkbox for third consent
    Check Checkbox  xpath  /html/body/app/site/div/wizard/div/div[1]/step-component/consent-step-component/section/div/span[3]/material-checkbox/div[1]/material-ripple
    #Click the NEXT button after providing all consents
    Click  xpath  //button[contains(.,'Next')]
    #Wait for some time for screen to come up
    Sleep  2
    #Verify the page for booking a phone call
    Verify  Book a phone call!
    #Click the DONE button on the 'Book a phone call' page
    Click  xpath  //button[contains(.,'Done')]
    #Close the Browser being used for test.
    Close Browser

ROBOT_TS_03
    #Generate  token for admin user
    Create Admin Authentication Endpoint  _admin@qvin.com  secret  123  EMAIL
    # get wizard id from admin dashboard
    ${wizard_id}=   Get Wizard ID    ${APP_VERSION}  ${TEST_ENV}     SignUpA1CTrial
    #Open Browser and navigate to the desired URL
    #Navigate To And Verify  ${BROWSER}  ${TEST_ENV}  Join our study to improve the quality of life for women with Diabetes!
    Navigate To  ${BROWSER}  ${TEST_ENV}/#/site/login
    #Click login link
    #Click  link  Login
    #Click on username field
    Click  css  input[type='text']
    #Enter wrong username
    Enter Text  css  input[type='text']  wrong@qvin.com
    #Click
    Click  id  login_btn_signin
    #Click  xpath  /html/body/app/site/div/login/section/form/material-button
    #Verify the page for password required
    Verify  Password is required!
    #Close the Browser being used for test.
    Close Browser
    #Open Browser and navigate to the desired URL
    #Navigate To And Verify  ${BROWSER}  ${TEST_ENV}  Join our study to improve the quality of life for women with Diabetes!
    Navigate To  ${BROWSER}  ${TEST_ENV}/#/site/login
    #Click login link
    #Click  link  Login
    #Click on password field
    Click  css  input[type='password']
    #Enter wrong passowd
    Enter Text  css  input[type='password']  wrong
    #Click
    Click  id  login_btn_signin
    #Click  xpath  /html/body/app/site/div/login/section/form/material-button
    #Verify the page for password required
    Verify  Username or email is required!
    #Close the Browser being used for test.
    Close Browser
    #Open Browser and navigate to the desired URL
    Navigate To  ${BROWSER}  ${TEST_ENV}/#/site/login
    #Navigate To And Verify  ${BROWSER}  ${TEST_ENV}  Join our study to improve the quality of life for women with Diabetes!
    #Click login link
    #Click  link  Login
    #Click on username field
    Click  css  input[type='text']
    #Enter wrong username
    Enter Text  css  input[type='text']  wrong@qvin.com
    #Click on password field
    Click  css  input[type='password']
    #Enter wrong passowd
    Enter Text  css  input[type='password']  wrong
    #Click
    Click  id  login_btn_signin
    #Click  xpath  /html/body/app/site/div/login/section/form/material-button
    #Verify the page for password required
    Verify  Could not find user with email
    #Close the Browser being used for test.
    Close Browser
    #Open Browser and navigate to the desired URL
    Navigate To  ${BROWSER}  ${TEST_ENV}/#/site/wizard/${wizard_id}
#    Navigate To And Verify  ${BROWSER}  ${TEST_ENV}  Join our study to improve the quality of life for women with Diabetes!
#    #Clicks the button for 'Sign Up'
#    Click  xpath  /html/body/app/site/div/home/section0/section/article/div[1]/button[1]
#    #Clicks the button for 'Do not have an account'
    #Click  xpath  /html/body/app/site/div/check_account/section/form/material-button[2]/material-ripple
    #Verifies the existence of page asking about regular periods
    Verify  Do you have your period regularly?
    #Click button YES to confirm regular periods
    Click  xpath  //button[contains(.,'Yes')]
    #Verifies the existence of page asking about diabetes
    Verify  Do you have diabetes?
    #Click button YES to confirm diabetes
    Click  xpath  //button[contains(.,'Yes')]
    #Verifies the existence of Congratulations page
    Verify  Congratulations
    #Clicks on NEXT button to continue user registration
    Click  xpath  //button[contains(.,'Next')]
    #Verifies the existence of Type of Diabetes page.
    Verify  Which type of diabetes do you have?
    #Check the checkbox for Type 1 diabetes
    Check Checkbox  id  wizard_diabetes_chktype1
    #UnCheck the checkbox for Type 1 diabetes
    Check Checkbox  id  wizard_diabetes_chktype1
    #Click Next button after providing diabetes type
    Click  xpath  //button[contains(.,'Next')]
    #Verify the existence of error
    Verify  You should choose at least one option!
    #Check the checkbox for Type 1 diabetes
    Check Checkbox  id  wizard_diabetes_chktype1
    #Click Next button after providing diabetes type
    Click  xpath  //button[contains(.,'Next')]
    #Click Next button after providing diabetes type
    Click  xpath  //button[contains(.,'Next')]
    #Verify the existence of error
    Verify  You must input a value
    #Click on the input field for A1C result.
    Click  xpath  //*[@id="wizard_a1c_value"]/div[1]/div[1]/label/input
    #Input the value of last A1C assay result
    Enter Text  xpath  //*[@id="wizard_a1c_value"]/div[1]/div[1]/label/input  -8
    #Click Next button after providing A1C number
    Click  xpath  //button[contains(.,'Next')]
    #Verify the existence of error
    Verify  Value must be in interval 0% - 100%
    #Click on the input field for A1C result.
    Click  xpath  //*[@id="wizard_a1c_value"]/div[1]/div[1]/label/input
    #Input the value of last A1C assay result
    Enter Text  xpath  //*[@id="wizard_a1c_value"]/div[1]/div[1]/label/input  110
    #Click Next button after providing A1C number
    Click  xpath  //button[contains(.,'Next')]
    #Verify the existence of error
    Verify  Value must be in interval 0% - 100%
    #Click on the input field for A1C result.
    Click  xpath  //*[@id="wizard_a1c_value"]/div[1]/div[1]/label/input
    #Input the value of last A1C assay result
    Enter Text  xpath  //*[@id="wizard_a1c_value"]/div[1]/div[1]/label/input  test
    #Click Next button after providing A1C number
    Click  xpath  //button[contains(.,'Next')]
    #Verify the existence of error
    Verify  You must input a number
    #Click on the input field for A1C result.
    Click  xpath  //*[@id="wizard_a1c_value"]/div[1]/div[1]/label/input
    #Input the value of last A1C assay result
    Enter Text  xpath  //*[@id="wizard_a1c_value"]/div[1]/div[1]/label/input  70
    #Click Next button after providing A1C number
    Click  xpath  //button[contains(.,'Next')]
    #Verifies the text 'What is your weight?', on the page.
    Verify  What is your weight?
    #Click the input_text field for weight.
    Click  xpath  //*[@id="wizard_weight_value"]/div/label/input
    #Clicks the Next Button after providing weight details
    Click  xpath  //button[contains(.,'Next')]
    #Verify the existence of error
    Verify  You must input a value
    #Click the input_text field for weight.
    Click  xpath  //*[@id="wizard_weight_value"]/div/label/input
    #Enter the input value for weight.
    Enter Text  xpath  //*[@id="wizard_weight_value"]/div/label/input  5
    #Clicks the Next Button after providing weight details
    Click  xpath  //button[contains(.,'Next')]
    #Verify the existence of error
    Verify  Invalid value provided. Value must be bigger than 50 lbs and smaller than 600 lbs
    #Click for selecting years, before which a1c test was done.
    Click  id  wizard_weight_unit
    #Select years before which a1c test was conducted.
    Select From List  id  wizard_weight_unit  kg
    #Clicks the Next Button after providing weight details
    Click  xpath  //button[contains(.,'Next')]
    #Verify the existence of error
    Verify  Invalid value provided. Value must be bigger than 25 kg and smaller than 300 kg
    #Click the input_text field for weight.
    Click  xpath  //*[@id="wizard_weight_value"]/div/label/input
    #Enter the input value for weight.
    Enter Text  xpath  //*[@id="wizard_weight_value"]/div/label/input  50
    #Clicks the Next Button
    Click  xpath  //button[contains(.,'Next')]
    #Verify the page for first day of last period
    Verify  First day of your most recent period
    #Add and verify an invalid date value
    Click  xpath  //*[@id="wizard_cycle_startdate"]/div/div/label/input
    Send Keys  None  CTRL+a
    Send Keys  None  DELETE
    Enter Text  xpath  //*[@id="wizard_cycle_startdate"]/div/div/label/input  23452222
    Click  xpath  //button[contains(.,'Next')]
    Verify  Health value needs to have a date
    #Add and verify a date value before 50 days from today
    Click  xpath  //*[@id="wizard_cycle_startdate"]/div/div/label/input
    Send Keys  None  CTRL+a
    Send Keys  None  DELETE
    Enter Text  xpath  //*[@id="wizard_cycle_startdate"]/div/div/label/input  11152000
    Click  xpath  //button[contains(.,'Next')]
    Verify  Blood flow date can't be erlier than 50 days from today
    #Add and verify a date value before today
    Click  xpath  //*[@id="wizard_cycle_startdate"]/div/div/label/input
    Send Keys  None  CTRL+a
    Send Keys  None  DELETE
    Enter Calculated Date  xpath  //*[@id="wizard_cycle_startdate"]/div/div/label/input  -29
    Click  xpath  //button[contains(.,'Next')]
    #Clicks the Next Button
    Click  xpath  //button[contains(.,'Next')]
    #Clicks the Next Button
    Click  xpath  //button[contains(.,'Next')]
    #Clicks the Next Button
    Click  xpath  //button[contains(.,'Next')]
    #Enter the input value for DOB
    Enter Text  xpath  //input[@type='text']  12012010
    #Clicks the Next Button after providing DOB.
    Click  xpath  //button[contains(.,'Next')]
    #Verify the message if invalid DOB value provided
    Verify  Sorry, you have to be between 18 and 60 years old
    #Enter the input value for DOB
    Enter Text  xpath  //input[@type='text']  12012000
    #Clicks the Next Button after providing DOB.
    Click  xpath  //button[contains(.,'Next')]
    #Clicks the Next Button after providing correct DOB.
    Click  xpath  //button[contains(.,'Next')]
    #Verify the message if invalid DOB value provided
    Verify  Please write your first name
    #Enter the input value for user's first name.
    Enter Text  xpath  //*[@id="wizard_name_first"]/div[1]/div[1]/label/input  first
    #Clicks the Next Button after giving only first name
    Click  xpath  //button[contains(.,'Next')]
    #Verify the message if invalid DOB value provided
    Verify  Please write your last name
    #Enter the input value for user's last name.
    Enter Text  xpath  //*[@id="wizard_name_last"]/div[1]/div[1]/label/input  last
    #Clicks the Next Button
    Click  xpath  //button[contains(.,'Next')]
    #Clicks the Next Button
    Click  xpath  //button[contains(.,'Next')]
    #Verify the message if no Shipping address is provided
    Verify  Street field is required
    #Enter the input value for user's street address
    Enter Text  xpath  //*[@id="wizard_address_street"]/div[1]/div[1]/label/input  4615 Spenard Rd
    #Clicks the Next Button
    Click  xpath  //button[contains(.,'Next')]
    #Verify the message if no city is provider
    Verify  City field is required
    #Enter the input value for user's city
    Enter Text  xpath  //*[@id="wizard_address_city"]/div[1]/div[1]/label/input  Anchorage
    #Clicks the Next Button
    Click  xpath  //button[contains(.,'Next')]
    #Verify the message if no zipcode is provider
    Verify  Zip field is required
    #Enter the input value for user's zipcode
    Enter Text  xpath  //*[@id="wizard_address_zipcode"]/div[1]/div[1]/label/input  99501
    #Clicks the Next Button
    Click  xpath  //button[contains(.,'Next')]
    #Verify the message if no country is provider
    Verify  Country field is required
    #Click on Select list for country
    Click  xpath  //span[contains(.,'Select country')]
    #Select the desired country
    Click  xpath  //material-select-dropdown-item[contains(.,'United States')]
    #Clicks the Next Button
    Click  xpath  //button[contains(.,'Next')]
    #Verify the message if no state is provider
    Verify  State field is required
    #Click on Select list for state
    Click  xpath  //span[contains(.,'Select state')]
    #Select the desired state
    Click  xpath  //material-select-dropdown-item[contains(.,'Alaska')]
    #Click on NEXT button after providing address details
    Click  xpath  //button[contains(.,'Next')]
    #Clicks the Next Button
    Click  xpath  //button[contains(.,'Next')]
    #Verify the message if no phone is provider
    Verify  You must input a value
    #Enter the input value for phone number
    Enter Text  xpath  //*[@id="wizard_phone_number"]/material-input/div/div[1]/label/input  333
    #Clicks the Next Button
    Click  xpath  //button[contains(.,'Next')]
    #Verify the message if wrong phone is provider
    Verify  Phone number must be between 8 and 15 digits.
    #clicking on dropdown country select
    Click  xpath  //*[@id="phone_code_select"]
    #selecting country from dropdown
    Click  xpath  //material-select-dropdown-item[contains(.,'United States')]
    #Enter the input value for phone number
    Enter Text  xpath  //*[@id="wizard_phone_number"]/material-input/div/div[1]/label/input   7888888888
#    #click send verification code
#    #Verify the message if wrong phone is provider
#    Verify  Phone number must be between 8 and 15 digits.
#    #Enter the input value for phone number
#    Enter Text  xpath  //*[@id="wizard_phone_number"]/div/label/input  7888888888
#    #Clicks the Next Button
#    Click  xpath  //button[contains(.,'Next')]
#    #verify the message for missing country code
#    Verify  Country code is missing.
#    #Enter the input value for phone number
#    Enter Text  xpath  //*[@id="wizard_phone_number"]/div/label/input  +917888888888
    #Clicks the Next Button
    Click  xpath  //button[contains(.,'Next')]
    #Verify the message if verification not done
    Verify  Failed to verify code. Try again
    #click send verification code
    Click  xpath   //*[@id="common_btn_sendcodeinput"]
    #entering verification code
    Enter Text  xpath  //*[@id="wizard_phone_verification_code"]/div[1]/div[1]/label/input   123
    #Click on NEXT button after providing phone number
    Click  xpath  //button[contains(.,'Next')]
    #Verify the existence of email page
    Verify  E-mail
    #Enter the in-valid input value for email
    Enter Text  xpath  //*[@id="wizard_email"]/div[1]/div[1]/label/input  test
    #Click on NEXT button after providing email
    Click  xpath  //button[contains(.,'Next')]
    #Verify the message to handle bad email
    Verify  Bad email format
    #Enter the valid input value for email
    Enter Text  xpath  //input[@type='text']  test@test.com
    #Click on NEXT button after providing email
    Click  xpath  //button[contains(.,'Next')]
    #Verify the existence of password page
    Verify  Choose a password
    #Click on NEXT button without providing password
    Click  xpath  //button[contains(.,'Next')]
    #Verify the message to check blank password
    Verify  Password is required
    #Enter the valid input value for password
    Enter Text  xpath  //*[@id="wizard_password"]/div[1]/div[1]/label/input  Test@pass
    #Click on NEXT button without providing reenter password
    Click  xpath  //button[contains(.,'Next')]
    #Verify the message to check blank password
    Verify  Password don't match
    #Enter the valid input value for password
    Enter Text  xpath  //*[@id="wizard_confirm_password"]/div[1]/div[1]/label/input  Test@pass
    #Close the Browser being used for test.
    Close Browser