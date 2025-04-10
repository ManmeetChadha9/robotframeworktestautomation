*** Settings ***
Library           Process

*** Variables ***
${BOTIUM_CONFIG}    chatbot_tests/botium.json
${TEST_SPEC_DIR}    chatbot_tests/spec

*** Test Cases ***
Run All Chatbot Tests
    [Documentation]    Run all .convo.txt tests via Botium CLI
    ${result}=    Run Process    botium-cli run --config ${BOTIUM_CONFIG} --convos ${TEST_SPEC_DIR}    shell=True
    Should Be Equal As Integers    ${result.rc}    0