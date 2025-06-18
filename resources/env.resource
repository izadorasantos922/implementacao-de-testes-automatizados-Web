*** Settings ***
Documentation        Variáveis globais e configurações de ambiente

*** Variables ***
${BASE_URL}        https://compassuolfront.serverest.dev

${LOGIN_EMAIL}            testeqa@email.com
${LOGIN_SENHA_CORRETA}    123456
${LOGIN_SENHA_ERRADA}     senha_errada_qa123
${TIMEOUT}                2s
${SCREENSHOT_DIR}         ${EXECDIR}${/}results${/}screenshots