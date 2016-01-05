require 'spec_helper'
require 'timecop'

module Multichain
  describe Encoder do
    it 'hashes the content of a URL', :vcr do
      expect(described_class.hash 'http://metrics.theodi.org/metrics/2013-q3-completed-tasks.json').to eq (
        '115353c2cfd04c95098dafd10a94d1cb085e0bdfc3b480b1485d4da2cedb2f00'
      )
    end

    it 'composes an input string', :vcr do
      Timecop.freeze Time.local 2016, 01, 04
      expect(described_class.input_string 'http://metrics.theodi.org/metrics/certificated-datasets.json').to eq (
        "1451865600|http://metrics.theodi.org/metrics/certificated-datasets.json|{\"Accept\":\"application/json\"}|9ae3eb26b0534631404c784f0e6807908145afc47f2b7287e78a6389a87a33f7"
      )
      Timecop.return
    end

    context 'hexification' do
      it 'hexifies an input string', :vcr do
        Timecop.freeze Time.local 2016, 01, 05
        expect(described_class.hexify 'http://metrics.theodi.org/metrics/cumulative-people-trained.json').to eq (
          '313435313935323030307c687474703a2f2f6d6574726963732e7468656f64692e6f72672f6d6574726963732f63756d756c61746976652d70656f706c652d747261696e65642e6a736f6e7c7b22416363657074223a226170706c69636174696f6e2f6a736f6e227d7c32626266313237666131326536353666373265356162343535623132656263383466313138333939353364396366376439636637303833336333396131653762'
        )
        Timecop.return
      end

      it 'supports an alternative method name', :vcr do
        Timecop.freeze Time.local 2016, 01, 05
        expect(described_class.encode 'http://metrics.theodi.org/metrics/cumulative-people-trained.json').to eq (
          '313435313935323030307c687474703a2f2f6d6574726963732e7468656f64692e6f72672f6d6574726963732f63756d756c61746976652d70656f706c652d747261696e65642e6a736f6e7c7b22416363657074223a226170706c69636174696f6e2f6a736f6e227d7c32626266313237666131326536353666373265356162343535623132656263383466313138333939353364396366376439636637303833336333396131653762'
        )
        Timecop.return
      end
    end

    context 'dehexification' do
      it 'dehexifies a hexified string' do
        expect(described_class.dehexify '313435323030313339307c687474703a2f2f6d6574726963732e7468656f64692e6f72672f6d6574726963732f63757272656e742d796561722d72656163682e6a736f6e7c7b22416363657074223a226170706c69636174696f6e2f6a736f6e227d7c61623630343065633034383763316363303830343963383930326534643835313237373339303235623432386238336536393730373165636336646431633562').to eq (
          "1452001390|http://metrics.theodi.org/metrics/current-year-reach.json|{\"Accept\":\"application/json\"}|ab6040ec0487c1cc08049c8902e4d85127739025b428b83e697071ecc6dd1c5b"
        )
      end

      it 'supports an alternative method name' do
        expect(described_class.decode '313435323030313339307c687474703a2f2f6d6574726963732e7468656f64692e6f72672f6d6574726963732f63757272656e742d796561722d72656163682e6a736f6e7c7b22416363657074223a226170706c69636174696f6e2f6a736f6e227d7c61623630343065633034383763316363303830343963383930326534643835313237373339303235623432386238336536393730373165636336646431633562').to eq (
          "1452001390|http://metrics.theodi.org/metrics/current-year-reach.json|{\"Accept\":\"application/json\"}|ab6040ec0487c1cc08049c8902e4d85127739025b428b83e697071ecc6dd1c5b"
        )
      end
    end

    it 'extracts parts from an input string' do
      expect(described_class.extract "1452001686|http://metrics.theodi.org/metrics/membership-coverage.json|{\"Accept\":\"application/json\"}|65e1c68e376cf78826c75b079150309b5089d184d8340c8b76fe36bad320e20f").to eq (
        {
          timestamp: '1452001686',
          url: 'http://metrics.theodi.org/metrics/membership-coverage.json',
          headers: '{"Accept":"application/json"}',
          hash: '65e1c68e376cf78826c75b079150309b5089d184d8340c8b76fe36bad320e20f'
        }
      )
    end

    context 'verification' do
      it 'verifies a hexified string', :vcr do
        hexified = described_class.hexify 'http://metrics.theodi.org/metrics/current-year-active-reach.json'
        expect(described_class.verify hexified).to be (
          true
        )
      end

      it 'does not verify a duff hexified string', :vcr do
        hexified = "#{described_class.hexify('http://metrics.theodi.org/metrics/current-year-active-reach.json')}000"
        expect(described_class.verify hexified).to be (
          false
        )
      end
    end
  end
end
