module HTTPStackTest
  module SSL
    def self.client_context
      @client_context ||= Connection::Controls::SSL::Context::Client.example
    end

    def self.server_context
      @server_context ||= Connection::Controls::SSL::Context.example :cert => cert, :key => key
    end

    def self.pair
      return key, cert
    end

    def self.cert
      @cert ||= Connection::Controls::SSL::Certificate::SelfSigned.example key
    end

    def self.key
      @key ||= Connection::Controls::SSL::Key.example
    end
  end
end
