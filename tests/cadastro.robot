*** Settings ***
Documentation    Testes de cadastro de usuário (adm, comum e erro de email)

Resource         ../resources/base.resource

Suite Setup      Start Session
Suite Teardown   Take Screenshot

*** Test Cases ***

Cadastrar usuário administrador com dados válidos
    Gerar dados de usuário dinâmico para o cadastro
    Abrir página de cadastro
    Preencher formulário de cadastro    is_admin=True
    Enviar formulário de cadastro
    Verificar cadastro com sucesso de adm

Cadastrar usuário comum com dados válidos
    Gerar dados de usuário dinâmico para o cadastro
    Abrir página de cadastro
    Preencher formulário de cadastro
    Enviar formulário de cadastro
    Verificar cadastro com sucesso

Cadastrar usuário com e-mail já existente
    # Cadastra primeiro usuário
    Gerar dados de usuário dinâmico para o cadastro
    Abrir página de cadastro
    Preencher formulário de cadastro
    Enviar formulário de cadastro
    Verificar cadastro com sucesso

    # Tenta cadastrar novamente com o mesmo e-mail
    Abrir página de cadastro
    Preencher formulário de cadastro
    Enviar formulário de cadastro
    Verificar erro de e-mail já cadastrado