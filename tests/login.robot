*** Settings ***
Documentation    Teste de login com usuário recém-cadastrado
Suite Setup      New Browser    browser=chromium    headless=False
Suite Teardown   Close Browser

Resource    ../resources/base.robot
Resource    ../resources/pages/CadastroPage.resource
Resource    ../resources/pages/LoginPage.resource

*** Test Cases ***
Login com usuário adm
    # Gerar e cadastrar o usuário
    Gerar dados de usuário dinâmico
    Abrir página de cadastro
    Preencher formulário de cadastro
    Enviar formulário de cadastro
    Verificar cadastro com sucesso

    # Fazer login com os dados cadastrados
    Abrir página de login
    Preencher login    ${USER.email}    ${USER.password}
    Enviar login
    Verificar login com sucesso
