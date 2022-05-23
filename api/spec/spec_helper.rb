require_relative "routes/equipos"
require_relative "routes/sessions"
require_relative "routes/signup"
require_relative "helpers"
require_relative "libs/mongo"
require "digest/md5"

def to_md5(pass)
  return Digest::MD5.hexdigest(pass)
end

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.shared_context_metadata_behavior = :apply_to_host_groups

  config.before(:suite) do
    users = [
      { name: "Locatario Booking", email: "locatario.booking@userrocklov.com", password: to_md5("qwe#3ewq") },
      { name: "Locador Booking", email: "locador.booking@userrocklov.com", password: to_md5("qwe#3ewq") },
      { name: "Login Teste", email: "session.login@userrocklov.com", password: to_md5("qwe#3ewq") },
      { name: "Equipos Get", email: "equipos.get@userrocklov.com", password: to_md5("qwe#3ewq") },
      { name: "Equipo Get By Id", email: "equipo.get.id@userrocklov.com", password: to_md5("qwe#3ewq") },
      { name: "Equipo Delete", email: "equipo.delete@userrocklov.com", password: to_md5("qwe#3ewq") },
      { name: "Equipo Post", email: "equipo.post@userrocklov.com", password: to_md5("qwe#3ewq") },
    ]

    MongoDB.new.drop_danger
    MongoDB.new.insert_users(users)
  end
end
