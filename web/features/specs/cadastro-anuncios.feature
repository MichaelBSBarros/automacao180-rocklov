#language: pt

@cadastro_anuncios
Funcionalidade: Cadastro Anuncios

    Sendo um usuário cadastrado no RockLov que possui equipamentos musicais
    Quero adastrar meus equipamentos
    Para que eu possa disponibilizá-los para locação

    Contexto: login
        * Login com 'massa.teste@anuncios.com' e 'KKuS^m4EkQg'

    @cad_anuncio_ok
    Cenario: Novo Equipo
        Dado que acesso o formulário de cdastro de anúncios
            E que eu tenho o seguinte equipamento:
            | nome      | Fender Strato |
            | categoria | Cordas        |
            | preco     | 200           |
            | imagem    | fender-sb.jpg |
        Quando submeto o cadastro desse item
        Então devo ver esse item no meu Dashboard

    @cad_anuncio_nok
    Esquema do Cenário: Tentativa de cadastro de anúncios
        Dado que acesso o formulário de cdastro de anúncios
            E que eu tenho o seguinte equipamento:
            | nome      | <nome>      |
            | categoria | <categoria> |
            | preco     | <preco>     |
            | imagem    | <imagem>    |
        Quando submeto o cadastro desse item
        Então deve conter a mensagem de alerta: "<alerta>"

        Exemplos:
            | nome              | categoria | preco | imagem        | alerta                              |
            | Fender Strato     | Cordas    | 200   |               | Adicione uma foto no seu anúncio!   |
            |                   | Outros    | 250   | clarinete.jpg | Informe a descrição do anúncio      |
            | Microfone Shure   |           | 100   | mic.jpg       | Informe a categoria                 |
            | Trompete Clássico | Outros    |       | trompete.jpg  | Informe o valor da diária           |
            | Conga             | Outros    | abc   | conga.jpg     | O valor da diária deve ser numérico |
            | Conga             | Outros    | 10c   | conga.jpg     | O valor da diária deve ser numérico |