#!/usr/bin/env bash
#python libs/TestCaseGen.py data/GUITestCases_ids.xls tests
echo "Dashboard url is: ${DASHBOARD_URL}"
echo "Secure url is: ${SECURE_URL}"
#    - robot --variable TEST_ENV:https://merge.secure.qvin.com --variable BROWSER:headlessfirefox -d results/Medical-headlessfirefox -x TEST-Medical.xml tests/Medical.robot
#    - robot --variable TEST_ENV:https://merge.secure.qvin.com --variable BROWSER:headlessfirefox -d results/Logistics-headlessfirefox -x TEST-Logistics.xml tests/Logistics.robot
#    - robot --variable TEST_ENV:https://merge.secure.qvin.com --variable BROWSER:headlesschrome -d results/Medical-headlesschrome -x TEST-Medical.xml tests/Medical.robot
robot --variable DASHBOARD_URL:${DASHBOARD_URL} --variable SECURE_URL:${SECURE_URL} --variable BROWSER:headlesschrome --variable APP_VERSION:6 -d results/Admin-headlesschrome -x TEST-Admin.xml tests/Admin.robot
#    - robot --variable DASHBOARD_URL:${DASHBOARD_URL} --variable SECURE_URL:${SECURE_URL} --variable BROWSER:headlesschrome --variable APP_VERSION:4 -d results/TrialSignUp-headlesschrome -x TEST-TrialSignUp.xml tests/TrialSignUp.robot
robot --variable DASHBOARD_URL:${DASHBOARD_URL} --variable SECURE_URL:${SECURE_URL} --variable BROWSER:headlesschrome --variable APP_VERSION:6 -d results/Fulfillment-headlesschrome -x TEST-Fulfillment.xml tests/Fulfillment.robot
robot --variable DASHBOARD_URL:${DASHBOARD_URL} --variable SECURE_URL:${SECURE_URL} --variable BROWSER:headlesschrome --variable APP_VERSION:6 -d results/Medical-headlesschrome -x TEST-Medical.xml tests/Medical.robot
#robot --variable DASHBOARD_URL:${DASHBOARD_URL} --variable SECURE_URL:${SECURE_URL} --variable BROWSER:headlesschrome --variable APP_VERSION:4 -d results/Logistics-headlesschrome -x TEST-Logistics.xml tests/Logistics.robot
#robot --variable DASHBOARD_URL:${DASHBOARD_URL} --variable SECURE_URL:${SECURE_URL} --variable BROWSER:headlesschrome --variable APP_VERSION:4 -d results/Laboratory-headlesschrome -x TEST-Laboratory.xml tests/Laboratory.robot
#robot --variable DASHBOARD_URL:${DASHBOARD_URL} --variable SECURE_URL:${SECURE_URL} --variable BROWSER:headlesschrome --variable APP_VERSION:4 -d results/API-headlesschrome -x TEST-API.xml tests/API.robot