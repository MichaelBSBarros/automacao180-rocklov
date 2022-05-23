describe "POST /sessions" do
  context "login com sucesso" do
    before(:all) do
      payload = { email: "session.login@userrocklov.com", password: "qwe#3ewq" }
      @result = Sessions.new.login(payload)
    end
    it "deve retornar status code 200" do
      expect(@result.code).to eql 200
    end
    it "deve retornar id de usuário" do
      expect(@result.parsed_response["_id"].length).to eql 24
    end
  end

  exemples = Helpers::get_fixture("login")

  exemples.each do |e|
    context "#{e[:title]}" do
      before(:all) do
        @result = Sessions.new.login(e[:payload])
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
