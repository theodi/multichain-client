require 'coveralls'
Coveralls.wear_merged!

$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'multichain'
require 'webmock/rspec'
require 'timecop'

require_relative 'support/vcr_setup'

ENV['TEST'] = 'true'

RSpec.configure do |config|
  config.order = 'random'
end

# cargo-culted from http://bokstuff.com/blog/testing-thor-command-lines-with-rspec/
def capture(stream)
  begin
    stream = stream.to_s
    eval "$#{stream} = StringIO.new"
    yield
    result = eval("$#{stream}").string
  ensure
    eval("$#{stream} = #{stream.upcase}")
  end

  result
end
