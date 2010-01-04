$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
require 'rack/sanitize'
require 'rack/test'
require 'spec'
require 'spec/autorun'
require 'sinatra/base'

class PotentialVictim < Sinatra::Base
  helpers do
    def render_key_value(hash)
      hash.map {|k,v| "#{k}=#{v}"}.sort.join('&')
    end
  end
  
  get '/get' do
    "GETs: #{render_key_value(request.GET)}"
  end
  
  post '/post' do
    "POSTs: #{render_key_value(request.POST)}"
  end
end

Spec::Runner.configure do |config|
  config.include Rack::Test::Methods
  
  def app
    @app ||= Rack::Builder.app do
      use Rack::Sanitize
      run PotentialVictim
    end
  end
end
