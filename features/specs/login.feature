#language: pt

@login
Funcionalidade: Login
    Sendo um usuário cadastrado
    Quero acessar o sistema da Rocklov
    Para que eu possa anunciar meus equipamentos musicais

    @login_ok
    Cenario: Login do usuário
        Dado que acesso a página principal
        Quando submeto minhas credenciais com "massa.teste@login.com" e "n10Q@mt*a16"
        Então sou redirecionado para o Dashboard

    @login_nok
    Esquema do Cenario: Tentativa de Login
        Dado que acesso a página principal
        Quando submeto minhas credenciais com "<email_input>" e "<senha_input>"
        Então vejo a mensagem de alerta: "<mensagem_output>"

        Exemplos:
            | email_input           | senha_input | mensagem_output                  |
            | massa.teste@login.com | #Mt1903mqn% | Usuário e/ou senha inválidos.    |
            | massa.teste@email.com | n10Q@mt*a16 | Usuário e/ou senha inválidos.    |
            |                       | n10Q@mt*a16 | Oops. Informe um email válido!   |
            | massa.teste.com       | n10Q@mt*a16 | Oops. Informe um email válido!   |
            | massa.teste@email     | n10Q@mt*a16 | Oops. Informe um email válido!   |
            | massa.teste@login.com |             | Oops. Informe sua senha secreta! |
