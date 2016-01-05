require 'spec_helper'
require 'timecop'

module Multichain
  describe Encoder do
    it 'hashes the content of a URL', :vcr do
      expect(described_class.hash 'http://heyre.be/snake/feeds.json').to eq (
        'fc2efb8f88c615672434981b147e35930a435cf5c0d24c1541e9bcea612fc043'
      )
    end

    it 'composes an input string', :vcr do
      Timecop.freeze Time.local 2016, 01, 04
      expect(described_class.input_string 'http://heyre.be/snake/feeds.json').to eq (
        "1451865600|http://heyre.be/snake/feeds.json|{\"Accept\":\"application/json\"}|fc2efb8f88c615672434981b147e35930a435cf5c0d24c1541e9bcea612fc043"
      )
      Timecop.return
    end

    it 'hexifies an input string', :vcr do
      Timecop.freeze Time.local 2016, 01, 05
      expect(described_class.hexify 'http://heyre.be/snake/feeds.json').to eq (
        '313435313935323030307c687474703a2f2f68657972652e62652f736e616b652f66656564732e6a736f6e7c7b22416363657074223a226170706c69636174696f6e2f6a736f6e227d7c66633265666238663838633631353637323433343938316231343765333539333061343335636635633064323463313534316539626365613631326663303433'
      )
      Timecop.return
    end

    it 'dehexifies a hexified string' do
      expect(described_class.dehexify '313435313938373830357c687474703a2f2f68657972652e62652f636174666163652f666c65612d74726561746d656e747c7b22416363657074223a226170706c69636174696f6e2f6a736f6e227d7c62376135366662393864306531363466386634663064616239306339336236323164633362626634396432656630353837373565333939396437356239613838').to eq (
        "1451987805|http://heyre.be/catface/flea-treatment|{\"Accept\":\"application/json\"}|b7a56fb98d0e164f8f4f0dab90c93b621dc3bbf49d2ef058775e3999d75b9a88"
      )
    end

    it 'extracts parts from an input string' do
      expect(described_class.extract "1451926309|http://heyre.be/catface/flea-treatment|{\"Accept\":\"application/json\"}|b7a56fb98d0e164f8f4f0dab90c93b621dc3bbf49d2ef058775e3999d75b9a88").to eq (
        {
          timestamp: '1451926309',
          url: 'http://heyre.be/catface/flea-treatment',
          headers: '{"Accept":"application/json"}',
          hash: 'b7a56fb98d0e164f8f4f0dab90c93b621dc3bbf49d2ef058775e3999d75b9a88'
        }
      )
    end

    context 'verification' do
      it 'verifies a hexified string', :vcr do
        hexified = described_class.hexify 'http://heyre.be/snake/sheds.json'
        expect(described_class.verify hexified).to be (
          true
        )
      end

      it 'does not verify a duff hexified string', :vcr do
        hexified = "#{described_class.hexify('http://heyre.be/snake/length.json')}000"
        expect(described_class.verify hexified).to be (
          false
        )
      end
    end
  end
end
