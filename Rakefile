require 'rubygems'
require 'rake'

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gem|
    gem.name = "rack-sanitize"
    gem.summary = %Q{Rack middleware to sanitize GET and POST parameters}
    gem.description = %Q{Remove all malicious HTML from your request before it reaches your application}
    gem.email = "pherph@gmail.com"
    gem.homepage = "http://github.com/robotapocalypse/rack-sanitize"
    gem.authors = ["robotapocalypse"]
    gem.add_dependency "sanitize", "~>1.2.0"
    gem.add_development_dependency "rspec", "~>1.3.0"
    gem.add_development_dependency "rack-test", "~>0.5.4"
    gem.add_development_dependency "sinatra", "~>1.0"
    gem.add_development_dependency "activesupport", "~>3.0.0.rc2"
    # gem is a Gem::Specification... see http://www.rubygems.org/read/chapter/20 for additional settings
  end
rescue LoadError
  puts "Jeweler (or a dependency) not available. Install it with: sudo gem install jeweler"
end

require 'spec/rake/spectask'
Spec::Rake::SpecTask.new(:spec) do |spec|
  spec.libs << 'lib' << 'spec'
  spec.spec_files = FileList['spec/**/*_spec.rb']
end

Spec::Rake::SpecTask.new(:rcov) do |spec|
  spec.libs << 'lib' << 'spec'
  spec.pattern = 'spec/**/*_spec.rb'
  spec.rcov = true
end

task :spec => :check_dependencies

task :default => :spec

require 'rake/rdoctask'
Rake::RDocTask.new do |rdoc|
  if File.exist?('VERSION')
    version = File.read('VERSION')
  else
    version = ""
  end

  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "rack-sanitize #{version}"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end
