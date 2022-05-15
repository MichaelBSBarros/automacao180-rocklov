#language: pt

@cadastro
Funcionalidade: Cadastro

    Sendo um músico que possui equipamentos musicais
    Quero fazer o meu cadastro no RockLov
    Para que eu possa disponibilizá-los para locação

    @cadastro_ok
    Cenario: Fazer cadastro
        Dado que acesso a página de cadastro
        Quando submeto o seguinte formulario de cadastro:
            | nome        | email                 | senha       |
            | Massa Teste | massa.teste@email.com | #Mt1903mqn% |
        Então sou redirecionado para o Dashboard

    @cadastro_nok
    Esquema do Cenário: Tentativa de Cadastro
        Dado que acesso a página de cadastro
        Quando submeto o seguinte formulario de cadastro:
            | nome         | email         | senha         |
            | <nome_input> | <email_input> | <senha_input> |
        Então vejo a mensagem de alerta: "<mensagem_output>"

        Exemplos:
            | nome_input  | email_input           | senha_input | mensagem_output                  |
            |             | massa.teste@email.com | #Mt1903mqn% | Oops. Informe seu nome completo! |
            | Massa Teste |                       | #Mt1903mqn% | Oops. Informe um email válido!   |
            | Massa Teste | massa teste.com       | #Mt1903mqn% | Oops. Informe um email válido!   |
            | Massa Teste | massa.teste.com       | #Mt1903mqn% | Oops. Informe um email válido!   |
            | Massa Teste | massa.teste@email     | #Mt1903mqn% | Oops. Informe um email válido!   |
            | Massa Teste | massa.teste@email.com |             | Oops. Informe sua senha secreta! |
