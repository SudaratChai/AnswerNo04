*** Settings ***
Library     AppiumLibrary
Library    	Collections
Library    	OperatingSystem
Library    	DateTime
Library    	String

*** Variables ***
${REMOTE_URL}            http://127.0.0.1:4723/wd/hub
${PLATFORM_NAME}         Android
${DEVICE_TARGET}         8.0
${DEVICE_NAME}           Pixel 3a API 26
${APP_PATH}              ${CURDIR}/apprelease.apk
${APP_ACTIVITY}          .MainActivity
${Automate_nmae}         appium
${TIMEUOT}               5s
${TODOLIST}              AddtodoList01
${TODOLIST2}              AddtodoList02
${TODOLIST3}             AddtodoList03
${TODODATE}              Today
${TODOTIME}              8:00 PM
#${EMPTY}                 ${None}

*** Keywords ***
Open Test Application
    [Arguments]   ${REMOTE_URL}    ${PLATFORM_NAME}    ${DEVICE_TARGET}    ${DEVICE_NAME}    ${APP_PATH}    ${Automate_nmae}
    Open Application  ${REMOTE_URL}  platformName=${PLATFORM_NAME}    platformVersion=${DEVICE_TARGET}    deviceName=${DEVICE_NAME}  app=${APP_PATH}    automationName=${Automate_nmae}
    Page Should Contain Text        You don't have any todos
    Sleep  5s

Click button Add To Do
    Click Element                      addToDoItemFAB
    Sleep  2s

Enter text To Do List
    [Arguments]   ${TODOLIST}
    Input Text           userToDoEditText      ${TODOLIST}
    Sleep  2s

Click sent to do list
    Click Element                      makeToDoFloatingActionButton
    Sleep  2s

Verify To do list
    [Arguments]   ${TODOLIST}
    Page Should Contain Text        ${TODOLIST}
    Sleep  2s

Verify To do list unsuccessful
    [Arguments]   ${TODOLIST}
    Page Should Not Contain Text    ${TODOLIST}
    Sleep  2s

Select to do list on screen
    Click Element                listItemLinearLayout
    Sleep  2s

Select Slide to do list on screen
    Swipe      0    230    100	0	1000
    Sleep  2s

Clear Text to do
    Clear Text        userToDoEditText
    Sleep  2s

Click on notifications
    Click Element        toDoHasDateSwitchCompat
    Sleep  2s

Input date
    [Arguments]   ${TODODATE}
    Clear Text           newTodoDateEditText
    Input Text           newTodoDateEditText      ${TODODATE}
    Sleep  2s

Input Time
    [Arguments]   ${TODOTIME}
    Clear Text           newTodoTimeEditText
    Input Text           newTodoTimeEditText      ${TODOTIME}
    Sleep  2s
Click text data time
    Click Element        userToDoRemindMeTextView
    Sleep  2s
    
Verify name to do list
    [Arguments]   ${TODOTIME}
    Page Should Contain Text     ${TODOTIME}
    Sleep  2s


*** Test Cases ***
Create to do lists without notifications successful
    Open Test Application    ${REMOTE_URL}    ${PLATFORM_NAME}    ${DEVICE_TARGET}    ${DEVICE_NAME}    ${APP_PATH}    ${Automate_nmae}
    Click button Add To Do
    Enter text To Do List    ${TODOLIST}
    Click sent to do list        
    Verify To do list        ${TODOLIST}

Create to do lists without notifications unsuccessful
    Click button Add To Do
    Enter text To Do List    ${EMPTY}
    Click sent to do list    
    Verify To do list unsuccessful    ${TODOLIST2}

Update to do add notification successful.
    Select to do list on screen
    Clear Text to do
    Enter text To Do List    ${TODOLIST3}
    Click on notifications
    Input date        ${TODODATE}
    Input Time        ${TODOTIME}
    Click text data time
    Click sent to do list
    Verify name to do list    ${TODOLIST3}

Update to do add notification unsuccessful
    Select to do list on screen
    Clear Text to do
    Enter text To Do List    ${TODOLIST}
    Input date        ${EMPTY}
    Input Time        ${EMPTY}
    Click text data time
    Click sent to do list
    Verify name to do list    ${TODOLIST}

Delect to-do lists on screen successful
    Select Slide to do list on screen
    Verify To do list unsuccessful    ${TODOLIST}

    [Teardown]    Close Application