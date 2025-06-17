*** Settings ***
Library           Browser
Library           FakerLibrary
Library           Collections
Library           String

*** Keywords ***
Conectar Servicos
    [Documentation]    Inicia a conexão com a API
    [Arguments]    ${URL_API}
    Create Session    serverest    ${URL_API}
    Log To Console    Serviços conectados

Encerrar Servicos
    [Documentation]    Encerra todas as conexões
    Delete All Sessions
    Log To Console    Serviços encerrados

Cadastrar Usuario Valido
    [Documentation]    Cria um usuário aleatório válido
    ...    Example:
    ...    | ${email} | ${senha} | = | Cadastrar Usuario Valido |
    ${nome}=    FakerLibrary.Name
    ${email}=   FakerLibrary.Email
    ${senha}=   FakerLibrary.Password    length=8

    &{headers}=     Create Dictionary    Content-Type=application/json
    &{user_data}=   Create Dictionary
    ...    nome=${nome}
    ...    email=${email}
    ...    password=${senha}
    ...    administrador=false

    ${resp}=    POST On Session    serverest    /usuarios    headers=${headers}    json=${user_data}
    Should Be Equal As Strings    ${resp.status_code}    201
    Log To Console    Usuário criado: ${email}

    RETURN    ${email}    ${senha}

Logar No Frontend
    [Documentation]    Realiza login no frontend
    ...    Example:
    ...    | Logar No Frontend | ${email} | ${senha} | ${should_fail}=False |
    [Arguments]    ${email}    ${senha}    ${should_fail}=False

    New Browser    browser=chromium    headless=False
    New Page       ${URL_FRONT}/login

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

    Run Keyword If    ${should_fail}
    ...    Should Be False    ${login_sucesso}    Login indevidamente aceito com senha inválida

    Close Browser

Capturar Screenshot
    [Documentation]    Captura screenshot com nome descritivo
    [Arguments]    ${nome_arquivo}
    ${timestamp}=    Get Current Date    result_format=%Y%m%d_%H%M%S
    Create Directory    ${OUTPUT_DIR}${/}screenshots
    Take Screenshot    
    ...    filename=${OUTPUT_DIR}${/}screenshots${/}${nome_arquivo}_${timestamp}.png    
    ...    fullPage=True