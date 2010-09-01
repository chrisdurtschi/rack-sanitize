require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

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

  it "should allow the sanitize configuration to be set" do
    @app = Rack::Builder.app do
      use Rack::Sanitize, Sanitize::Config::RELAXED
      run PotentialVictim
    end

    params = {"image" => %Q{<img src="/hello.jpg" />}}

    get '/get', params
    last_response.body.should == %Q{GETs: image=<img src="/hello.jpg" />}

    post '/post', params
    last_response.body.should == %Q{POSTs: image=<img src="/hello.jpg" />}
  end

  it "should sanitize if the path matches" do

  end

  it "should not sanitize if the path does not match" do

  end

  it "should default to sanitizing both GETs and POSTs" do

  end

  describe "file uploads" do
    before do
      @fixtures_dir  = File.join(File.dirname(__FILE__), '..', 'fixtures')
      @gnu_file      = File.join(@fixtures_dir, 'gnu.png')
      @uploaded_file = File.join(@fixtures_dir, 'uploaded_file.png')
    end

    after do
      if File.exists?(@uploaded_file)
        FileUtils.rm(@uploaded_file)
      end
    end

    it "should not mess with file uploads" do
      file = Rack::Test::UploadedFile.new(@gnu_file, 'image/png')

      post '/fileupload', {"file" => file}
      File.exists?(@uploaded_file).should be_true
      FileUtils.compare_file(@gnu_file, @uploaded_file).should be_true
    end
  end
end
