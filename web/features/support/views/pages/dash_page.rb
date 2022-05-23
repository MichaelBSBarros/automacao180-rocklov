class DashPage
  include Capybara::DSL

  def goto_eqipo_form
    click_button "Criar anúncio"
  end

  def equipo_list
    return find(".equipo-list")
  end

  def on_dash?
    return page.has_css?(".dashboard")
  end
end
