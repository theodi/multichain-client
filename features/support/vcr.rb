require 'vcr'
require 'webmock/cucumber'
require 'aruba/cucumber'
require 'aruba/in_process'

VCR.configure do |c|
  c.default_cassette_options = { record: :once }
  c.cassette_library_dir = 'features/support/vcr'
  c.hook_into :webmock
  c.allow_http_connections_when_no_cassette = false
end

VCR.cucumber_tags do |t|
  t.tag '@vcr', use_scenario_name: true
end

class VcrFriendlyMain
  def initialize argv, stdin, stdout, stderr, kernel
    @argv, @stdin, @stdout, @stderr, @kernel = argv, stdin, stdout, stderr, kernel
  end

  def execute!
    $stdin = @stdin
    $stdout = @stdout
    $stderr = @stderr
    Multichain::CLI.start @argv
  end
end

Before '@vcr' do
  Aruba.configure do |config|
    config.command_launcher = :in_process
    config.main_class = VcrFriendlyMain
  end
end

After '@vcr' do
  Aruba.configure { |config| config.command_launcher = :spawn }

  VCR.eject_cassette
  $stdin = STDIN
  $stdout = STDOUT
  $stderr = STDERR
end
