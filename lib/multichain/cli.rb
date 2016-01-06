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

    desc 'verify hex', 'Verify that a hexified string still represents the same URL content'
    def verify hex
      url = Encoder.extract(Encoder.dehexify(hex))[:url]
      v = Encoder.verify hex

      case v
        when true
          puts "'#{url}' is verified"
          exit 0 unless ENV['TEST']

        when false
          puts "'#{url}' is not verified"
          exit 1 unless ENV['TEST']
      end
    end
  end
end
