require 'multichain'

module Multichain
  class CLI < Thor
    desc 'version', 'Print multichain version'
    def version
      puts "multichain version #{VERSION}"
    end
    map %w(-v --version) => :version

    desc 'hexify URL', 'Prepare a hexified string for a URL'
    def hexify url
      puts Encoder.hexify url
    end
    map %w(--encode) => :hexify

    desc 'dehexify hex', 'Dehexify a hexified string'
    def dehexify hex
      puts Encoder.dehexify hex
    end
    map %w(--decode) => :dehexify
  end
end
