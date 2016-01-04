require 'multichain/version'
require 'httparty'

module Multichain
  def self.headers
    {
      'Accept' => 'application/json'
    }
  end

  def self.md5 url
    h = HTTParty.get url, headers: headers
  end
end
