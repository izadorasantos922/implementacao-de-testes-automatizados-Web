*** Settings ***
Documentation     Testes de login no frontend do Serverest com captura de tela
Library           DateTime
Library           Browser
Library           OperatingSystem
Suite Setup       Abrir Navegador
Suite Teardown    Fechar Navegador

*** Variables ***
${URL_FRONT}              https://compassuolfront.serverest.dev/login
${LOGIN_EMAIL}            testeqa@email.com
${LOGIN_SENHA_CORRETA}    123456
${LOGIN_SENHA_ERRADA}     senha_errada_qa123
${TIMEOUT}                2s
${SCREENSHOT_DIR}         ${EXECDIR}${/}results${/}screenshots

*** Keywords ***
Abrir Navegador
    New Browser    chromium    headless=False
    New Page       ${URL_FRONT}
    # Garante que o diretório de screenshots existe
    Create Directory    ${SCREENSHOT_DIR}

Fechar Navegador
    Close Browser

Fazer Logout
    Take Screenshot    filename=${SCREENSHOT_DIR}${/}before_logout.png
    Click    css=button[data-testid="logout"]
    Wait For Elements State    css=h1 >> text=Login    visible    timeout=${TIMEOUT}
    Take Screenshot    filename=${SCREENSHOT_DIR}${/}after_logout.png

Capturar Tela do Login
    [Arguments]    ${prefixo}
    ${timestamp}=    Get Current Date    result_format=%Y%m%d_%H%M%S
    Create Directory    ${SCREENSHOT_DIR}
    Take Screenshot    
    ...    filename=${SCREENSHOT_DIR}${/}${prefixo}_${timestamp}.png    
    ...    fullPage=True

*** Test Cases ***
Login com credenciais válidas
    [Documentation]    Teste de login válido com captura de tela antes e depois
    Capturar Tela do Login    pre_login
    Wait For Elements State    css=h1 >> text=Login    visible    timeout=${TIMEOUT}
    Fill Text    id=email       ${LOGIN_EMAIL}
    Fill Text    id=password    ${LOGIN_SENHA_CORRETA}
    Capturar Tela do Login    pre_submit
    Click        css=button[data-testid='entrar']
    ${sucesso}=    Run Keyword And Return Status
    ...    Wait For Elements State    css=h1 >> text=Serverest    visible    timeout=${TIMEOUT}
    Run Keyword If    ${sucesso}    Capturar Tela do Login    pos_login_sucesso
    Should Be True    ${sucesso}    Falha ao logar com credenciais válidas
    Fazer Logout

Login com senha inválida
    [Documentation]    Teste de login inválido com captura de tela do erro
    Capturar Tela do Login    pre_login_invalido
    Wait For Elements State    css=h1 >> text=Login    visible    timeout=${TIMEOUT}
    Fill Text    id=email       ${LOGIN_EMAIL}
    Fill Text    id=password    ${LOGIN_SENHA_ERRADA}
    Capturar Tela do Login    pre_submit_invalido
    Click        css=button[data-testid='entrar']
    Wait For Elements State    css=div.alert    visible    timeout=${TIMEOUT}
    Capturar Tela do Login    erro_login
    ${alerta}=    Get Text    css=div.alert
    Should Contain    ${alerta}    Email e/ou senha inválidos