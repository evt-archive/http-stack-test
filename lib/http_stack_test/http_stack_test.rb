module HTTPStackTest
  extend self

  attr_accessor :ssl_enabled

  def host
    'localhost'
  end

  def iterations
    (ENV['ITERATIONS'] || 3).to_i
  end

  def path
    '/decrement'
  end

  def port
    8000
  end

  def uri
    if ssl?
      cls = URI::HTTPS
    else
      cls = URI::HTTP
    end

    cls.build(
      :host => host,
      :path => path,
      :port => port
    )
  end

  def ssl?
    if ssl_enabled then true else false end
  end
end
