module Multichain
  class Wallets < Hash
    def initialize yaml_path
      self.update YAML.load_file yaml_path
    end

    def fetch key, subkey = nil
      self.dig(key, subkey) || self[key][self[key].keys[0]]
    end
  end
end
