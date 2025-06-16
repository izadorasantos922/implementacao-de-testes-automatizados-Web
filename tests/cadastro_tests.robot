*** Settings ***
Documentation        Cenários de teste para o cadatro de usuários do site Serverest
Library              Browser
Library              FakerLibrary

*** Variables ***
&{USER}

*** Keywords ***
GERAR DADOS DE USUARIO DINAMICO
    ${username}=           FakerLibrary.Name
    ${email}=              FakerLibrary.Email
    ${password}=           FakerLibrary.Password
    Set Suite Variable     &{USER}        name=${username}    email=${email}    password=${password}
    

*** Test Cases ***
CENARIO: Cadastrar Usuario Dados Válidos
    [Tags]        CADASTRO

    # Gerando usuário de massa Dinãmica
    GERAR DADOS DE USUARIO DINAMICO

    # Acessando a página
    New Browser        browser=chromium    headless=False
    New Page           https://front.serverest.dev/cadastrarusuarios

    # Verifica se estou ná pagina correta
    Wait For Elements State    css=h2    visible    5
    Get Text                   css=h2    equal      Cadastro

    # Preencher os campos
    Fill Text    id=nome        ${USER.name}
    Fill Text    id=email       ${USER.email}
    Fill Text    id=password    ${USER.password}

    # Clicando em cadastrar
    Click        button[data-testid="cadastrar"]

    # Validando se usuário foi cadastrado com sucesso
    Wait For Elements State    css=h1    visible    5
    Get Text                   css=h1    equal      Serverest Store

CENARIO: Cadastrar Usuario com Email Já Cadastrado

    # Acessando a página
    New Browser        browser=chromium    headless=False
    New Page           https://front.serverest.dev/cadastrarusuarios

    # Verifica se estou ná pagina correta
    Wait For Elements State    css=h2    visible    5
    Get Text                   css=h2    equal      Cadastro

    # Preencher os campos
    Fill Text    id=nome        ${USER.name}
    Fill Text    id=email       ${USER.email}
    Fill Text    id=password    ${USER.password}

    # Clicando em cadastrar
    Click        button[data-testid="cadastrar"]

    # Validando pop-up de erro
    Wait For Elements State    xpath=//*[@id="root"]/div/div/form/div[1]/span    visible    5
    Get Text                   xpath=//*[@id="root"]/div/div/form/div[1]/span    equal      Este email já está sendo usado