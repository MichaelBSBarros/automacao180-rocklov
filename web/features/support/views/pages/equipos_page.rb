class EquiposPage
  include Capybara::DSL

  def create(equipo)
    page.has_css?("#equipoForm")

    find("input[placeholder$=equipamento]").set equipo[:nome]
    find("input[placeholder^=Valor]").set equipo[:preco]
    select_cat(equipo[:categoria]) if equipo[:categoria].length > 0
    upload(equipo[:imagem]) if equipo[:imagem].length > 0

    click_button "Cadastrar"
  end

  def upload(file_name)
    imagem = Dir.pwd + "/features/support/fixtures/images/" + file_name
    find("#thumbnail>input[type=file]", visible: false).set imagem
  end

  def select_cat(cat)
    find("#category").find("option", text: cat).select_option
  end
end
