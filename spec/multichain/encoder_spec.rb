require 'spec_helper'
require 'timecop'

module Multichain
  describe Encoder do
    it 'md5s the content of a URL', :vcr do
      expect(described_class.md5 'http://heyre.be/snake/feeds.json').to eq (
        'e1b9ef9972ce5ee3d64a925b70d6da20'
      )
    end

    it 'composes an input string', :vcr do
      Timecop.freeze Time.local 2016, 01, 04
      expect(described_class.input_string 'http://heyre.be/snake/feeds.json').to eq (
        "1451865600|http://heyre.be/snake/feeds.json|{\"Accept\":\"application/json\"}|e1b9ef9972ce5ee3d64a925b70d6da20"
      )
      Timecop.return
    end

    it 'hexifies an input string', :vcr do
      Timecop.freeze Time.local 2016, 01, 05
      expect(described_class.hexify 'http://heyre.be/snake/feeds.json').to eq (
        '313435313935323030307c687474703a2f2f68657972652e62652f736e616b652f66656564732e6a736f6e7c7b22416363657074223a226170706c69636174696f6e2f6a736f6e227d7c6531623965663939373263653565653364363461393235623730643664613230'
      )
      Timecop.return
    end

    it 'dehexifies a hexified string' do
      expect(described_class.dehexify '313435313932363330397c687474703a2f2f68657972652e62652f636174666163652f666c65612d74726561746d656e747c7b22416363657074223a226170706c69636174696f6e2f6a736f6e227d7c3533326263396332303439353433313937323034613230666137646562636562').to eq (
        "1451926309|http://heyre.be/catface/flea-treatment|{\"Accept\":\"application/json\"}|532bc9c2049543197204a20fa7debceb"
      )
    end
  end
end
