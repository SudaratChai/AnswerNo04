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
    Page Should Contain Text        ${TODOLIST}
    Sleep  2s

*** Test Cases ***
Create to do lists without notifications successful
    Open Test Application    ${REMOTE_URL}    ${PLATFORM_NAME}    ${DEVICE_TARGET}    ${DEVICE_NAME}    ${APP_PATH}    ${Automate_nmae}
    Click button Add To Do
    Enter text To Do List    ${TODOLIST}
    Click sent to do list        
    Verify To do list
    [Teardown]    Close Application