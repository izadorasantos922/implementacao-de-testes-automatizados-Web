*** Settings ***
Documentation        Cenários da lista de compras sendo um usuário padrão
Library              Collections
Resource             ../../resources/base.resource

Test Setup           Start Session
Test Teardown        Take Screenshot

*** Test Cases ***
Deve poder adicionar um produto na lista de compras
    #Fluxo para cadastrar um produto para o cenário de teste
    Cadastro e Login com sucesso usuário adm
    Resetar produto cadastrado

    #keywords para realizar o cenário de teste
    Cadastro e Login com sucesso usuário
    Ir para a página de lista de compras
    Ir para a página inicial escolher o produto
    Escolher produto para adicionar a lista
    Verificar se produto está na lista