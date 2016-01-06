module Multichain
  describe Client do
    let(:client) {
    }
    it 'has a list of commands', :vcr do
      expect(described_class.commands).to be_an Array
    end
  end
end
