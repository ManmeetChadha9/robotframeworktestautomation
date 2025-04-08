*** Settings ***
Documentation  This is a test suite for Qurasense GUI Testing
Resource  ../data/global_variables.robot
Resource    ../resources/page_actions.robot
Resource    ../resources/custom_actions.robot
Resource    ../resources/api_oldutils.robot
*** Variables ***

${forUser}=   ${communication_api_messageLogs_legalentity}
${forNurse}=    ${communication_api_messageLogs_collector}

*** Test Cases ***
ROBOT_API_02
    #Generate  token for admin user
    Create Admin Authentication Endpoint  _admin@qvin.com  secret  123  EMAIL
    #Generate  token for customer
    #Create Customer Authentication Endpoint  _customermobapp@qvin.com  secret  123  EMAIL
    #Generate  token for logistics user
    Create Logistics Authentication Endpoint  _logistics@qvin.com  secret  123  EMAIL
    #Set eventid as empty string
    ${eventid}=  Set Variable  ${emptystring}
    #Get event id of upcoming_event='com.qurasense.communication.upcoming.PadStillUsingFirst'  seqnum=1
    ${eventid}=  Get Upcoming Event Value   ${APP_VERSION}  ${TEST_ENV}  com.qurasense.communication.upcoming.PadStillUsingFirst  1  id
    #Set event id of upcoming_event='com.qurasense.communication.upcoming.PadStillUsingFirst'  seqnum=1
    Set Upcoming Event  ${APP_VERSION}  ${TEST_ENV}  ${eventid}  1  com.qurasense.common.messaging.broadcast.event.qpad.QPadFirstStarted  com.qurasense.communication.upcoming.PadStillUsingFirst  PT1M
    #Get event id of upcoming_event='com.qurasense.communication.upcoming.PadStillUsingFirst'  seqnum=2
    ${eventid}=  Get Upcoming Event Value   ${APP_VERSION}  ${TEST_ENV}  com.qurasense.communication.upcoming.PadStillUsingFirst  2  id
    #Set event id of upcoming_event='com.qurasense.communication.upcoming.PadStillUsingFirst'  seqnum=2
    Set Upcoming Event  ${APP_VERSION}  ${TEST_ENV}  ${eventid}  2  com.qurasense.common.messaging.broadcast.event.qpad.QPadFirstStarted  com.qurasense.communication.upcoming.PadStillUsingFirst  PT2M
    #Get event id of upcoming_event='com.qurasense.communication.upcoming.StartNextPadEvent'  seqnum=1
    ${eventid}=  Get Upcoming Event Value   ${APP_VERSION}  ${TEST_ENV}  com.qurasense.communication.upcoming.StartNextPadEvent  1  id
    #Set event id of upcoming_event='com.qurasense.communication.upcoming.StartNextPadEvent'  seqnum=1
    Set Upcoming Event  ${APP_VERSION}  ${TEST_ENV}  ${eventid}  1  com.qurasense.common.messaging.broadcast.event.qpad.QPadRegistrationFinished  com.qurasense.communication.upcoming.StartNextPadEvent  PT1M
    #Get event id of upcoming_event='com.qurasense.communication.upcoming.StartNextPadEvent'  seqnum=2
    ${eventid}=  Get Upcoming Event Value   ${APP_VERSION}  ${TEST_ENV}  com.qurasense.communication.upcoming.StartNextPadEvent  2  id
    #Set event id of upcoming_event='com.qurasense.communication.upcoming.StartNextPadEvent'  seqnum=2
    Set Upcoming Event  ${APP_VERSION}  ${TEST_ENV}  ${eventid}  2  com.qurasense.common.messaging.broadcast.event.qpad.QPadRegistrationFinished  com.qurasense.communication.upcoming.StartNextPadEvent  PT2M
    #Get event id of upcoming_event='com.qurasense.communication.upcoming.PadStillUsingSecond'  seqnum=1
    ${eventid}=  Get Upcoming Event Value   ${APP_VERSION}  ${TEST_ENV}  com.qurasense.communication.upcoming.PadStillUsingSecond  1  id
    #Set event id of upcoming_event='com.qurasense.communication.upcoming.PadStillUsingSecond'  seqnum=1
    Set Upcoming Event  ${APP_VERSION}  ${TEST_ENV}  ${eventid}  1  com.qurasense.common.messaging.broadcast.event.qpad.QPadSecondStarted  com.qurasense.communication.upcoming.PadStillUsingSecond  PT1M
    #Get event id of upcoming_event='com.qurasense.communication.upcoming.ScheduleKitEvent'  seqnum=1
    ${eventid}=  Get Upcoming Event Value   ${APP_VERSION}  ${TEST_ENV}  com.qurasense.communication.upcoming.ScheduleKitEvent  1  id
    #Set event id of upcoming_event='com.qurasense.communication.upcoming.ScheduleKitEvent'  seqnum=1
    Set Upcoming Event  ${APP_VERSION}  ${TEST_ENV}  ${eventid}  1  com.qurasense.common.messaging.broadcast.event.KitUseStart  com.qurasense.communication.upcoming.ScheduleKitEvent  PT2M
    #Get event id of upcoming_event='com.qurasense.communication.upcoming.ConfirmCarrierKitEvent'  seqnum=1
    ${eventid}=  Get Upcoming Event Value   ${APP_VERSION}  ${TEST_ENV}  com.qurasense.communication.upcoming.ConfirmCarrierKitEvent  1  id
    #Set event id of upcoming_event='com.qurasense.communication.upcoming.ConfirmCarrierKitEvent'  seqnum=1
    Set Upcoming Event  ${APP_VERSION}  ${TEST_ENV}  ${eventid}  1  com.qurasense.common.messaging.broadcast.event.KitUseStart  com.qurasense.communication.upcoming.ConfirmCarrierKitEvent  PT3M
    #Generate  token for customer
    ${customermobappendpoint}=  Create Customer Authentication Endpoint  _customermobapp@qvin.com  secret  123  EMAIL
    #Register the Qpad for the mentioned customer
    ${legalid}=  Set Variable   ${None}
    #Register the Qpad for the mentioned customer
    Register Qpad  ${APP_VERSION}  ${TEST_ENV}  ${customermobappendpoint}  MA03PAD2  _customermobapp@qvin.com
    #Sleep  so that the next notofication to user can be verified
    Sleep  300
    #API call to mark start collection process of a pad
    Pad Start Collection  ${APP_VERSION}  ${TEST_ENV}  ${customermobappendpoint}  MA03PAD2  _customermobapp@qvin.com  REGISTERED
    ${legalid}=  Get Legal ID   ${APP_VERSION}  ${TEST_ENV}   _customermobapp@qvin.com
    # TC- 46 Check the message log for 'Pad Collection Started' notification for Staff on Slack channel
    Check Message Log Time After KitUseStart     ${APP_VERSION}  ${TEST_ENV}  _customermobapp@qvin.com  com.qurasense.common.messaging.broadcast.event.qpad.QPadRegistrationStarted  1  MA03   ${communication_api_messageLogs}   20  'channelType'   SLACK
    #Sleep  so that the next notofication to user can be verified
    Sleep  300
    #Check the message log for 'padstillusingfirstevent' notification
    Check Message Log Time After PadEvent  ${APP_VERSION}  ${TEST_ENV}  _customermobapp@qvin.com  com.qurasense.communication.upcoming.PadStillUsingFirst  1  MA03  IN_USE  MA03PAD2  START_COLLECTION   ${forUser}  ${legalid}
    #Sleep  so that the next notofication to user can be verified
    Sleep  300
    #Check the message log for 'padstillusingsecondevent' notification
    Check Message Log Time After PadEvent  ${APP_VERSION}  ${TEST_ENV}  _customermobapp@qvin.com  com.qurasense.communication.upcoming.PadStillUsingFirst  2  MA03  IN_USE  MA03PAD2  START_COLLECTION  ${forUser}  ${legalid}
    #API call to mark end collection process of a pad
    Pad End Collection  ${APP_VERSION}  ${TEST_ENV}  ${customermobappendpoint}  MA03PAD2  _customermobapp@qvin.com  IN_USE
    #Sleep  so that the next notofication to user can be verified
    Sleep  300
    #Check the message log for 'startNextPadFirst' notification
    Check Message Log Time After PadEvent  ${APP_VERSION}  ${TEST_ENV}    _customermobapp@qvin.com  com.qurasense.communication.upcoming.StartNextPadEvent  1  MA03  IN_USE  MA03PAD2  END_COLLECTION   ${forUser}  ${legalid}
    #API call to mark start collection process of a pad
    Pad Start Collection  ${APP_VERSION}  ${TEST_ENV}  ${customermobappendpoint}  MA03PAD1  _customermobapp@qvin.com  IN_USE
    #Sleep  so that the next notofication to user can be verified
    Sleep  300
    #Check the message log for 'startNextPadFirst' notification
    Check Message Log Time After PadEvent  ${APP_VERSION}  ${TEST_ENV}  _customermobapp@qvin.com  com.qurasense.communication.upcoming.StartNextPadEvent  2  MA03  IN_USE  MA03PAD2  END_COLLECTION    ${forUser}  ${legalid}
    #Sleep  so that the next notofication to user can be verified
    Sleep  300
    #TC-57 verifying message for event "StillUsingSecond"  Count=1
    Verify Messages Count From Messagelog    ${APP_VERSION}  ${TEST_ENV}   ${forUser}  ${legalid}  'messageType'  com.qurasense.communication.upcoming.PadStillUsingSecond  1
    #TC-55 Check the message log for 'stillUsingSecond' push notification
    Check Message Log Time After PadEvent  ${APP_VERSION}  ${TEST_ENV}  _customermobapp@qvin.com  com.qurasense.communication.upcoming.PadStillUsingSecond  1  MA03  IN_USE  MA03PAD1  START_COLLECTION     ${forUser}  ${legalid}    'channelType'   PUSH
    #API call to mark end collection process of a pad
    Pad End Collection  ${APP_VERSION}  ${TEST_ENV}  ${customermobappendpoint}  MA03PAD1  _customermobapp@qvin.com  IN_USE
    #Sleep  so that the next notofication to user can be verified
    Sleep  300
    #API call to ship the kit
    Ship Kit  ${APP_VERSION}  ${TEST_ENV}  ${customermobappendpoint}  MA03


ROBOT_API_03

    Create Admin Authentication Endpoint  _admin@qvin.com  secret  123  EMAIL
    ${wizid}=  Get Wizard ID   ${APP_VERSION}   ${TEST_ENV}  SD trial
    ${steps}=  Get Wizard step details     ${APP_VERSION}   ${TEST_ENV}  ${wizid}
    Create new User     ${APP_VERSION}  ${TEST_ENV}  customermob    app2      _customermobapp2@qvin.com  Abc!123
    sleep  5
    ${legalid}=  Get legal id    ${APP_VERSION}  ${TEST_ENV}     _customermobapp2@qvin.com
    sleep  5
    ${surveyid}=  Submit Survey       ${APP_VERSION}  ${TEST_ENV}   ${legalid}  ${wizid}
    ${account_api_oauthcustomer}=  Create Customer Authentication Endpoint   _customermobapp2@qvin.com  Abc!123  123  EMAIL
    Submit Account Steps   ${APP_VERSION}  ${TEST_ENV}  ${surveyid}  ${legalid}   ${account_api_oauthcustomer}  ${steps}  255 Warren Street   07302  NJ   US  Jersey City  2000-01-01
    ${groupid}=  Get Group id    ${APP_VERSION}  ${TEST_ENV}   San Diego comparative trial
    Enroll in Group  ${APP_VERSION}  ${TEST_ENV}  San Diego comparative trial  ${legalid}
    ${customerenvswitchendpoint}=  Create Customer Authentication Endpoint  _customermobapp2@qvin.com  secret  123  EMAIL
    ${account_api_oauthdoctor}=    Create Doctor Authentication Endpoint   _doctor@qvin.com  secret  123  EMAIL
    ${paticipantid}=  Get Group Participant Id    ${APP_VERSION}  ${TEST_ENV}    ${groupid}   ${legalid}
    Approve User    ${APP_VERSION}  ${TEST_ENV}    ${paticipantid}
    #TC-569; TC-568; TC-45; TC-571; TC-570; TC-75; TC-573; TC-572
    ${producttype_value}=   set variable  ${None}
    #Generate  token for customer
    ${_customermobapp2endpoint}=   Create Customer Authentication Endpoint  _customermobapp2@qvin.com  Abc!123  123  EMAIL
    #Generate  token for logistics user
    Create Logistics Authentication Endpoint  _logistics@qvin.com  secret  123  EMAIL
    ${eventid}=  Set Variable  ${emptystring}
    #Get event id of upcoming_event='com.qurasense.communication.upcoming.PadStillUsingFirst'  seqnum=1
    ${eventid}=  Get Upcoming Event Value   ${APP_VERSION}  ${TEST_ENV}  com.qurasense.communication.upcoming.PadStillUsingFirst  1  id
    #Set event id of upcoming_event='com.qurasense.communication.upcoming.PadStillUsingFirst'  seqnum=1
    Set Upcoming Event  ${APP_VERSION}  ${TEST_ENV}  ${eventid}  1  com.qurasense.common.messaging.broadcast.event.qpad.QPadFirstStarted  com.qurasense.communication.upcoming.PadStillUsingFirst  PT10M
    #Get event id of upcoming_event='com.qurasense.communication.upcoming.PadStillUsingFirst'  seqnum=2
    ${eventid}=  Get Upcoming Event Value   ${APP_VERSION}  ${TEST_ENV}  com.qurasense.communication.upcoming.PadStillUsingFirst  2  id
    #Set event id of upcoming_event='com.qurasense.communication.upcoming.PadStillUsingFirst'  seqnum=2
    Set Upcoming Event  ${APP_VERSION}  ${TEST_ENV}  ${eventid}  2  com.qurasense.common.messaging.broadcast.event.qpad.QPadFirstStarted  com.qurasense.communication.upcoming.PadStillUsingFirst  PT15M
    #Get event id of upcoming_event='com.qurasense.communication.upcoming.PadStillUsingFirst'  seqnum=3
    ${eventid}=  Get Upcoming Event Value   ${APP_VERSION}  ${TEST_ENV}  com.qurasense.communication.upcoming.PadStillUsingFirst  3  id
    #Set event id of upcoming_event='com.qurasense.communication.upcoming.PadStillUsingFirst'  seqnum=3
    Set Upcoming Event  ${APP_VERSION}  ${TEST_ENV}  ${eventid}  3  com.qurasense.common.messaging.broadcast.event.qpad.QPadFirstStarted  com.qurasense.communication.upcoming.PadStillUsingFirst  PT20M
    #Get event id of upcoming_event='com.qurasense.communication.upcoming.StartNextPadEvent'  seqnum=1
    ${eventid}=  Get Upcoming Event Value   ${APP_VERSION}  ${TEST_ENV}  com.qurasense.communication.upcoming.StartNextPadEvent  1  id
    #Set event id of upcoming_event='com.qurasense.communication.upcoming.StartNextPadEvent'  seqnum=1
    Set Upcoming Event  ${APP_VERSION}  ${TEST_ENV}  ${eventid}  1  com.qurasense.common.messaging.broadcast.event.qpad.QPadRegistrationFinished  com.qurasense.communication.upcoming.StartNextPadEvent  PT10M
    #Get event id of upcoming_event='com.qurasense.communication.upcoming.StartNextPadEvent'  seqnum=2
    ${eventid}=  Get Upcoming Event Value   ${APP_VERSION}  ${TEST_ENV}  com.qurasense.communication.upcoming.StartNextPadEvent  2  id
    #Set event id of upcoming_event='com.qurasense.communication.upcoming.StartNextPadEvent'  seqnum=2
    Set Upcoming Event  ${APP_VERSION}  ${TEST_ENV}  ${eventid}  2  com.qurasense.common.messaging.broadcast.event.qpad.QPadRegistrationFinished  com.qurasense.communication.upcoming.StartNextPadEvent  PT20M
    #Get event id of upcoming_event='com.qurasense.communication.upcoming.PadStillUsingSecond'  seqnum=1
    ${eventid}=  Get Upcoming Event Value   ${APP_VERSION}  ${TEST_ENV}  com.qurasense.communication.upcoming.PadStillUsingSecond  1  id
    #Set event id of upcoming_event='com.qurasense.communication.upcoming.PadStillUsingSecond'  seqnum=1
    Set Upcoming Event  ${APP_VERSION}  ${TEST_ENV}  ${eventid}  1  com.qurasense.common.messaging.broadcast.event.qpad.QPadSecondStarted  com.qurasense.communication.upcoming.PadStillUsingSecond  PT10M
    #getting product type trialID
    ${producttype_value}=   Get Product Type Value  ${APP_VERSION}  ${TEST_ENV}    San Diego Comparative trial  id
    #TC-40 , verifying email sent to users email address after signUp
    #Check Message Log Time After Event   ${APP_VERSION}  ${TEST_ENV}   _customermobapp2@qvin.com   com.qurasense.common.messaging.broadcast.event.SignupEvent    ${forUser}   ${legalid}    'channelType'   EMAIL
    #TC-73 , Check the message log for 'SignUP' notification on SLACK channel
    #Check Message Log Time After Event   ${APP_VERSION}  ${TEST_ENV}  _customermobapp2@qvin.com  com.qurasense.common.messaging.broadcast.event.SignupEvent   ${forUser}   ${legalid}    'channelType'   SLACK
    #Register the Qpad for the mentioned customer
    Register Qpad  ${APP_VERSION}  ${TEST_ENV}  ${_customermobapp2endpoint}  KT16PAD2  _customermobapp2@qvin.com
    #Sleep  so that the next notofication to user/nurse can be verified
    Sleep  300
    #API call to mark start collection process of a pad
    Pad Start Collection  ${APP_VERSION}  ${TEST_ENV}  ${_customermobapp2endpoint}  KT16PAD2  _customermobapp2@qvin.com  REGISTERED
    #Get Pad ID of pad in use
    ${padid}=  Get Pad Id  ${APP_VERSION}  ${TEST_ENV}  KT16PAD2  IN_USE
    #Sleep  so that the next notofication to user/nrse can be verified
    Sleep   30
    #Check the message log for 'KitUseStart' notification for nurse on email channel
#    Check Message Log Time After KitUseStart     ${APP_VERSION}  ${TEST_ENV}  _customermobapp2@qvin.com  com.qurasense.common.messaging.broadcast.event.KitUseStart  1  KT16   ${forNurse}   ${producttype_value}  'channelType'   EMAIL
#    #Check the message log for 'KitUseStart' notification for nurse on SMS channel
#    Check Message Log Time After KitUseStart     ${APP_VERSION}  ${TEST_ENV}  _customermobapp2@qvin.com  com.qurasense.common.messaging.broadcast.event.KitUseStart  1  KT16   ${forNurse}   ${producttype_value}  'channelType'   SMS
#    #Check the message log for 'KitUseStart' notification for User on SMS channel
    Check Message Log Time After KitUseStart     ${APP_VERSION}  ${TEST_ENV}  _customermobapp2@qvin.com  com.qurasense.common.messaging.broadcast.event.KitUseStart  1  KT16   ${forUser}   ${legalid}  'channelType'   SMS
    #Sleep  so that the next notofication to user/nurse can be verified
    Sleep  270
    #Check the message log for 'ScheduleKitEvent' notification for nurse on Email channel
#    Check Message Log Time After PadEvent     ${APP_VERSION}  ${TEST_ENV}  _customermobapp2@qvin.com  com.qurasense.communication.upcoming.ScheduleKitEvent  1  KT16   IN_USE  KT16PAD2  START_COLLECTION  ${forNurse}   ${producttype_value}    'channelType'   EMAIL
    #Check the message log for 'ScheduleKitEvent' notification for nurse on SMS channel
#    Check Message Log Time After PadEvent     ${APP_VERSION}  ${TEST_ENV}  _customermobapp2@qvin.com  com.qurasense.communication.upcoming.ScheduleKitEvent  1  KT16   IN_USE  KT16PAD2  START_COLLECTION  ${forNurse}   ${producttype_value}    'channelType'   SMS
    #Check the message log for 'ScheduleKitEvent' notification on SLACK channel
#    Check Message Log Time After PadEvent     ${APP_VERSION}  ${TEST_ENV}  _customermobapp2@qvin.com  com.qurasense.communication.upcoming.ScheduleKitEvent  1  KT16   IN_USE  KT16PAD2  START_COLLECTION  ${communication_api_messageLogs}   20    'channelType'   SLACK
    #Sleep  so that the next notofication to user/nurse can be verified
    Sleep  60
    #Check the message log for 'SConfirmCarrierKitEvent' notification for nurse on Email channel
#    Check Message Log Time After PadEvent     ${APP_VERSION}  ${TEST_ENV}  _customermobapp2@qvin.com  com.qurasense.communication.upcoming.ConfirmCarrierKitEvent  1  KT16   IN_USE  KT16PAD2  START_COLLECTION  ${forNurse}   ${producttype_value}    'channelType'   EMAIL
    #Check the message log for 'ConfirmCarrierKitEvent' notification for nurse on SMS channel
#    Check Message Log Time After PadEvent     ${APP_VERSION}  ${TEST_ENV}  _customermobapp2@qvin.com  com.qurasense.communication.upcoming.ConfirmCarrierKitEvent  1  KT16   IN_USE  KT16PAD2  START_COLLECTION  ${forNurse}   ${producttype_value}    'channelType'   SMS
    #API call to mark end collection process of a pad
    Pad End Collection  ${APP_VERSION}  ${TEST_ENV}  ${_customermobapp2endpoint}  KT16PAD2  _customermobapp2@qvin.com  IN_USE
    #Sleep  for 3 mnutes so that the upcoming events can be checked for the right status
    Sleep  180
    # TC-48;Check the Upcoming Event 'com.qurasense.communication.upcoming.PadStillUsingFirst' is state=CANCELED for seqnum=1
    Check Upcoming Event Message  ${APP_VERSION}  ${TEST_ENV}  'eventType'  com.qurasense.communication.upcoming.PadStillUsingFirst  'reuseKey'  ${padid}   1  'state'  CANCELED
    # TC-50;Check the Upcoming Event 'com.qurasense.communication.upcoming.PadStillUsingFirst' is state=CANCELED for seqnum=3
    Check Upcoming Event Message  ${APP_VERSION}  ${TEST_ENV}  'eventType'  com.qurasense.communication.upcoming.PadStillUsingFirst  'reuseKey'  ${padid}   3  'state'  CANCELED
    #API call to mark start collection process of a pad
    Pad Start Collection  ${APP_VERSION}  ${TEST_ENV}  ${_customermobapp2endpoint}  KT16PAD1  _customermobapp2@qvin.com  IN_USE
    #Sleep  for 3 mnutes so that the upcoming events can be checked for the right status
    Sleep  180
    #Get Kit ID of Kit in use
    ${kitid}=  Get Kit Id  ${APP_VERSION}  ${TEST_ENV}  KT16  IN_USE
    # TC-52;Check the Upcoming Event 'com.qurasense.communication.upcoming.StartNextPadEvent' is state=CANCELED for seqnum=1
    Check Upcoming Event Message  ${APP_VERSION}  ${TEST_ENV}  'eventType'  com.qurasense.communication.upcoming.StartNextPadEvent  'reuseKey'  ${kitid}   1  'state'  CANCELED
    #API call to mark end collection process of a pad
    Pad End Collection  ${APP_VERSION}  ${TEST_ENV}  ${_customermobapp2endpoint}  KT16PAD1  _customermobapp2@qvin.com  IN_USE
    #Get Pad ID of pad in use
    ${padid}=  Get Pad Id  ${APP_VERSION}  ${TEST_ENV}  KT16PAD1  IN_USE
    #Sleep  for 2 mnutes so that the upcoming events can be checked for the right status
    Sleep  120
    # TC-54;Check the Upcoming Event 'com.qurasense.communication.upcoming.PadStillUsingSecond' has state=CANCELED for seqnum=1
    Check Upcoming Event Message  ${APP_VERSION}  ${TEST_ENV}  'eventType'  com.qurasense.communication.upcoming.PadStillUsingSecond  'reuseKey'  ${padid}   1  'state'  CANCELED
    #API call to ship the kit
    Ship Kit  ${APP_VERSION}  ${TEST_ENV}  ${_customermobapp2endpoint}  KT16
