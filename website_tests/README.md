# PYTHON Installation

    On UNIX-like systems such as Linux and OS X you have Python installed by default.
    If on Windows or otherwise install Python. A good place to start is http://python.org

# PATH variable

Add paths for the below two into the PATH environment variable: 1) Installation directory of the interpreter - C:\Python\Python37 2) Location where scripts are installed with that interpreter. - C:\Python\Python37\Scripts

# ROBOT installation and external libraries required

pip install -U robotframework robotframework-seleniumlibrary requests robotframework-jsonlibrary robotframework-requests docutils
pip install pandas
pip install xlrd
pip install openpyxl

# INSTALL browser drivers eg: chromedriver for Chrome. Place into directory and add the same to environment variable PATH.

Chrome: https://sites.google.com/a/chromium.org/chromedriver/downloads
Edge: https://developer.microsoft.com/en-us/microsoft-edge/tools/webdriver/
Firefox: https://github.com/mozilla/geckodriver/releases
Safari: https://webkit.org/blog/6900/webdriver-support-in-safari-10/

# COMMAND to create robot test files from the XLS file
python libs/TestCaseGen.py data/GUITestCases.xlsx tests

# COMMAND to execute robot tests
robot --variable TEST_URL:"https://saucedemo.com/" --variable BROWSER:headlesschrome -d results/SwagLabs-headlesschrome -x SwagLabs.xml tests/SwagLabs.robot