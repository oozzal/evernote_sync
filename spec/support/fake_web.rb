RSpec.configure do |config|
  config.before :each do
    FakeWeb.allow_net_connect = false
    FakeWeb.register_uri(:any, 'http://www.evernote.com', :body => '')
    FakeWeb.register_uri(:any, 'https://www.evernote.com', :body => '')
  end

  config.after :each do
    FakeWeb.clean_registry
    FakeWeb.allow_net_connect = true
  end

end

