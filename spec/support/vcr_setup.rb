require 'vcr'

VCR.configure do |c|
  c.cassette_library_dir = 'spec/support/vcr'
  c.hook_into :webmock
  c.default_cassette_options = { :record => :once }
  c.allow_http_connections_when_no_cassette = false
  c.configure_rspec_metadata!
end
