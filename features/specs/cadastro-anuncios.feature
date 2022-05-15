#language: pt

@cadastro_anuncios
Funcionalidade: Cadastro Anuncios

    Sendo um usuário cadastrado no RockLov que possui equipamentos musicais
    Quero adastrar meus equipamentos
    Para que eu possa disponibilizá-los para locação

    Cenario: Novo Equipo
        Dado que estou logado como 'massa.teste@anuncios.com' e 'KKuS^m4EkQg'
            E que acesso o formulário de cdastro de anúncios
            E que eu tenho o seguinte equipamento:
            | nome      | Fender Strato |
            | categoria | Cordas        |
            | preco     | 200           |
            | imagem    | fender-sb.jpg |
        Quando submeto o cadastro desse item
        Então devo ver esse item no meu Dashboard