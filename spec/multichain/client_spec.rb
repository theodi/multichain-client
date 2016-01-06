module Multichain
  describe Client do

    let(:username) { 'user' }
    let(:password) { 'password' }
    let(:host) { 'example.com' }
    let(:port) { '6666' }
    let(:client) { described_class.new(username, password, host, port) }

    before(:each) do
      allow(SecureRandom).to receive(:uuid) { 'whevs' }
    end

    it 'constucts a url' do
      expect(client.url).to eq('http://user:password@example.com:6666')
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
