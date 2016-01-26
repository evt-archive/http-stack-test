require_relative './script_init'

server = HTTPStackTest::Servers::Server.test_instance
client = HTTPStackTest::Client.build

cooperation = ProcessHost::Cooperation.build
cooperation.register server, 'server'
cooperation.register client, 'client'
cooperation.start
