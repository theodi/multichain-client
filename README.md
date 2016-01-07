[![Build Status](http://img.shields.io/travis/theodi/multichain-client.svg?style=flat-square)](https://travis-ci.org/theodi/multichain-client)
[![Dependency Status](http://img.shields.io/gemnasium/theodi/multichain-client.svg?style=flat-square)](https://gemnasium.com/theodi/multichain-client)
[![Coverage Status](http://img.shields.io/coveralls/theodi/multichain-client.svg?style=flat-square)](https://coveralls.io/r/theodi/multichain-client)
[![Code Climate](http://img.shields.io/codeclimate/github/theodi/multichain-client.svg?style=flat-square)](https://codeclimate.com/github/theodi/multichain-client)
[![Gem Version](http://img.shields.io/gem/v/multichain.svg?style=flat-square)](https://rubygems.org/gems/multichain)
[![License](http://img.shields.io/:license-mit-blue.svg?style=flat-square)](http://theodi.mit-license.org)

# Blockchains

## Blockchains everywhere

Every problem can be solved if you just rub enough blockchain on it

### A Ruby client for [Multichain](http://www.multichain.com/)

In the beginning (2008) there was Bitcoin, and that was OK (except for maybe the polar bears). But 2015 decided that Bitcoin was just a garnish on top of the _really_ exciting technology, _blockchains_. Now, at the beginning of 2016, it is impossible to step out onto any London street without falling over blockchains, just laying all around. People want to put *everything* into a blockchain

## How to use

    gem install multichain
    mkdir ~/.multichain

Then create 2 files:

#### ~/.multichain/config.yml

    asset: your-coin
    rpc:
      user: multichainrpc
      password: some_long_password
      host: multicoin.host
      port: 1234

#### ~/.multichain/wallets.yml

    foo:
      primary: wallet_id
    bar:
      primary: other_wallet_id

### Send a URL

Try something like

    multichain send_url foo http://uncleclive.herokuapp.com/multichain
