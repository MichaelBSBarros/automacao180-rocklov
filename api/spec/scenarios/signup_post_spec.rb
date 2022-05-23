describe "POST /signup" do
  context "cadastrar novo usuario" do
    before(:all) do
      payload = { name: "Novo Usuario", email: "cadastro.usuario@userrocklov.com", password: "qwe#3ewq" }
      MongoDB.new.remove_user(payload[:email])
      @result = Signup.new.create(payload)
    end
    it "deve retornar status code 200" do
      expect(@result.code).to eql 200
    end
    it "deve retornar id de usuário" do
      expect(@result.parsed_response["_id"].length).to eql 24
    end
  end

  #   context "usuario ja existente" do
  #     before(:all) do
  #       payload = { name: "Massa Teste", email: "massa.ad.teste@cadastro.com", password: "KhpT#a1935" }
  #       Signup.new.create(payload)
  #       @result = Signup.new.create(payload)
  #       MongoDB.new.remove_user(payload[:email])
  #     end
  #     it "valida status code 409" do
  #       expect(@result.code).to eql 409
  #     end
  #     it "valida mensagem de retorno 'Email already exists :('" do
  #       expect(@result.parsed_response["error"]).to eql "Email already exists :("
  #     end
  #   end

  exemples = Helpers::get_fixture("signup")

  exemples.each do |e|
    context "#{e[:title]}" do
      before(:all) do
        Signup.new.create(e[:payload]) if e[:code] == 409
        @result = Signup.new.create(e[:payload])
        MongoDB.new.remove_user(e[:email]) if e[:code] == 409
      end
      it "deve retornar status code #{e[:code]}" do
        expect(@result.code).to eql e[:code]
      end
      it "deve retornar mensagem de retorno '#{e[:error]}'" do
        expect(@result.parsed_response["error"]).to eql e[:error]
      end
    end
  end
end
