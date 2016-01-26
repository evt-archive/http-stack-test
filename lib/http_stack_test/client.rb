module HTTPStackTest
  class Client
    dependency :logger, Telemetry::Logger

    def self.build
      instance = new
      Telemetry::Logger.configure instance
      instance
    end

    def self.call
      instance = build
      instance.()
    end

    def call
      iteration = 10

      until iteration.zero?
        uri = HTTPStackTest.uri

        data = JSON.pretty_generate 'iteration' => iteration
        response = HTTP::Commands::Post.(data, uri, { 'Connection' => 'close' }, :connection => connection)
        body = JSON.parse response.body

        iteration = body['iteration'].to_i
        __logger.focus iteration
      end
    end

    def connection
      @connection ||= establish_connection
    end

    def establish_connection
      host, port = HTTPStackTest.host, HTTPStackTest.port

      if HTTPStackTest.ssl?
        ssl_context = HTTPStackTest::SSL.client_context
        Connection::Client.build host, port, reconnect: :when_closed, ssl: ssl_context
      else
        Connection::Client.build host, port, reconnect: :when_closed
      end
    end
  end
end
