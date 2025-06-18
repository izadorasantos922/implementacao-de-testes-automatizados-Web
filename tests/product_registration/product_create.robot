*** Settings ***
Documentation        Cenários de cadastro de novos produtos sendo administrador
Library              Collections
Resource             ../../resources/base.resource

Test Setup           Start Session
Test Teardown        Take Screenshot

*** Test Cases ***
Deve poder cadastrar um novo produto sendo administrador
    Cadastro e Login com sucesso usuário adm
    Resetar produto cadastrado