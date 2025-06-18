*** Settings ***
Documentation    Ações e elementos da página de login

Library          Browser
Library          DateTime
Library          RequestsLibrary
Library          BuiltIn

Resource         ../env.resource
Resource         ../base.resource
Resource         ../pages/CadastroPage.resource

*** Keywords ***
Abrir página de login
    New Page    ${BASE_URL}/login
    Wait For Elements State    css=h1    visible    5
    Get Text                   css=h1    equal    Login

Preencher login
    [Arguments]    ${email}    ${senha}
    Fill Text    css=[data-testid="email"]    ${email}
    Fill Text    css=[data-testid="senha"]    ${senha}

Enviar login
    Click    data-testid=entrar

Verificar login com sucesso
    Wait For Elements State    css=h1    visible    5
    Get Text                   css=h1    equal      Serverest Store

Verificar login de adm com sucesso
    Wait For Elements State    css=h1    visible    5
    Get Text                   css=h1    equal    Bem Vindo ${USER.name}

Fazer Logout
    Take Screenshot    filename=${SCREENSHOT_DIR}${/}before_logout.png
    Click              data-testid=logout
    Wait For Elements State    css=h1 >> text=Login    visible    timeout=${TIMEOUT}
    Take Screenshot    filename=${SCREENSHOT_DIR}${/}after_logout.png

Capturar Tela do Login
    [Arguments]    ${prefixo}
    ${timestamp}=    Get Current Date    result_format=%Y%m%d_%H%M%S
    Create Directory    ${SCREENSHOT_DIR}
    Take Screenshot    
    ...    filename=${SCREENSHOT_DIR}${/}${prefixo}_${timestamp}.png    
    ...    fullPage=True

Conectar Servicos
    [Documentation]    Inicia a conexão com a API
    [Arguments]    ${URL_API}
    Create Session    serverest    ${URL_API}
    Log To Console    Serviços conectados

Encerrar Servicos
    [Documentation]    Encerra todas as conexões
    Delete All Sessions
    Log To Console    Serviços encerrados

Logar No Frontend
    [Documentation]    Realiza login no frontend
    ...    Example:
    ...    | Logar No Frontend | ${email} | ${senha} | ${should_fail}=False |
    [Arguments]    ${email}    ${senha}    ${should_fail}=False

    New Browser    browser=chromium    headless=False
    New Page       ${BASE_URL}/login

    Wait For Elements State    id=email    visible    ${TIMEOUT}
    Fill Text      id=email       ${email}
    Fill Text      id=password    ${senha}
    Click          css=button[data-testid="entrar"]

    ${login_sucesso}=    Run Keyword And Return Status
    ...    Wait For Elements State    css=h1 >> text=Serverest    visible    ${TIMEOUT}

    Run Keyword If    not ${login_sucesso}
    ...    Take Screenshot    fullPage=True    filename=results/${email}_erro.png

    Run Keyword If    not ${should_fail}
    ...    Should Be True    ${login_sucesso}    Falha ao logar no frontend com credenciais válidas

    Run Keyword If    ${should_fail} and  ${login_sucesso}    
    ...    Fail     Login indevidamente aceito com senha inválida

    Close Browser

Capturar Screenshot
    [Documentation]    Captura screenshot com nome descritivo
    [Arguments]    ${nome_arquivo}
    ${timestamp}=    Get Current Date    result_format=%Y%m%d_%H%M%S
    Create Directory    ${OUTPUT_DIR}${/}screenshots
    Take Screenshot    
    ...    filename=${OUTPUT_DIR}${/}screenshots${/}${nome_arquivo}_${timestamp}.png    
    ...    fullPage=True