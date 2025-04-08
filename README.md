
The Python Keyword based Test Automation framework is a tool built using Robotframework and Python custom libraries and uses the inbuilt python features.

It uses:
* Robot Framework libraries
* Selenium libraries
* Panda library
* Requests library 
* Xlrd library
* OpenAI library
* Custom python code for keyword generation 
* A listener to harness the capabilities of ChatGPT
  
The client's requirement was a test automation framework, which could be used and maintained easily. Hence took the Action Keyword approach.
The test suites in robot framework get automatically generated based on input in the XL File where the non-technical tester can write test cases, using keywords.


<img width="655" alt="image" src="https://github.com/user-attachments/assets/6534e344-920d-4805-9209-13e090dc9137" />




# ROBOT installation and external libraries required

pip install -U robotframework robotframework-seleniumlibrary requests robotframework-jsonlibrary robotframework-requests docutils
pip install pandas
pip install xlrd
pip install openpyxl
pip install openai

# INSTALL browser drivers eg: chromedriver for Chrome. Place into directory and add the same to environment variable PATH.

Chrome: https://sites.google.com/a/chromium.org/chromedriver/downloads
Edge: https://developer.microsoft.com/en-us/microsoft-edge/tools/webdriver/
Firefox: https://github.com/mozilla/geckodriver/releases
Safari: https://webkit.org/blog/6900/webdriver-support-in-safari-10/

# COMMAND to create robot test files from the XLS file
python libs/test_case_gen.py data/GUITestCases.xlsx website_tests
python libs/test_case_gen.py data/APITestCases.xlsx api_tests

# COMMANDS to setup env variables and execute robot tests

export PYTHONPATH=.   (# Set Python path to current directory so Robot can find our listener OR do this step while executing the robot test as below)
export OPENAI_API_KEY="sk-xxxxxx"  (# Set this env variable equal to the OpenAI API KEY )
export CHATGPT_TAGS=sms,account

PYTHONPATH=. robot \
--listener libs.chatgpt_listener.ChatGPTListener \
--variable TEST_URL:"https://json-placeholder.mock.beeceptor.com/" \
-d results/api_tests/jsonplaceholderapi \
-x jsonplaceholderapi.xml \
api_tests/jsonplaceholderapi.robot


PYTHONPATH=. robot \
--listener libs.chatgpt_listener.ChatGPTListener \
--variable TEST_URL:"https://saucedemo.com/" \
--variable BROWSER:headlesschrome \
-d results/website_tests/SwagLabs-headlesschrome \
-x SwagLabs.xml \
website_tests/SwagLabs.robot


PYTHONPATH=. robot \
--listener libs.chatgpt_listener.ChatGPTListener \
--variable TEST_URL:"https://twilio-api.mock.beeceptor.com/" \
-d results/api_tests/twillio_api \
-x twillio_api.xml \
api_tests/twillio_api.robot
