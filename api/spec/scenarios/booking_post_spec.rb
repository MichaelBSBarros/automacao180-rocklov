describe "POST /equipos/{equipo_id}/bookings" do
  before(:all) do
    locatario = { email: "locatario.booking@userrocklov.com", password: "qwe#3ewq" }
    result = Sessions.new.login(locatario)
    @locatario_id = result.parsed_response["_id"]
  end
  context "solicitar locacao" do
    before(:all) do
      # dado que o usuario locador tem um equipamento para locacao
      locador = { email: "locador.booking@userrocklov.com", password: "qwe#3ewq" }
      result = Sessions.new.login(locador)
      locador_id = result.parsed_response["_id"]
      instrumento = {
        thumbnail: Helpers::get_thumb("fender-sb.jpg"),
        name: "Fender",
        category: "Cordas",
        price: 165,
      }
      MongoDB.new.remove_equipo(instrumento[:name], locador_id)
      result = Equipos.new.create(instrumento, locador_id)
      instrumento_id = result.parsed_response["_id"]

      # quando o usuario locatario solicitar a locacao do equipamento
      @result = Equipos.new.booking(instrumento_id, @locatario_id)
    end

    # entao deve ser realizada a locacao
    it "deve retornar o status code 200" do
      expect(@result.code).to eql 200
    end
  end
end
