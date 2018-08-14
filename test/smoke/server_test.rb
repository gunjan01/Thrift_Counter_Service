$:.push('gen-rb')
$:.unshift '../../lib/rb/lib'


require 'thrift'
require 'bundler/setup'
require 'counter'


transport = Thrift::BufferedTransport.new(Thrift::Socket.new(ARGV[0],ARGV[1]))
protocol = Thrift::BinaryProtocol.new(transport)
client = Counter::Client.new(protocol)

transport.open()

client.increment(5.0)
client.getCounter

puts client.getCounter

transport.close()