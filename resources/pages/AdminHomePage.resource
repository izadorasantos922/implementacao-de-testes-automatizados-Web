*** Settings ***
Documentation        Ações e elementos na página home sendo admin
Library              Browser
Resource             ../env.resource
Resource             ../base.resource

*** Keywords ***
Ir para a página de cadastro de produtos
    Go To    ${BASE_URL}/admin/cadastrarprodutos
    #Checkpoint
    Wait For Elements State    css=h1    visible    10
    Get Text                   css=h1    equal      Cadastro de Produtos
Preencher dados e cadastrar produto
    ${data}    Get Fixture    tasks    novo_produto

    ${prec}      Convert To Number        ${data}[preco]
    ${quant}     Convert To Number        ${data}[quantidade]

    Fill Text    data-testid=nome         ${data}[name]
    Fill Text    data-testid=preco        ${prec}
    Fill Text    data-testid=descricao    ${data}[descricao]
    Fill Text    data-testid=quantity     ${quant}

    Click    data-testid=cadastarProdutos
Verificar se produto foi cadastrado
    ${data}            Get Fixture     tasks    novo_produto
    ${nome_produto}    Set Variable    ${data}[name]

    Wait For Elements State    css=.table.table-striped tbody tr td:has-text("${nome_produto}")    visible    5
Ir para a página de lista de produtos
    Go To    ${BASE_URL}/admin/listarprodutos
    #Checkpoint
    Wait For Elements State    css=h1    visible    5
    Get Text                   css=h1    equal      Lista dos Produtos
Remover produto cadastrado
    ${data}    Get Fixture    tasks    novo_produto
    ${name_produto}    Set Variable    ${data}[name]
    
    ${produto_existe}=    Run Keyword And Return Status    
    ...    Wait For Elements State    css=.table.table-striped tbody tr td:has-text("${name_produto}")    
    ...    visible    3
    
    Run Keyword If    ${produto_existe}    
    ...    Click    css=tr:has(td:has-text("${name_produto}")) >> xpath=.//button[contains(@class, "btn-danger")]