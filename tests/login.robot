*** Settings ***
Documentation    Teste de login com usuário recém-cadastrado

Resource         ../resources/base.resource

Suite Setup      Start Session And Connect API
Suite Teardown   Take Screenshot And Close API

*** Keywords ***
Start Session And Connect API
    Start Session
    Conectar Servicos    https://serverest.dev
    
Take Screenshot And Close API
    Take Screenshot
    Encerrar Servicos

*** Test Cases ***
Login com usuário adm
    # Gerar e cadastrar o usuário
    Gerar dados de usuário dinâmico para o cadastro
    Abrir página de cadastro
    Preencher formulário de cadastro    is_admin=True
    Enviar formulário de cadastro
    Verificar cadastro com sucesso de adm

    # Fazer login com os dados cadastrados
    Abrir página de login
    Preencher login    ${USER.email}    ${USER.password}
    Enviar login
    Verificar login de adm com sucesso

Login com credenciais válidas
    [Documentation]    Teste de login válido com captura de tela antes e depois
    # Cadastrar um usuário primeiro
    Gerar dados de usuário dinâmico para o cadastro
    Abrir página de cadastro
    Preencher formulário de cadastro
    Enviar formulário de cadastro
    Verificar cadastro com sucesso

    # Fazer login com as credenciais geradas
    Abrir página de login
    Capturar Tela do Login    pre_login
    Wait For Elements State    css=h1 >> text=Login    visible    timeout=${TIMEOUT}
    Preencher login    ${USER.email}    ${USER.password}
    Capturar Tela do Login     pre_submit
    Click                      data-testid=entrar
    Wait For Elements State    css=h1 >> text=Serverest    visible    timeout=${TIMEOUT}

Login com senha inválida
    [Documentation]    Teste de login inválido com captura de tela do erro
    
    Gerar dados de usuário dinâmico para o cadastro
    Abrir página de cadastro
    Preencher formulário de cadastro
    Enviar formulário de cadastro
    Verificar cadastro com sucesso

    Abrir página de login
    Capturar Tela do Login    pre_login_invalido
    Wait For Elements State    css=h1 >> text=Login    visible    timeout=${TIMEOUT}
    Fill Text    id=email       ${USER.email}
    Fill Text    id=password    senha_incorreta_123
    Capturar Tela do Login     pre_submit_invalido
    Click                      data-testid=entrar
    Wait For Elements State    css=div.alert    visible    timeout=${TIMEOUT}
    Capturar Tela do Login     erro_login
    ${alerta}=    Get Text     css=div.alert
    Should Contain    ${alerta}    Email e/ou senha inválidos