*** Settings ***
Documentation        Ações e elementos da página de Lista de Compras
Library              Browser
Resource             ../env.resource
Resource             ../base.resource

*** Keywords ***
Ir para a página de lista de compras
    Go To    ${BASE_URL}/minhaListaDeProdutos
    #Checkpoint
    Wait For Elements State    css=h1    visible    5
    Get Text                   css=h1    equal      Lista de Compras
Ir para a página inicial escolher o produto
    Wait For Elements State    data-testid=paginaInicial    visible    5
    Click                      data-testid=paginaInicial

Escolher produto para adicionar a lista
    ${data}    Get Fixture    tasks    novo_produto
    ${nome_produto}    Set Variable    ${data}[name]
    
    Wait For Elements State    
    ...    css=.card-title.negrito >> text=${nome_produto}   
    ...    visible    5

    Click    css=h5.card-title.negrito:text("${nome_produto}") ~ div button[data-testid='adicionarNaLista']
Verificar se produto está na lista
    ${data}    Get Fixture    tasks    novo_produto
    ${name_produto}    Set Variable    ${data}[name]

    Wait For Elements State    data-testid=shopping-cart-product-name    
    ...    visible    5
    Get Text    
    ...    data-testid=shopping-cart-product-name    
    ...    equal    Produto:${name_produto}