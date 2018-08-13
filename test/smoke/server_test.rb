require 'thrift'
require 'bundler/setup'


transport = Thrift::BufferedTransport.new(Thrift::Socket.new('localhost','port'))
protocol = Thrift::BinaryProtocol.new(transport)
client = Calculator::Client.new(protocol)

client.increment(5)
client.getCounter