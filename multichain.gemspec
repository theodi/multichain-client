# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'multichain/version'

Gem::Specification.new do |spec|
  spec.name          = 'multichain'
  spec.version       = Multichain::VERSION
  spec.authors       = ['pikesley', 'pezholio']
  spec.email         = ['ops@theodi.org']

  spec.summary       = 'Multichain client'
  spec.description   = 'Client for Multichain'
  spec.homepage      = 'https://github.com/theodi/multichain-client'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_dependency 'httparty', '~> 0.13'
  spec.add_dependency 'thor', '~> 0.19'

  spec.add_development_dependency 'bundler', '~> 1.10'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.4'
  spec.add_development_dependency 'vcr', '~> 3.0'
  spec.add_development_dependency 'webmock', '~> 1.22'
  spec.add_development_dependency 'coveralls', '~> 0.8'
  spec.add_development_dependency 'timecop', '~> 0.8'
  spec.add_development_dependency 'guard', '~> 2.13'
  spec.add_development_dependency 'guard-rspec', '~> 4.6'
  spec.add_development_dependency 'terminal-notifier-guard', '~> 1.6'
  spec.add_development_dependency 'dotenv', '~> 2.0'
  spec.add_development_dependency 'pry'
end
