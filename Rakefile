require 'rubygems'
require 'rake/gempackagetask'

spec = Gem::Specification.new do |s|
  s.name = "suprails"
  s.version = "0.2.1"
  s.date = "2008-11-30"
  s.authors = ["Bradley Grzesiak"]
  s.email = "listrophy@gmail.com"
  s.summary = 'Suprails provides a wrapper to the rails command'
  s.homepage = 'http://suprails.org'
  s.files = ["README",
    "COPYING",
    "TODO",
    "lib/db.rb",
    "lib/facet.rb",
    "lib/gems.rb",
    "lib/insertion_helper.rb",
    "lib/runner.rb",
    "lib/suprails.rb",
    "lib/yaml_helper.rb",
    "facets/haml.rb",
    "bin/suprails",
    "suprails.config.example"]
  s.executables << "suprails"
  s.rubyforge_project = 'suprails'
  s.description = <<-EOF
      This project is intended to be a replacement for the "rails" command. It 
      does not replace the rails framework but rather provides a starting point
      for a rails application far beyond what the "rails" command provides. 
      During execution, in fact, the suprails command calls the rails command.
      EOF
  
  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 2

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<rails>, [">= 0"])
    else
      s.add_dependency(%q<rails>, [">= 0"])
    end
  else
    s.add_dependency(%q<rails>, [">= 0"])
  end
end

package_task = Rake::GemPackageTask.new(spec) {}

desc "Build the project into a gem"
task :build_gemspec do
  File.open("#{spec.name}.gemspec", 'w') do |f|
    f.write spec.to_ruby
  end
end

task :default => [:build_gemspec, :gem]