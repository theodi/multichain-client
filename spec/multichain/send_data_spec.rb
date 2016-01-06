module Multichain
  describe Client do
    let(:client) { described_class.new(ENV['RPC_USER'], ENV['RPC_PASSWORD'], ENV['RPC_HOST'], ENV['RPC_PORT'] ) }
  end
end
