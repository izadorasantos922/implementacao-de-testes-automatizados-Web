*** Keywords ***

Abrir página de login
    New Page    https://front.serverest.dev/login
    Wait For Elements State    css=h1    visible    5
    Get Text    css=h1    equal    Login

Preencher login
    [Arguments]    ${email}    ${senha}
    Fill Text    css=[data-testid="email"]    ${email}
    Fill Text    css=[data-testid="senha"]    ${senha}

Enviar login
    Click    css=[data-testid="entrar"]

Verificar login com sucesso
    Wait For Elements State    css=h1    visible    5
    Get Text                   css=h1    equal    Serverest Store
