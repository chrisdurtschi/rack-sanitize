require File.dirname(__FILE__) + '/../spec_helper'

describe Rack::Sanitize do
  it "should sanitize GETs" do
    get %{/?a=ok&okie=%3Cscript+src%3D%22http%3A%2F%2Fiammalicious.com%22%3Edokie%3C%2Fscript%3E}
    last_response.body.should == "GETs: a=ok&okie=dokie POSTs: "
  end
  
  it "should sanitize POSTs" do
    
  end
  
  it "should sanitize if the path matches" do
    
  end
  
  it "should not sanitize if the path does not match" do
    
  end
  
  it "should default to sanitizing both GETs and POSTs" do
    
  end
end
