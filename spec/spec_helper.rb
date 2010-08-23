$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
require 'rack/sanitize'
require 'rack/test'
require 'spec'
require 'spec/autorun'
require 'sinatra/base'
require 'active_support/core_ext/object/to_query'

class PotentialVictim < Sinatra::Base
  get '/get' do
    "GETs: #{request.GET.to_query}"
  end

  post '/post' do
    "POSTs: #{request.POST.to_query}"
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
