module Multichain
  describe Client do
    let(:client) { described_class.new(ENV['RPC_USER'], ENV['RPC_PASSWORD'], ENV['RPC_HOST'], ENV['RPC_PORT'] ) }

    it 'knows about its asset' do
      expect(client.asset).to eq 'odi-coin'
    end

    context 'send a coin' do
      it 'sends to a simple address', :vcr do
        expect(client.send_asset 'stu', 1).to eq (
          {
            recipient: 'stu',
            asset: 'odi-coin',
            amount: 1,
            id: '13fea6fb1ad2dae1f77b60245e4c7b4315c8e0dcacb76f6fe8d726462e8e20b7'
          }
        )
      end

      it 'sends to a compound address', :vcr do
        expect(client.send_asset 'sam:primary', 2).to eq (
          {
            recipient: 'sam:primary',
            asset: 'odi-coin',
            amount: 2,
            id: '6fba0c50f1ca5acc52975bea79590e84337497b647e79e4be417066ecc1a7dfe'
          }
        )
      end
    end

    context 'send data with a coin' do
      it 'sends a string of data', :vcr do
        expect(client.send_asset_with_data 'stu', 1, 'deadbeef').to eq (
          {
            recipient: 'stu',
            asset: 'odi-coin',
            amount: 1,
            data: 'deadbeef',
            id: 'fede7691a223f4f556fbccba71788f6bd8f718c0c7b7e67c8d8f3549f3f2f37e',
          }
        )
      end
    end

    context 'send a URL' do
      it 'sends a URL', :vcr do
        Timecop.freeze Time.local 2016, 01, 06 do
          expect(client.send_url 'sam', 'http://uncleclive.herokuapp.com/blockchain').to eq (
            {
              recipient: 'sam',
              url: 'http://uncleclive.herokuapp.com/blockchain',
              hash: 'd004c795edeb3a90c2a2c115f619274fde4268122f61cf380dbf7f43523d9033',
              timestamp: '1452038400',
              id: 'd4f8a2983463747bd8a83f833bccde21b3a34d5d703d41f0680fb10905b718e5'
            }
          )
        end
      end
    end
  end
end
