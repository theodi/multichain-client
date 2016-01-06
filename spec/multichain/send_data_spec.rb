module Multichain
  describe Client do
    let(:client) { described_class.new(ENV['RPC_USER'], ENV['RPC_PASSWORD'], ENV['RPC_HOST'], ENV['RPC_PORT'] ) }

    it 'knows about its asset' do
      expect(client.asset).to eq 'odi-coin'
    end

    it 'sends a coin', :vcr do
      client.send_asset 'stu', 1
    end
  end
end
