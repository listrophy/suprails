#
# Suprails: The customizable wrapper to the rails command
#
# Copyright 2008 Bradley Grzesiak
# This file is part of Suprails.
# 
#     Suprails is free software: you can redistribute it and/or modify
#     it under the terms of the GNU General Public License as published by
#     the Free Software Foundation, either version 3 of the License, or
#     (at your option) any later version.
# 
#     Suprails is distributed in the hope that it will be useful,
#     but WITHOUT ANY WARRANTY; without even the implied warranty of
#     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#     GNU General Public License for more details.
# 
#     You should have received a copy of the GNU General Public License
#     along with Suprails.  If not, see <http://www.gnu.org/licenses/>.
#

require File.dirname(__FILE__) + '/suprails_helper'
require File.dirname(__FILE__) + '/facet'

class Runner
include SuprailsHelper
  
  class << self
    attr_accessor :app_name
    attr_accessor :runfile
    attr_accessor :sources
    attr_accessor :facets_source
    attr_accessor :base
    
    def sources sourcefolder
      @sources = File.expand_path "#{sourcefolder}/"
    end
  
    def init_variables(app_name, runfile)
      @app_name = app_name
      @runfile = File.expand_path(runfile)
      @sources = File.expand_path('~/.suprails/sources/')
      @facets_source = File.expand_path('~/.suprails/facets/')
      @base = File.expand_path "./#{@app_name}"
    end
  end
      
  def initialize(app_name, runfile = "~/.suprails/config")
    Runner.init_variables(app_name, runfile)
    Dir["#{Runner.facets_source}/*.rb"].each{|x| load x }
    
    Facet.registered_facets.each do |name, facet|
      self.class.send(:define_method, name) {}
      instance_eval do
        self.class.send(:define_method, name) do |*args|
          args.unshift(Runner.app_name)
          facet.go *args
        end
      end
    end
  end
  
  def methods
    super.each{|x| puts x}
  end

  def run
    gems = Gems.new Runner.app_name
    db = DB.new Runner.app_name
    
    Dir.mkdir(Runner.base)
    text = File.read(Runner.runfile)
    instance_eval(text)
  end  
end
