require_relative './script_init'

HTTPStackTest::Servers::Webrick.run_in_background_thread

HTTPStackTest::Client.start
