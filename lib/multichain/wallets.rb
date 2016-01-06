module Multichain
  class Wallets < Hash
    def initialize
      yaml_path = "#{ENV['HOME']}/.multichain/wallets.yml"
      yaml_path = 'spec/support/fixtures/wallets.yml' if ENV['TEST']
      self.update YAML.load_file yaml_path
    end

    def fetch key
      keys = key.split ':'
      if keys[1]
        return self[keys[0]][keys[1]]
      end
      self[key][self[key].keys[0]]
    end
  end
end
