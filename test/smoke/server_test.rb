$:.push('gen-rb')
$:.unshift '../../lib/rb/lib'


require 'thrift'
require 'bundler/setup'
require 'example'

class MyClient < Thrifter.build(Counter::Client)

    config.pool_size = 12 
    config.pool_timeout = 0.15

    config.rpc_timeout = 0.15
    config.keep_alive = false 

    config.uri = "tcp://#{ARGV[0]}:#{ARGV[1]}"

    def increment(number = 1)
        super 
    end 

    
end