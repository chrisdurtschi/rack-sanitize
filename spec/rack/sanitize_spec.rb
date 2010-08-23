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

  it "should sanitize nested parameters" do
    params = {
      "parent" => {
        "a" => {"okay" => %Q{<script src="http://iammalicious.com">arsehole</script>}},
        "okie" => %Q{<script src="http://iammalicious.com">dokie</script>}
      }
    }

    get '/get', params
    last_response.body.should == "GETs: parent[a][okay]=arsehole&parent[okie]=dokie"

    post '/post', params
    last_response.body.should == "POSTs: parent[a][okay]=arsehole&parent[okie]=dokie"
  end

  it "should sanitize elements in an array" do
    params = {
      "person" => {
        "pets" => [
          {"dog" => "<script>woof</script>"},
          {"cat" => "<script>meow</script>"}
        ]
      },
      "beer" => ["<script>porter</script>", "pilsner"]
    }

    get '/get', params
    last_response.body.should == "GETs: person[pets][][dog]=woof&person[pets][][cat]=meow&beer[]=porter&beer[]=pilsner"

    post '/post', params
    last_response.body.should == "POSTs: person[pets][][dog]=woof&person[pets][][cat]=meow&beer[]=porter&beer[]=pilsner"
  end

  it "should sanitize if the path matches" do

  end

  it "should not sanitize if the path does not match" do

  end

  it "should default to sanitizing both GETs and POSTs" do

  end
end
