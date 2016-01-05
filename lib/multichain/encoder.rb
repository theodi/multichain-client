module Multichain
  class Encoder
    def self.headers
      {
        'Accept' => 'application/json'
      }
    end

    def self.sha256 url, headers = self.headers
      body = Digest::SHA256.hexdigest(HTTParty.get(url, headers: headers).body)
    end

    def self.hash url, headers = self.headers
      sha256 url, headers = self.headers
    end

    def self.input_string url, headers = self.headers
      a = []
      a.push Time.new.to_i
      a.push url
      a.push headers.to_json
      a.push sha256(url)

      a.join '|'
    end

    def self.extract input_string
      parts = input_string.split '|'
      keys = [
        :timestamp,
        :url,
        :headers,
        :hash
      ]
      h = {}

      keys.each_with_index do |k, i|
        h[k] = parts[i]
      end

      h
    end

    def self.hexify url, headers = self.headers
      input_string(url).each_byte.map { |b| b.to_s(16) }.join
    end

    def self.encode url, headers = self.headers
      hexify url, headers = self.headers
    end

    def self.dehexify hexified
      hexified.scan(/../).map { |x| x.hex.chr }.join
    end

    def self.decode hexified
      dehexify hexified
    end

    def self.verify hexified
      parts = extract dehexify hexified
      parts[:hash] == sha256(parts[:url])
    end
  end
end
