class Alert
  include Capybara::DSL

  def dark
    return find(".alert.alert-dark").text
  end
end
