import pandas as pd
import math
import sys

##########################################################################
# Accepting command line arguments
##########################################################################
varTestCaseXLFile = sys.argv[1]
varFolderForRobotTests = sys.argv[2]
df_testsuites = pd.read_excel(varTestCaseXLFile,sheet_name='TestSuites',dtype=str)
df_testsuites = df_testsuites[df_testsuites["RUN"] == 'Y']
df_testsuiteactive = df_testsuites['TEST_SUITE_NAME']
df_testsuiteactive = df_testsuiteactive.drop_duplicates()
test_suite_list = df_testsuiteactive.values.tolist()


###########################################################################################################
# Parsing thru the XL file to extract the test cases to be executed and generating automated test code files
############################################################################################################

for varTestSuite in test_suite_list:

    df_currentsuiterows = df_testsuites[df_testsuites["TEST_SUITE_NAME"] == varTestSuite]
    df_testcases = df_currentsuiterows['TESTCASE_ID']
    df_table = pd.read_excel(varTestCaseXLFile, sheet_name=varTestSuite,dtype=str)
    df_table.dropna(how='all', inplace=True)
    df2 = df_table


##########################################################################
# To write hardcoded robot part of test case file
##########################################################################

    def write_test_file_fixed():

        test_file_name = varFolderForRobotTests + "//" + varTestSuite + ".robot"
        print(test_file_name)
        f = open(test_file_name, "w+")
        f.write("*** Settings ***")
        f.write('\n')
        f.write("Documentation  This is a test suite for Qurasense GUI Testing")
        f.write('\n')
        f.write("Resource  ../data/global_variables.robot")
        f.write('\n')
        f.write("Resource    ../resources/page_actions.robot")
        f.write('\n')
        f.write("Resource    ../resources/custom_actions.robot")
        f.write('\n')
        #f.write("Test TearDown  Close Browser")
        #f.write('\n')
        #f.write('\n')
        f.write("*** Variables ***")
        f.write('\n')
        f.write('\n')
        f.write("*** Test Cases ***")
        f.write('\n')
        f.close()

##########################################################################
##########################################################################
##########################################################################

    test_case_list = df_testcases.values.tolist()
    print(test_case_list)
    print(varTestSuite)
    #test_list = df_testcases.values.tolist()

    write_test_file_fixed();

    test_file_name = varFolderForRobotTests+"//" + varTestSuite + ".robot"
    f = open(test_file_name, "a")

    for testname in test_case_list:
        f.write('\n')
        f.write(testname)
        f.write('\n')

        testStepsList = []
        # iterate rows
        for testStepRow in range(len(df2)):
            spaceString = ""
            stepCommandString = ""
            stepCommentString = ""
            string_length = len(spaceString) + 4  # Adds 4 extra spaces for robot test file generation
            spaceString = spaceString.rjust(string_length)

            check = df2.iloc[testStepRow][0]
            if (check != testname):
                continue
            else:

                # Generate the comment string, for each step
                stepCommentString += spaceString
                stepCommentString += "#"
                cellData = df2.iloc[testStepRow][1]
                if pd.isnull(cellData):
                    stepCommentString += ""
                else:
                    stepCommentString += str(cellData)
                stepCommentString = stepCommentString.rstrip()
                testStepsList.append(stepCommentString)


                # Generate the command string, for each step
                stepCommandString += spaceString
                for testStepCol in df2.columns[2:]:

                    # check null values and skip column
                    cellData = df2.iloc[testStepRow][testStepCol]
                    if pd.isnull(cellData):
                        continue
                    else:
                        if isinstance(cellData, str):
                            stepCommandString += str(cellData) + "  "
                        else:
                            stepCommandString += str(int(cellData)) + "  "
                # remove spaces
                stepCommandString = stepCommandString.rstrip()
                testStepsList.append(stepCommandString)
                stepCommandString = ''

        for i in range(len(testStepsList)):
            f.write(str(testStepsList[i]))
            f.write('\n')

        # reading output from the list
    for i in range(len(testStepsList)):
        print(str(testStepsList[i]))

    f.close()

