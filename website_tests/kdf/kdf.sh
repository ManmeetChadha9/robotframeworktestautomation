#!/usr/bin/env bash
#python libs/TestCaseGen.py data/GUITestCases_ids.xls tests
echo "Dashboard url is: ${DASHBOARD_URL}"
echo "Secure url is: ${SECURE_URL}"
echo "Dendi url is: ${DENDI_URL}"
robot --variable DASHBOARD_URL:${DASHBOARD_URL} --variable SECURE_URL:${SECURE_URL} --variable DENDI_URL:${DENDI_URL} --variable BROWSER:headlesschrome --variable APP_VERSION:6 -d results/EndToEnd-headlesschrome -x TEST-EndToEnd.xml tests/EndToEnd.robot