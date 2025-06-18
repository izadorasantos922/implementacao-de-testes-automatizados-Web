# Testes Frontend - ServeRest com Robot Framework

Este repositório contém os testes automatizados de interface (frontend) da aplicação ServeRest, desenvolvidos com Robot Framework utilizando a biblioteca Playwright. Os testes têm como objetivo validar os principais fluxos da aplicação web com foco em cenários de cadastro, login, administração de produtos e lista de compras.

## Tecnologias Utilizadas

- Robot Framework
- Playwright
- Python 3.10+
- Visual Studio Code
- Git e GitHub

## Estrutura do Projeto

```
.
├── logs/               # Relatórios de execução gerados automaticamente
├── resources/          # Arquivos com keywords reutilizáveis
├── tests/              # Casos de teste organizados por funcionalidade
└── README.md
```

## Como Executar

Para rodar os testes:

```bash
robot -d ./logs tests/
```

Os relatórios de execução estarão disponíveis na pasta `logs/`, incluindo os arquivos `log.html`, `report.html` e `output.xml`.

## Responsabilidades por Integrante

**Gabriel**  
Responsável pelos testes da funcionalidade de cadastro.  
- Cadastro de usuário com dados válidos  
- Cadastro de usuário com e-mail já existente

**Thaís**  
Responsável pelos testes da funcionalidade de login.  
- Login com credenciais válidas  
- Login com credenciais inválidas

**Izadora**  
Responsável pelas funcionalidades de administrador.  
- Cadastro de administrador  
- Login como administrador

**Raique**  
Responsável pelos testes de gerenciamento de produtos.  
- Cadastro de novos produtos como administrador  
- Adição de produto à lista de compras  
- Visualização da lista de compras

## Aprendizados

- Prática do fluxo de versionamento colaborativo com Gitflow  
- Automação de testes frontend com Robot Framework  
- Implementação de testes de regressão reutilizando componentes e keywords

## Dificuldades Encontradas

- Integração final do projeto apresentou conflitos de arquivos devido à similaridade entre nomes de keywords implementadas separadamente por diferentes integrantes. Foi necessário refatorar e padronizar os nomes para garantir compatibilidade e manutenção.

## Status do Projeto

Todos os testes planejados foram implementados e executados com sucesso. Como melhorias futuras, recomenda-se:

- Maior padronização na nomenclatura de keywords  
- Separação por camadas (páginas, ações e validações)  
- Integração com pipeline de CI/CD para execução automática