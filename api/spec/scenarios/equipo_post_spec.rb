describe "POST /equipos" do
  before(:all) do
    payload = { email: "equipo.post@userrocklov.com", password: "qwe#3ewq" }
    result = Sessions.new.login(payload)
    @user_id = result.parsed_response["_id"]
  end
  context "cadastrar novo equipo" do
    before(:all) do
      payload = {
        thumbnail: Helpers::get_thumb("kramer.jpg"),
        name: "Kramer EVH",
        category: "Cordas",
        price: "299",
      }
      @result = Equipos.new.create(payload, @user_id)
      MongoDB.new.remove_equipo(payload[:name], @user_id)
    end
    it "deve retornar status code 200" do
      expect(@result.code).to eql 200
    end
    it "deve retornar id de anuncio" do
      expect(@result.parsed_response["_id"].length).to eql 24
    end
  end

  context "nao autorizado" do
    before(:all) do
      payload = {
        thumbnail: Helpers::get_thumb("baixo.jpg"),
        name: "Contra Baixo",
        category: "Cordas",
        price: "59",
      }
      @result = Equipos.new.create(payload, nil)
    end
    it "deve retornar status code 401" do
      expect(@result.code).to eql 401
    end
    it "deve retornar mensagem 'Unauthorized'" do
      expect(@result.parsed_response["error"]).to eql "Unauthorized"
    end
  end
end
