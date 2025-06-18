*** Settings ***
Library    Browser
Library    FakerLibrary

Suite Setup     New Browser    headless=false
Suite Teardown  Close Browser


