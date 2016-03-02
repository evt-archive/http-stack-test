module HTTPStackTest
  class Client
    dependency :logger, Telemetry::Logger

    def self.build
      instance = new
      Telemetry::Logger.configure instance
      instance
    end

    def self.start
      instance = build
      instance.start
    end

    def start
      iteration = HTTPStackTest.iterations

      until iteration.zero?
        uri = HTTPStackTest.uri

        data = JSON.pretty_generate 'iteration' => iteration
        response = HTTP::Commands::Post.(data, uri, { 'Connection' => 'close' }, :connection => connection)
        body = JSON.parse response.body

        iteration = body['iteration'].to_i
        __logger.pass "Received response: #{iteration}"
      end
    end

    def connection
      @connection ||= establish_connection
    end

    def establish_connection
      host, port = HTTPStackTest.host, HTTPStackTest.port

      if HTTPStackTest.ssl?
        ssl_context = HTTPStackTest::SSL.client_context
        Connection::Client.build host, port, :reconnect => :closed, :ssl => ssl_context
      else
        Connection::Client.build host, port, :reconnect => :closed
      end
    end

    module ProcessHostIntegration
      def change_connection_scheduler(scheduler)
        connection.scheduler = scheduler
      end
    end
  end
end
