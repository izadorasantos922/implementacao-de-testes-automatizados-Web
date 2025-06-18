*** Settings ***
Documentation        Librarys, resources e Keywords para ações globais

Library              Browser
Library              JSONLibrary

Resource             ../resources/env.resource

Resource             ../resources/pages/ShoppingListPage.resource
Resource             ../resources/pages/LoginPage.resource
Resource             ../resources/pages/SignupPage.resource
Resource             ../resources/pages/AdminHomePage.resource

*** Keywords ***
Start Session
    New Browser    browser=chromium    headless=False
    New Page       ${BASE_URL}

#Helpers
Get Fixture
    [Arguments]    ${file_name}    ${scenario}

    ${data}    Load Json From File    
    ...    ${EXECDIR}/resources/fixtures/${file_name}.json
    ...    encoding=utf-8

    RETURN    ${data}[${scenario}]

Cadastro e Login com sucesso usuário
    Gerar dados de usuário dinâmico
    Abrir página de cadastro
    Preencher formulário de cadastro    is_admin=False
    Enviar formulário de cadastro
    Verificar cadastro com sucesso

    Abrir página de login
    Preencher login    ${USER.email}    ${USER.password}
    Enviar login
    Verificar login com sucesso

Cadastro e Login com sucesso usuário adm
    Gerar dados de usuário dinâmico
    Abrir página de cadastro
    Preencher formulário de cadastro    is_admin=True
    Enviar formulário de cadastro
    Verificar cadastro com sucesso de adm

    Abrir página de login
    Preencher login    ${USER.email}    ${USER.password}
    Enviar login
    Verificar login de adm com sucesso

Resetar produto cadastrado
    Ir para a página de lista de produtos
    Remover produto cadastrado
    Ir para a página de cadastro de produtos
    Preencher dados e cadastrar produto
    Verificar se produto foi cadastrado