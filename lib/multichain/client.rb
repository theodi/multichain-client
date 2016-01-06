module Multichain
  class Client

    def initialize(username, password, host, port = 2898)
      @username = username
      @password = password
      @host = host
      @port = port

      config_file = "#{ENV['HOME']}/.multichain/config.yml"
      config_file = 'spec/support/fixtures/config.yml' if ENV['TEST']
      @config = YAML.load_file config_file
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
      @config ||= YAML.load_file config_file
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

    def method_missing(sym, params = [])
      request = build_request(sym.to_s, params)
      send_request(request)
    end

    private

      def build_request(method, params)
        {
          method: method,
          params: params,
          id: 'whevs'
        }.to_json
      end

      def send_request(request)
        post = HTTParty.post(url, body: request, headers: {"Content-Type" => "application/json"})
        response = post.body
        JSON.parse(response)
      end

  end
end
