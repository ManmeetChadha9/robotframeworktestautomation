
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

Some Demo videos:
https://youtu.be/FMlDgnSfVjY


<img width="655" alt="image" src="https://github.com/user-attachments/assets/6534e344-920d-4805-9209-13e090dc9137" />




# ROBOT installation and external libraries required

pip install -U robotframework robotframework-seleniumlibrary requests robotframework-jsonlibrary robotframework-requests docutils
pip install pandas
pip install xlrd
pip install openpyxl
pip install openai


# COMMANDS to install Botium cli and Botium connector with DialogFlow
brew install node
npm install -g botium-cli
npm install -g botium-connector-dialogflow

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


# ChatBot Testing

Steps below for Gcloud Service Account activation

These steps are executed after Chatbot agent creation in DialogFlow ES is complete

🔹 1. Create a Service Account in Google Cloud Console
Open the GCP Console

	a) Go to: IAM & Admin → Service Accounts
	b) Create a new service account:
	c) Assign it Dialogflow API Client and Dialogflow API Admin  roles
	d) Create a servie key for the account.
	e) Download the service key JSON file (the private key file)

🔹 2. Copy the below 3 items from the downloaded JSON file to botium.json file:
a) client_email
b) private_key (For me I did not use escape character for \n, even though everywhere online, it was recommended to be added )
c) project_id

🔹 3. Revoke all active gcloud accounts (Just to be safe)

	gcloud auth application-default revoke

🔹 4. Activate the service account created in Step 1

	gcloud auth activate-service-account kattolum-bot-service@kattolum--wdcb.iam.gserviceaccount.com --key-file=/Users/manmeetchadha/Work/kattolum--wdcb-9316350a79ac.json

🔹 5. Set the config project to be the main Google cloud project that is already associated to DialogFlow. This should be it.

	gcloud config set project kattolum--wdcb

🔹 6. Open the chatbot emulator to check all connections are in place. Type Hi. Chatbot should respond.

	botium-cli emulator --config chatbot_tests/botium.json

🔹 7. This command is used to test all DialogFlow Intents together

	botium-cli run --config chatbot_tests/botium.json --convos chatbot_tests/spec