#!/usr/bin/ruby
$LOAD_PATH << "./gen-rb"
require 'bundler/setup'
require 'counter'

def Handler 
    def initialize
        @number=0
    end

    def increment(number)
        @number=@number+1
    end

    def getCounter
        return @number
    end
end


processor = Counter::Processor.new(Handler.new)
transport = Thrift::ServerSocket.new(ARGV[0])
transportFactory = Thrift::BufferedTransportFactory.new()
server = Thrift::SimpleServer.new(processor, transport, transportFactory)

puts "Starting the server..."
server.serve()
puts "done."