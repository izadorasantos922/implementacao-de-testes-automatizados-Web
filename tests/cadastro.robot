*** Settings ***
Documentation    Testes de cadastro de usuário (com e sem administrador)
Suite Setup      New Browser    browser=chromium    headless=False
Suite Teardown   Close Browser

Resource    ../resources/base.robot
Resource    ../resources/pages/CadastroPage.resource

*** Test Cases ***

Cadastrar usuário administrador com dados válidos
    Gerar dados de usuário dinâmico
    Abrir página de cadastro
    Preencher formulário de cadastro    is_admin=True
    Enviar formulário de cadastro
    Verificar cadastro com sucesso de adm
