module Multichain
  class Client

    def initialize(username, password, host, port = 2898)
      @username = username
      @password = password
      @host = host
      @port = port
    end

    def auth
      "#{@username}:#{@password}"
    end

    def url
      "http://#{auth}@#{@host}:#{@port}"
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
