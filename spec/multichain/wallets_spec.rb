module Multichain
  describe Wallets do
    let :subject do
      described_class.new
    end

    context 'get wallets' do
      it 'has a wallet' do
        expect(subject.fetch 'sam', 'primary').to eq '1WRmkLHymw4dVjfAdAn4Jg3JtjhmXzkBmQvGen'
      end

      it 'gets the default wallet for a user' do
        expect(subject.fetch 'stu').to eq '1JHkJyBijsUFB2KF6dKwFugcBqDcztLP5E6Eff'
      end
    end
  end
end
