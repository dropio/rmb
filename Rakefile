require 'rubygems'
require 'bundler'
Bundler.setup :development, :test

$: << File.expand_path('./lib')
require 'rmb/version'

### Echoe
begin
  require 'echoe'

  Echoe.new('rmb', Rmb::VERSION) do |echoe|
    echoe.summary = "A Ruby client library for the Rich Media Backbone (RMB) API (http://rmb.io)"
    echoe.author = ["Jake Good", "Eric Skiff", "Kunal Shah", "Seth Thomas Rasmussen", "Bryan Woods"]
    echoe.email = ["jake@dropio.com", "eric@dropio.com", "kunal@dropio.com", "seth@dropio.com", "bryan@dropio.com"]
    echoe.url = "http://github.com/dropio/rmb"
    echoe.retain_gemspec = true
    echoe.changelog = "History.rdoc"
    
    # TODO have this generated from Gemfile or vice versa
    echoe.runtime_dependencies     = ["mime-types", "json", "httparty 0.6.1", "multipart-post 1.0.1", "orderedhash 0.0.6"]
    echoe.development_dependencies = ["rspec", "diff-lcs", "fakeweb"]
    
    echoe.ignore_pattern = "tmtags"
    # Use this rdoc_pattern when building docs locally or publishing docs.
    # echoe.rdoc_pattern = Regexp.union(echoe.rdoc_pattern, /\.rdoc$/)
    echoe.rdoc_pattern   = /\.rdoc$/
  end
  
  # Until we find a way to undefine rake tasks...
  # %w{coverage clobber_coverage}.each { |name| Rake::Task[name].comment = "(don't use)" }
  
  # default depends on test, but we don't have a test task.  Define a trivial one.
  task :test
rescue LoadError
  puts "(Note: Echoe not found.  Install echoe gem for package management tasks.)"
end


### RSpec
require 'spec/rake/spectask'

task :default => :spec
Spec::Rake::SpecTask.new(:spec)

namespace :spec do
  Spec::Rake::SpecTask.new(:rcov) do |t|
    t.rcov = true
    t.rcov_opts = %w{ --exclude ^/ --exclude ^spec/ --sort coverage }
  end
  
  namespace :rcov do
    desc "Generate and view RCov report"
    task :view => :rcov do
      coverage_index = File.expand_path(File.join(File.dirname(__FILE__), 'coverage', 'index.html'))
      sh "open file://#{coverage_index}"
    end
  end
end


### RDoc
require 'rake/rdoctask'

namespace :docs do
  desc "Generate and view RDoc documentation"
  task :view => :docs do
    doc_index = File.expand_path(File.join(File.dirname(__FILE__), 'doc', 'index.html'))
    sh "open file://#{doc_index}"
  end
end
