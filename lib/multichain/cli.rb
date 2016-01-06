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
          puts "The URL '#{url}' is verified"
          exit 0 unless ENV['TEST']

        when false
          puts "The URL '#{url}' is not verified"
          exit 1 unless ENV['TEST']
      end
    end

    desc 'send_url recipient, URL', 'Send a URL to a recipient'
    def send_url recipient, url
      data = Client.new.send_url recipient, url
      out = "You sent '#{url}' to '#{recipient}'\n"
      out << "\n"
      out << "The transaction id is\n"
      out << "  #{data[:id]}\n"
      out << "\n"
      out << "The URL\n"
      out << "  #{url}\n"
      out << "hashed to\n"
      out << "  #{data[:hash]}\n"
      out << "at\n"
      out << "  #{Time.at(data[:timestamp].to_i).to_datetime}\n"
      out << "\n"
      out << "Verify the hash with\n"
      out << "  multichain verify #{data[:hex]}\n"

      puts out
    end
  end
end
