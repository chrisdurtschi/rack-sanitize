require File.dirname(__FILE__) + '/../spec_helper'

describe Rack::Sanitize do
  it "should sanitize GETs" do
    get '/get', {"a" => "ok", "okie" => %Q{<script src="http://iammalicious.com">dokie</script>}}
    last_response.body.should == "GETs: a=ok&okie=dokie"
  end
  
  it "should sanitize POSTs" do
    post '/post', {"a" => "ok", "okie" => %Q{<script src="http://iammalicious.com">dokie</script>}}
    last_response.body.should == "POSTs: a=ok&okie=dokie"
  end
  
  it "should sanitize if the path matches" do
    
  end
  
  it "should not sanitize if the path does not match" do
    
  end
  
  it "should default to sanitizing both GETs and POSTs" do
    
  end
end
