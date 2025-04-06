*** Variables ***
${emptystring}
${kitimportfilename}  KitImporter.xlsx
${assayresultfilename}  AssayResults.xlsx


${account_api_users}   /account_api/users?limit=200&offset=0
${communication_api_variables}   /communication_api/variables/?
${communication_api_upcomingmetas}   /communication_api/upcomingmetas?
${communication_api_upcomingmeta}   /communication_api/upcomingmeta?
${communication_api_upcomingEvent}    /communication_api/upcomingEvents?sort=%2Btime&limit=200&offset=0&types=
${communication_api_messageLogs_legalentity}   /communication_api/messageLogs?limit=50&offset=0&sort=-time&channelType=&destinationLegalEntityId=
${communication_api_messageLogs}   /communication_api/messageLogs?offset=0&sort=-time&limit=
${communication_api_messageLogs_collector}   /communication_api/messageLogs?limit=10&offset=0&sort=-time&channelType=&destinationCollectorTrialId=
${notification_startNextPadFirst}    timeout.pad.startNextPadFirst
${notification_startNextPadSecond}    timeout.pad.startNextPadSecond
${notification_stillUsingFirst}    timeout.pad.stillUsingFirst
${notification_stillUsingSecond}    timeout.pad.stillUsingSecond
${notification_stillUsingThird}    timeout.pad.stillUsingThird
${notification_stillUsingFourth}    timeout.pad.stillUsingFourth
${notification_startFirstPad}  timeout.pad.startFirstPad
${notification_scheduleByNurse}   timeout.kit.scheduleByNurse
${notification_finishPad}     timeout.pad.finishPad
${notification_shipkit}   notification.pad.shipKitTimeout
${event.KitUseStart}   com.qurasense.common.messaging.broadcast.event.KitUseStart
${event.QPadRegistrationStarted}   com.qurasense.common.messaging.broadcast.event.qpad.QPadRegistrationStarted
${event.StartFirstPad}   com.qurasense.communication.upcoming.StartFirstPadEvent
${event.StartNextPadFirst}   com.qurasense.communication.upcoming.StartNextPadFirstEvent
${event.StartNextPadSecond}   com.qurasense.communication.upcoming.StartNextPadSecondEvent
${event.ConfirmCarrierKit}   com.qurasense.communication.upcoming.ConfirmCarrierKitEvent
${event.PadStillUsingFirst}   com.qurasense.communication.upcoming.PadStillUsingFirstEvent
${event.PadStillUsingSecond}   com.qurasense.communication.upcoming.PadStillUsingSecondEvent
${product_api_kits}  /product_api/kits?limit=20&offset=0&sort=-createTime&search&statusType=
${product_api_analysisRequestStatusType}  /product_api/analysisRequests?limit=10&offset=0&sort=-status.createTime&search&analysisRequestStatusType=
${account_api_organisation}  /account_api/organizations/?
${product_api_analysisRequestKit}  /product_api/analysisRequest/kit/
${product_api_producttypes}  /product_api/storeProductTypes
${product_api_panel}  /product_apipanelProductTypes?sort=%2Bname&status=NEW&status=RELEASED
${product_api_bundle}  /product_api/bundles?sort=%2Bname&status=NEW&status=RELEASED
${product_api_createorder}  /product_api/order/create?
${account_api_validateaddress}  /account_api/address/validate?
${account_api_shipment}  /account_api/shipment?
${alphanumericID}   aed7cb20-268e-474f-9b41-4ffec8428ac5
${product_api_createassayresultstemplate}  /product_api/assaySpecimenResults/createAssayResultImportTemplate
${product_api_importkits}  /product_api/kits/upload?fileName=
${product_api_shipkits}  /product_api/orders/ship?orderId=
${product_api_assayresults}  /product_api/assaySpecimenResults/upload?fileName=
${product_api_wizards}   /product_api/wizards?limit=10&offset=0&sort=-createTime
${product_api_orderNumber}   /product_api/order/
${product_api_kitdetails}  /product_api/kit/kitId/
${product_api_assay}  /product_api/assays/
${account_api_consent}  /account_api/consentForms/
${accout_api_create_user}   /account_api/registration?
${account_api_group}    /account_api/groups/?
${account_api_enrollgroup}  /account_api/group/
${product_api_wizard_details}   /product_api/wizard/
${product_api_survey}  /product_api/survey
${account_api_survey}  /account_api/survey/
${analysisreqdetails}   /product_api/analysisRequestByIds?id=
${analysisRequests}     /product_api/analysisRequests/customer/
${product_api_test_results}  orders/tests?code=
${account_api_token}  /account_api/oauth/token

${dendi_api_auth}  /api/api-token-auth/
${dendi_api_order}  /api/v2/orders/test_results/?order_code=
${dendi_api_order_receive}  /api/v1/orders_receive/
${dendi_api_order_receive}  /api/v1/orders_reject/
${dendi_api_order_verify}  /api/v2/orders/verify_all/
${dendi_api_order_result}  /api/v2/orders/test_results/

${test_data}   ./data/Test Data for TDC.xlsx