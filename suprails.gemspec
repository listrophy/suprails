Gem::Specification.new do |s|
  s.name = "suprails"
  s.version = "0.1.1"
  s.date = "2008-10-31"
  s.authors = ["Bradley Grzesiak"]
  s.email = "listrophy@gmail.com"
  s.summary = 'Suprails provides a wrapper to the rails command'
  s.homepage = 'http://github.com/listrophy/suprails'
  s.files = [ "README", "COPYING", "TODO", "lib/db.rb", "lib/facet.rb", "lib/gems.rb", "lib/runner.rb", "lib/suprails.rb", "facets/haml.rb", "bin/suprails", ".suprails.example"]
  s.executables << "suprails"
  s.add_dependency 'rails', '>= 0'
  s.description = <<-EOF
      This project is intended to be a replacement for the "rails" command. It 
      does not replace the rails framework but rather provides a starting point
      for a rails application far beyond what the "rails" command provides. 
      During execution, in fact, the suprails command calls the rails command.
      EOF
end
