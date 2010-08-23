require 'sanitize'

module Rack
  class Sanitize
    def initialize(app)
      @app = app
    end

    def call(env)
      request = Rack::Request.new(env)
      request.GET.each {|k,v| request.GET[k] = sanitize(v)}
      request.POST.each {|k,v| request.POST[k] = sanitize(v)}
      @app.call(env)
    end

private

    def sanitize(value)
      if value.is_a?(Hash)
        value.each {|k,v| value[k] = sanitize(v)}
      elsif value.is_a?(String)
        ::Sanitize.clean(value)
      end
    end

  end
end