module Multichain
  class Client

    def initialize
      @username = config['rpc']['user']
      @password = config['rpc']['password']
      @host = config['rpc']['host']
      @port = config['rpc']['port']
    end

    def auth
      "#{@username}:#{@password}"
    end

    def url
      "http://#{auth}@#{@host}:#{@port}"
    end

    def config
      config_file = "#{ENV['HOME']}/.multichain/config.yml"
      config_file = 'spec/support/fixtures/config.yml' if ENV['TEST']
      @config ||= begin
        c = YAML.load_file config_file
        if ENV['TEST']
          c['rpc'] = {}
          c['rpc']['user'] = ENV['RPC_USER']
          c['rpc']['password'] = ENV['RPC_PASSWORD']
          c['rpc']['host'] = ENV['RPC_HOST']
          c['rpc']['port'] = ENV['RPC_PORT']
        end

        c
      end
    end

    def asset
      config['asset']
    end

    def wallets
      @wallets ||= Wallets.new
    end

    def send_asset recipient, amount
      params = [
        wallets.fetch(recipient),
        asset,
        amount
      ]

      s = sendassettoaddress params

      {
        recipient: recipient,
        asset: asset,
        amount: amount,
        id: s['result']
      }
    end

    def send_asset_with_data recipient, amount, data
      params = [
        wallets.fetch(recipient),
        {asset => amount},
        data
      ]

      s = sendwithmetadata params

      {
        recipient: recipient,
        asset: asset,
        amount: amount,
        data: data,
        id: s['result']
      }
    end

    def send_url recipient, url
      hex = Encoder.hexify url
      params = [
        wallets.fetch(recipient),
        {asset => 0},
        hex
      ]

      s = sendwithmetadata params
      data = Encoder.extract Encoder.decode hex

      {
        recipient: recipient,
        url: url,
        hash: data[:hash],
        timestamp: data[:timestamp],
        hex: hex,
        id: s['result']
      }
    end

    def method_missing(sym, params = [])
      request = build_request(sym.to_s, params)
      send_request(request)
    end

    private

      def build_request(method, params)
        {
          method: method,
          params: params,
          id: SecureRandom.uuid
        }.to_json
      end

      def send_request(request)
        post = HTTParty.post(url, body: request, headers: {"Content-Type" => "application/json"})
        response = post.body
        JSON.parse(response)
      end

  end
end
