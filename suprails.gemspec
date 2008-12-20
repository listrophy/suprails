# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{suprails}
  s.version = "0.2.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Bradley Grzesiak"]
  s.date = %q{2008-11-30}
  s.default_executable = %q{suprails}
  s.description = %q{This project is intended to be a replacement for the "rails" command. It  does not replace the rails framework but rather provides a starting point for a rails application far beyond what the "rails" command provides.  During execution, in fact, the suprails command calls the rails command.}
  s.email = %q{listrophy@gmail.com}
  s.executables = ["suprails"]
  s.files = ["README", "COPYING", "TODO", "lib/db.rb", "lib/facet.rb", "lib/gems.rb", "lib/insertion_helper.rb", "lib/runner.rb", "lib/suprails.rb", "lib/yaml_helper.rb", "lib/suprails_helper.rb", "facets/haml.rb", "bin/suprails", "suprails.config.example"]
  s.homepage = %q{http://suprails.org}
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{suprails}
  s.rubygems_version = %q{1.3.1}
  s.summary = %q{Suprails provides a wrapper to the rails command}

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
