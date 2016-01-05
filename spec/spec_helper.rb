require 'coveralls'
Coveralls.wear_merged!

$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'multichain'
require 'timecop'
require_relative 'support/vcr_setup'

RSpec.configure do |config|
  config.order = 'random'
end
