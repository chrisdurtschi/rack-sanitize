$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
require 'rack/sanitize'
require 'rack/test'
require 'spec'
require 'spec/autorun'
require 'sinatra/base'

class PotentialVictim < Sinatra::Base
  get '/' do
    gets = request.GET.map {|k,v| "#{k}=#{v}"}.sort.join('&')
    posts = request.POST.map {|k,v| "#{k}=#{v}"}.sort.join('&')
    ['GETs:', gets, 'POSTs:', posts].join(' ')
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
