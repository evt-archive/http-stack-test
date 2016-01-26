module HTTPStackTest
  module Servers
    class Server
      include HTTP::Server

      def self.test_instance
        if HTTPStackTest.ssl?
          ssl_context = HTTPStackTest::SSL.server_context
          build ssl_context
        else
          build
        end
      end

      def self.run_in_background_thread
        instance = test_instance

        server_thread = Thread.new do
          instance.start
        end

        Thread.pass until server_thread.status == 'sleep'

        server_thread
      end

      post HTTPStackTest.path do |response, _, request, server|
        json = request.read_body
        entity = JSON.parse json
        iteration = entity['iteration'].to_i
        iteration -= 1

        json = JSON.pretty_generate 'iteration' => iteration

        response.deliver 200, json, 'application/json'

        server.stop if iteration.zero?

        __logger.pass "Served response: #{iteration}"
      end
    end
  end
end
