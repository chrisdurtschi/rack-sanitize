require 'sanitize'

module Rack
  class Sanitize
    def initialize(app)
      @app = app
    end
    
    def call(env)
      request = Rack::Request.new(env)
      request.GET.each {|k,v| request[k] = ::Sanitize.clean(v)}
      @app.call(env)
    end
  end
end