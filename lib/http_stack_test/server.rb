module HTTPStackTest
  module Server
    class Webrick < WEBrick::HTTPServlet::AbstractServlet
      def self.start
        path = HTTPStackTest.path
        port = HTTPStackTest.port

        log_file = File.open '/dev/null', 'a'
        log = WEBrick::Log.new log_file
        access_log = [log, WEBrick::AccessLog::COMMON_LOG_FORMAT]

        params = {
          :AccessLog => access_log,
          :Logger => log,
          :Port => port
        }

        if HTTPStackTest.ssl?
          key, cert = HTTPStackTest::SSL.pair
          params[:SSLEnable] = true
          params[:SSLCertificate] = cert
          params[:SSLPrivateKey] = key
        end

        __logger.data JSON.pretty_generate(params)
        webrick_server = WEBrick::HTTPServer.new params

        at_exit do
          webrick_server.shutdown
        end

        webrick_server.mount path, self

        webrick_thread = Thread.new do
          webrick_server.start
        end
        Thread.pass until webrick_thread.status == 'sleep'

        webrick_thread
      end

      def do_POST(request, response)
        request_body = JSON.parse request.body
        iteration = request_body['iteration'].to_i
        response_body = JSON.pretty_generate :iteration => (iteration - 1)

        response.body = response_body
        response['Content-Type'] = 'application/json'
        response.status = 200
      end
    end
  end
end
