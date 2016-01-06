module Multichain
  describe Client do
    let(:client) { described_class.new }

    before(:each) do
      allow(SecureRandom).to receive(:uuid) { 'whevs' }
    end

    [
      'getinfo',
      'getpeerinfo',
      'help',
      'stop',
    ].each do |method|
      it "sends a request to #{method}" do
        body = {
          method: method,
          params: [],
          id: 'whevs'
        }.to_json

        stub_request(:post, client.url).
          with(:body => body, headers: {'Content-Type' => 'application/json'}).
          to_return(body: '{}')

        response = client.send("#{method}".to_sym)

        expect(response).to eq({})
        expect(WebMock).to have_requested(:post, client.url).
          with(:body => body, headers: {'Content-Type' => 'application/json'})
      end
    end

  end
end
