require 'multichain'

c = Multichain::Client.new 'multichainrpc', '55nGoc9SbM6Usz3EcWfG8iXYNNqA1Y5MFGNt2d4VpT8V', 'chain.theodi.org'

mess = c.help['result'].split "\n"

puts mess 
