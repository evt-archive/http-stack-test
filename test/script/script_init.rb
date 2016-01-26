require_relative '../test_init'

HTTPStackTest.ssl_enabled = true if ENV['SSL'] == 'on'
HTTPStackTest.port = ENV['PORT'].to_i if ENV['PORT']
