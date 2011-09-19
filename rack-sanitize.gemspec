# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "rack-sanitize/version"

Gem::Specification.new do |s|
  s.name        = "rack-sanitize"
  s.version     = Rack::Sanitize::VERSION
  s.authors     = ["Christopher Durtschi"]
  s.email       = ["christopher.durtschi@gmail.com"]
  s.homepage    = "https://www.github.com/chrisdurtschi/rack-sanitize"
  s.summary     = %q{Rack middleware to sanitize GET and POST parameters}
  s.description = %q{Remove all malicious HTML from your request before it reaches your application}

  s.rubyforge_project = "rack-sanitize"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_runtime_dependency "sanitize", "~> 2.0.0"
  s.add_development_dependency "rake"
  s.add_development_dependency "rspec", "~> 1.3.0"
  s.add_development_dependency "rack-test", "~> 0.5.4"
  s.add_development_dependency "sinatra", "~> 1.0"
  s.add_development_dependency "activesupport", "~> 3.0.0"
end
