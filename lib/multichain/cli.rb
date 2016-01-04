require 'multichain'

module Multichain
  class CLI < Thor
    desc 'version', 'Print multichain version'
    def version
      puts "multichain version #{VERSION}"
    end
    map %w(-v --version) => :version
  end
end
