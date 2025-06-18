*** Keywords ***

Abrir página de cadastro
    New Page    https://front.serverest.dev/cadastrarusuarios
    Wait For Elements State    css=h2    visible    5
    Get Text    css=h2    equal    Cadastro

Gerar dados de usuário dinâmico
    ${username}=    FakerLibrary.Name
    ${email}=       FakerLibrary.Email
    ${password}=    FakerLibrary.Password
    Set Suite Variable    &{USER}    name=${username}    email=${email}    password=${password}

Preencher formulário de cadastro
    [Arguments]    ${is_admin}=False
    Fill Text    id=nome        ${USER.name}
    Fill Text    id=email       ${USER.email}
    Fill Text    id=password    ${USER.password}
    Run Keyword If    '${is_admin}'=='True'    Clicar checkbox administrador

Clicar checkbox administrador
    Click    css=input[data-testid="checkbox"]

Enviar formulário de cadastro
    Click    css=button[data-testid="cadastrar"]

Verificar cadastro com sucesso
    Wait For Elements State    css=h1    visible    5
    Get Text                   css=h1    equal    Serverest Store

Verificar cadastro com sucesso de adm
    Wait For Elements State    css=h1    visible    5
    Get Text                   css=h1    equal    Bem Vindo ${USER.name}

Verificar erro de e-mail já cadastrado
    Wait For Elements State    xpath=//*[@id="root"]/div/div/form/div[1]/span    visible    5
    Get Text                   xpath=//*[@id="root"]/div/div/form/div[1]/span    equal    Este email já está sendo usado
