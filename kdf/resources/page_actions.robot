*** Settings ***
Documentation  This layer is for creating web page specific keywords
Library  SeleniumLibrary
Library  ../libs/custom_selenium_library.py
Resource  custom_actions.robot

*** Variables ***

*** Keywords ***

Navigate To and Verify
    [Arguments]  ${Browser}  ${URL}  ${Verification_Text}
    Navigate To  ${Browser}  ${URL}
    #Wait for some time so that page could load
    Sleep  30
    set selenium timeout  20s
    wait until page contains  ${Verification_Text}


Navigate To
    [Arguments]  ${Browser}  ${URL}
    #Run Keyword If  '${Browser}' == 'headlesschrome' or '${Browser}' == 'headlessfirefox' Open Headless Browser
    #Run Keyword If '${color}' in ['Red', 'Blue', 'Pink'] Check the quantity
    Run Keyword If  '${Browser}' in ['headlesschrome', 'headlessfirefox']  Open Headless Browser  ${Browser}  ${URL}
    ...              ELSE  Open Browser  ${URL}  ${Browser}
    maximize browser window

Navigate To With Chrome Option And Desired Capabilities
    [Arguments]  ${Browser}  ${URL}
    #Run Keyword If  '${Browser}' == 'headlesschrome' or '${Browser}' == 'headlessfirefox' Open Headless Browser
    #Run Keyword If '${color}' in ['Red', 'Blue', 'Pink'] Check the quantity
    Run Keyword If  '${Browser}' in ['headlesschrome', 'headlessfirefox']  Open Headless Browser With Chrome Option And Desired Capabilities  ${Browser}  ${URL}
    ...              ELSE  Open Browser  ${URL}  ${Browser}
    maximize browser window

Get Browser Console Log Entries
    ${selenium}=    Get Library Instance    SeleniumLibrary
    ${webdriver}=    Set Variable     ${selenium._drivers.active_drivers}[0]
    ${log entries}=    Evaluate    $webdriver.get_log('browser')
   RETURN   ${log entries}


Open Headless Browser
    [Arguments]    ${Browser}  ${URL}
    Run Keyword If  '${Browser}' == 'headlesschrome'   Chrome Headless  ${Browser}  ${URL}
    Run Keyword If  '${Browser}' == 'headlessfirefox'  Firefox Headless
    #Go To  ${URL}

Open Headless Browser With Chrome Option And Desired Capabilities
    [Arguments]    ${Browser}  ${URL}
    Run Keyword If  '${Browser}' == 'headlesschrome'  Chrome Headless With Chrome Option And Desired Capabilities
    Run Keyword If  '${Browser}' == 'headlessfirefox'  Firefox Headless
    Go To  ${URL}

Chrome Headless
     [Arguments]    ${Browser}  ${URL}
    ${chrome_options}=    Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()    sys
    Call Method    ${chrome_options}    add_argument    test-type
    Call Method    ${chrome_options}    add_argument    --disable-extensions
    Call Method    ${chrome_options}    add_argument    --headless
    Call Method    ${chrome_options}    add_argument    --disable-gpu
    Call Method    ${chrome_options}    add_argument    --no-sandbox
    #Create Webdriver    Chrome    chrome_options=${chrome_options}
    open browser  ${URL}  browser=${Browser}  options=${chrome_options}


Chrome Headless With Chrome Option And Desired Capabilities
    ${prefs}       Create Dictionary
    ${browser logging capability}  Create Dictionary
    ${chrome_options}=    Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()    sys, selenium.webdriver
    ${chrome_capabilities_new}=    Evaluate    sys.modules['selenium.webdriver'].DesiredCapabilities.CHROME    sys, selenium.webdriver
    Call Method    ${chrome_options}    add_argument    test-type
    Call Method    ${chrome_options}    add_argument    --disable-extensions
    Call Method    ${chrome_options}    add_argument    --headless
    Call Method    ${chrome_options}    add_argument    --disable-gpu
    Call Method    ${chrome_options}    add_argument    --no-sandbox
    Call Method    ${chrome_options}    add_argument    --disable-dev-shm-usage
    Call Method    ${chrome_options}    add_experimental_option    prefs    ${prefs}
 #   ${chrome_options.binary_location}    Set Variable    /usr/bin/google-chrome-stable
 #   ${options}=     Call Method     ${chrome_options}    to_capabilities

    Set to Dictionary  ${browser logging capability}    browser=ALL
    Set To Dictionary    ${chrome_capabilities_new}  goog:loggingPrefs=${browser logging capability}
#    Set To Dictionary    ${chrome_capabilities_new}    ChromeOptions.CAPABILITY=${options}
#    Log  ${chrome_capabilities_new}
#    Create Webdriver    Chrome  desired_capabilities=${chrome_capabilities_new}
    Create Webdriver    Chrome  chrome_options=${chrome_options}  desired_capabilities=${chrome_capabilities_new}

Firefox Headless
  ${firefox options}=     Evaluate    sys.modules['selenium.webdriver'].firefox.webdriver.Options()    sys
  Call Method    ${firefox options}   add_argument    --headless
  Create Webdriver    Firefox    firefox_options=${firefox options}
  #Set Window Size    1920    1080


Enter Credential
    [Arguments]  @{CREDENTIALS}
    input text  id=inputEmail  ${Credentials}[0]
    input text  id=inputPassword  ${Credentials}[1]

Click and Verify
    [Arguments]  ${Locator_Type}  ${Locator_Value}  ${Verification_Text}
    set focus to element  ${Locator_Type}=${Locator_Value}
    click element  ${Locator_Type}=${Locator_Value}
    set selenium timeout  10s
    wait until page contains  ${Verification_Text}

Click
    [Arguments]  ${Locator_Type}  ${Locator_Value}
    set selenium timeout  10s
    Wait Until Page Contains Element  ${Locator_Type}=${Locator_Value}
    set focus to element  ${Locator_Type}=${Locator_Value}
    sleep  3s
    click element  ${Locator_Type}=${Locator_Value}

Verify
    [Arguments]  ${Verification_Text}
    set selenium timeout  30s
    wait until page contains  ${Verification_Text}

Verify Text Not Exists Anymore
    [Arguments]  ${Verification_Text}
    set selenium timeout  20s
    Wait Until Page Does Not Contain  ${Verification_Text}

Verify Text In Locator
    [Arguments]  ${Locator_Type}  ${Locator_Value}  ${Verification_Text}
    set selenium timeout  10s
    wait until element contains  ${Locator_Type}=${Locator_Value}  ${Verification_Text}

Check Checkbox
    [Arguments]  ${Locator_Type}  ${Locator_Value}
    set selenium timeout  10s
    Wait Until Page Contains Element  ${Locator_Type}=${Locator_Value}
    set focus to element  ${Locator_Type}=${Locator_Value}
    select checkbox  ${Locator_Type}=${Locator_Value}


Uncheck Checkbox
    [Arguments]  ${Locator_Type}  ${Locator_Value}
    set selenium timeout  10s
    Wait Until Page Contains Element  ${Locator_Type}=${Locator_Value}
    set focus to element  ${Locator_Type}=${Locator_Value}
    Unselect checkbox  ${Locator_Type}=${Locator_Value}

Enter Text
    [Arguments]   ${Locator_Type}  ${Locator_Value}  ${Text}
    sleep  2s
    set selenium timeout  10s
    Wait Until Page Contains Element  ${Locator_Type}=${Locator_Value}
    input text   ${Locator_Type}=${Locator_Value}  ${Text}
     #input password   ${Locator_Type}=${Locator_Value}  ${Text}

Enter Calculated Date
    [Arguments]   ${Locator_Type}  ${Locator_Value}  ${days}
    sleep  2s
    ${CalculatedDate}=  Add Days To Today  ${days}
    input text   ${Locator_Type}=${Locator_Value}  ${CalculatedDate}
     #input password   ${Locator_Type}=${Locator_Value}  ${Text}

Select From List
    [Arguments]   ${Locator_Type}  ${Locator_Value}  ${Text}
    sleep  3s
    Select From List By Value   ${Locator_Type}=${Locator_Value}  ${Text}

Send Keys
    [Arguments]  ${Locator_Value}  ${MyKeys}
    #press keys  ${MyKeys}
    Log  ${MyKeys}
    press keys  ${Locator_Value}  ${MyKeys}
    #Send KeyBoard Input  ${Locator_Type}  ${Locator_Value}  ${MyKeys}

GoTo Frame
    [Arguments]   ${Locator_Type}  ${Locator_Value}
    sleep  3s
    select frame  ${Locator_Value}


Add Days To Today
    [Arguments]  ${days}
    ${TodaysDate}=  Todays Date
    ${Date}=  Get Date After Adding Days  ${TodaysDate}  ${days}  %m.%d.%Y
   RETURN   ${Date}

Setup Call On
    [Arguments]  ${datetime}
    ${day}=  Get Day From Date  ${datetime}
    ${time}=  Get Time From Date  ${datetime}
    Click   xpath   //span[contains(.,'${day}')]
    sleep  3s
    Click   xpath   //span[contains(.,'${time}')]


Click Assign Dots
    [Arguments]  ${Locator_Type}  ${Table_Locator_Value}  ${Element_Locator_Value}  ${first_last_name}
    ${dotsLocatorValue}=  Get Table Column Row Locator   ${Locator_Type}  ${Table_Locator_Value}  ${Element_Locator_Value}  10  ${first_last_name}
    Click   ${Locator_Type}    ${dotsLocatorValue}

Click Cell In Table
    [Arguments]  ${Locator_Type}  ${Table_Locator_Value}  ${Element_Locator_Value}  ${col_num}  ${lookup_text1}  ${lookup_text2}=${None}
    set selenium timeout  10s
    Wait Until Page Contains  ${lookup_text1}
    ${clickableLocatorValue}=  Get Table Column Row Locator   ${Locator_Type}  ${Table_Locator_Value}  ${Element_Locator_Value}  ${col_num}  ${lookup_text1}  ${lookup_text2}
    Click   ${Locator_Type}    ${clickableLocatorValue}

Click Anchor Cell In Table
    [Arguments]  ${Locator_Type}  ${Table_Locator_Value}  ${Element_Locator_Value}  ${col_num}  ${lookup_text1}  ${lookup_text2}=${None}
    set selenium timeout  10s
    Wait Until Page Contains  ${lookup_text1}
    ${clickableLocatorValue}=  Get Table Column Row Locator   ${Locator_Type}  ${Table_Locator_Value}  ${Element_Locator_Value}  ${col_num}  ${lookup_text1}  ${lookup_text2}
    ${clickableLocatorValue}=  Catenate    SEPARATOR=/  ${clickableLocatorValue}  a
    Click   ${Locator_Type}    ${clickableLocatorValue}

Verify Text In Table
    [Arguments]  ${Locator_Type}  ${Table_Locator_Value}  ${Element_Locator_Value}  ${lookup_text}  ${col_num}  ${verify_text}
    ${textLocatorValue}=  Get Table Column Row Locator   ${Locator_Type}  ${Table_Locator_Value}  ${Element_Locator_Value}  ${col_num}  ${lookup_text}
    set selenium timeout  10s
    wait until element contains  ${Locator_Type}=${textLocatorValue}  ${verify_text}

Get Text From Table
    [Arguments]  ${Locator_Type}  ${Table_Locator_Value}  ${Element_Locator_Value}  ${lookup_text}  ${col_num}  ${lookup_text2}=None
    ${textlocator}=   Get Table Column Row Locator   ${Locator_Type}  ${Table_Locator_Value}  ${Element_Locator_Value}  ${col_num}  ${lookup_text}  ${lookup_text2}
    set selenium timeout  10s
    ${text}=   get text from xpath  ${textlocator}
   RETURN ${text}

Identify And Check Checkbox
    [Arguments]  ${Locator_Type}  ${Table_Locator_Value}  ${Element_Locator_Value}  ${first_last_name}
    ${CheckBoxLocatorValue}=  Get Table Column Row Locator   ${Locator_Type}  ${Table_Locator_Value}   ${Element_Locator_Value}  1  ${first_last_name}
    set focus to element  ${Locator_Type}=${CheckBoxLocatorValue}
    #select checkbox  ${Locator_Type}=${Locator_Value}
    click element  ${Locator_Type}=${CheckBoxLocatorValue}

Set Focus on
    [Arguments]  ${Locator_Type}  ${Locator_Value}
    sleep  6s
    set focus to element  ${Locator_Type}=${Locator_Value}

Import Lab Results And Open Import Details
    [Arguments]  ${Locator_Type}  ${Locator_Value}  ${APP_VERSION}  ${URL}
    ${AssayResultSpreadsheetid}=  Import Assay Results  ${APP_VERSION}  ${URL}
    Click  ${Locator_Type}  ${Locator_Value}
    #click element  ${Locator_Type}=${Locator_Value}
    set selenium timeout  10s
    Log  ${AssayResultSpreadsheetid}
    wait until page contains  ${AssayResultSpreadsheetid}
    Click  link  ${AssayResultSpreadsheetid}

Check Text In Table
    [Arguments]  ${table_locator}  ${rows}  ${col_num}  ${lookup_text1}  ${lookup_text2}=${None}  ${lookup_text3}=${None}
     FOR    ${INDEX}  IN RANGE  1  ${rows}
     Log  ${INDEX}
     ${text}=  Get Text From Xpath  ${table_locator}/tbody/tr[${INDEX}]/td[${col_num}]
     ${text}=  convert to string  ${text}
     #Check whether this table location has the desired text or not.
     should contain any  ${text}  ${lookup_text1}  ${lookup_text2}  ${lookup_text3}
     END



Get Text From Xpath
    [Arguments]  ${Locator_Value}
    ${text}=   Get Text  ${Locator_Value}
    Log  ${text}
   RETURN ${text}

Get List From Table
    [Arguments]    ${table_locator}  ${rows}  ${col_num}  ${Jump}
    ${text_list}=  create list
    FOR    ${INDEX}  IN RANGE  1  ${rows}  ${Jump}
    Log  ${INDEX}
    exit for loop if  ${INDEX} > ${rows}
     ${text}=  Get Text From Xpath  ${table_locator}/tbody/tr[${INDEX}]/td[${col_num}]
     ${text}=  convert to string  ${text}
     Run keyword   Append To List  ${text_list}  ${text}
     END
    RETURN ${text_list}

Set Analysis Approval
    [Arguments]   ${locator_type}  ${table_locator}  ${test_name}  ${col_num}  ${approval}  ${element_locator}=${emptystring}
    IF    "${approval}" == "Approved"
        Verify Text in Table  ${locator_type}  //*[@id="analysisrequest_table_assay_results"]/div/div/table  NotApplicable  ${test_name}   ${col_num}  ${approval}
    ELSE IF  "${approval}" == "Unapproved"
        Click Cell In Table  ${locator_type}  //*[@id="analysisrequest_table_assay_results"]/div/div/table  ${element_locator}   ${col_num}   ${test_name}
        Click  xpath  //*[@id="logistics_common_btn_yesno"]/material-button[1]/material-ripple
    ELSE IF  "${approval}" == "Rejected"
        Verify Text in Table  ${locator_type}  //*[@id="analysisrequest_table_assay_results"]/div/div/table  NotApplicable  ${test_name}   ${col_num}  ${approval}
    END