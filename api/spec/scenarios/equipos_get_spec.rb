#encoding: utf-8

describe "GET /equipos/{equipo_id}" do
  before(:all) do
    payload = { email: "equipo.get.id@userrocklov.com", password: "qwe#3ewq" }
    result = Sessions.new.login(payload)
    @user_id = result.parsed_response["_id"]
  end
  context "obter anuncio unico" do
    before(:all) do
      @payload = {
        thumbnail: Helpers::get_thumb("violino.jpg"),
        name: "Violino",
        category: "Cordas",
        price: 230,
      }
      MongoDB.new.remove_equipo(@payload[:name], @user_id)
      equipo = Equipos.new.create(@payload, @user_id)
      @equipo_id = equipo.parsed_response["_id"]
      @result = Equipos.new.find_by_id(@equipo_id, @user_id)
    end
    it "deve retornar status code 200" do
      expect(@result.code).to eql 200
    end
    it "deve retornar nome" do
      expect(@result.parsed_response).to include("name" => @payload[:name])
    end
  end

  context "anuncio inexistente" do
    before(:all) do
      @result = Equipos.new.find_by_id(MongoDB.new.get_mongo_id, @user_id)
    end
    it "deve retornar status code 404" do
      expect(@result.code).to eql 404
    end
  end
end

describe "GET /equipos" do
  before(:all) do
    payload = { email: "equipos.get@userrocklov.com", password: "qwe#3ewq" }
    result = Sessions.new.login(payload)
    @user_id = result.parsed_response["_id"]
  end

  context "obter lista de anuncios" do
    before(:all) do
      payloads = [
        {
          thumbnail: Helpers::get_thumb("violino.jpg"),
          name: "Violino",
          category: "Cordas",
          price: 230,
        },
        {
          thumbnail: Helpers::get_thumb("kramer.jpg"),
          name: "Kramer EVH",
          category: "Cordas",
          price: "299",
        },
        {
          thumbnail: Helpers::get_thumb("baixo.jpg"),
          name: "Contra Baixo",
          category: "Cordas",
          price: "59",
        },
        {
          thumbnail: Helpers::get_thumb("mic.jpg"),
          name: "Microfone",
          category: "Áudio e Tecnologia".force_encoding("ASCII-8BIT"),
          price: 140,
        },
      ]

      payloads.each do |payload|
        MongoDB.new.remove_equipo(payload[:name], @user_id)
        Equipos.new.create(payload, @user_id)
      end

      @result = Equipos.new.list(@user_id)
    end

    it "deve retornar status code 200" do
      expect(@result.code).to eql 200
    end

    it "deve retornar uma lista de anuncios" do
      expect(@result.parsed_response).not_to be_empty
    end
  end
end
