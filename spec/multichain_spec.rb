require 'spec_helper'

describe Multichain do
  it 'has a version number' do
    expect(Multichain::VERSION).not_to be nil
  end

  it 'md5s the content of a URL', :vcr do
    pending
    expect(described_class.md5 'http://heyre.be/snake/feeds.json').to eq (
      'e1b9ef9972ce5ee3d64a925b70d6da20'
    )
  end
end
