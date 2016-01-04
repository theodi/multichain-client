require 'spec_helper'
require 'timecop'

describe Multichain do
  it 'has a version number' do
    expect(Multichain::VERSION).not_to be nil
  end

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
end
