require_relative './script_init'

HTTPStackTest::Servers::Server.run_in_background_thread

HTTPStackTest::Client.start
