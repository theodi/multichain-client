require 'vcr'

VCR.configure do |c|
  c.cassette_library_dir = 'spec/support/vcr'
  c.hook_into :webmock
  c.default_cassette_options = { :record => :once }
  c.allow_http_connections_when_no_cassette = false
  c.configure_rspec_metadata!

  [
    'RPC_USER',
    'RPC_PASSWORD',
    'RPC_HOST',
    'RPC_PORT'
  ].each do |env_var|
    c.filter_sensitive_data("<#{env_var}>") { ENV[env_var] }
  end
end
