Dado('que estou logado como {string} e {string}') do |email, password|
    visit "/"
    find("input[placeholder='Seu e-email']").set email
    find("input[type=password]").set password
    click_button "Entrar"

    @email = email
end

Dado('que acesso o formulário de cdastro de anúncios') do
    click_button "Criar anúncio"
    expect(page).to have_css "#equipoForm"
end

Dado('que eu tenho o seguinte equipamento:') do |table|
    @anuncio = table.rows_hash
    MongoDB.new.remove_equipo(@anuncio[:nome], @email)
end

Quando('submeto o cadastro desse item') do
    find("input[placeholder$=equipamento]").set @anuncio[:nome]
    find("#category").find('option', text: @anuncio[:categoria]).select_option
    find("input[placeholder^=Valor]").set @anuncio[:preco]
    imagem = Dir.pwd + "/features/support/fixtures/images/" + @anuncio[:imagem]
    find("#thumbnail>input[type=file]", visible: false).set imagem
    click_button "Cadastrar"
end

Então('devo ver esse item no meu Dashboard') do
    anuncios = find(".equipo-list")
    expect(anuncios).to have_content @anuncio[:nome]
    expect(anuncios).to have_content "R$#{@anuncio[:preco]}/dia"
end