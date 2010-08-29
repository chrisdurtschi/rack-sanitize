require 'sanitize'

module Rack
  class Sanitize
    def initialize(app, config={})
      @app    = app
      @config = config
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
      elsif value.is_a?(Array)
        value.map {|v| sanitize(v)}
      elsif value.is_a?(String)
        ::Sanitize.clean(value, @config)
      end
    end

  end
end