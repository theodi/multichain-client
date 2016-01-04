require 'spec_helper'
require 'timecop'

describe Multichain do
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
end
