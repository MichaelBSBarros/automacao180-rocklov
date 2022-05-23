#encoding: utf-8

describe "DELETE /equipos/{equipo_id}" do
  before(:all) do
    payload = { email: "equipo.delete@userrocklov.com", password: "qwe#3ewq" }
    result = Sessions.new.login(payload)
    @user_id = result.parsed_response["_id"]
  end
  context "deletar anuncio unico" do
    before(:all) do
      @payload = {
        thumbnail: Helpers::get_thumb("mic.jpg"),
        name: "Microfone",
        category: "Áudio e Tecnologia".force_encoding("ASCII-8BIT"),
        price: 140,
      }
      equipo = Equipos.new.create(@payload, @user_id)
      @equipo_id = equipo.parsed_response["_id"]
      @result = Equipos.new.remove_by_id(@equipo_id, @user_id)
    end
    it "deve retornar status code 204" do
      expect(@result.code).to eql 204
    end
  end

  context "anuncio inexistente" do
    before(:all) do
      @result = Equipos.new.remove_by_id(MongoDB.new.get_mongo_id, @user_id)
    end
    it "deve retornar status code 204" do
      expect(@result.code).to eql 204
    end
  end
end
