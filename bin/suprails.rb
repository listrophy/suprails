#! /usr/bin/env ruby
# Suprails
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

require 'rubygems'
require File.dirname(__FILE__) + '/../lib/suprails_plugins.rb'

class Suprails
  include SuprailsPlugins
  
  def initialize(app_name = "")
    @app_name = app_name
    @options = {}
  end
  
  def app_name=(val)
    @app_name = val
  end
  def app_name
    @app_name
  end
  
  # The following arguments are currently allowed:
  # --git
  #     initiates git
  # --gems "gemname [gemname2 [gemname3 [...etc...]]]"
  #     installs the gems into the vendor folder
  # --freeze-rails
  #     freezes rails a la rake rails:freeze:gems
  def parse_command_line(args)
    while args.length > 0
      case current = args.shift
      when '--git'
        @options[:git] = true
        nil
      when '--gems'
        gem_string = args.shift
        @options[:gems] = gem_string.split(' ')
        nil
      when '--freeze-rails'
        @options[:freeze_rails] = true
        nil
      else
        puts "invalid argument: #{current}"
      end
    end
  end
  
  def create_project
    puts "application creation not yet implemented"
    puts "you were about to create an app called '#{@app_name}'"
    if @options.length > 0
      puts "with options:"
      @options.each do |key, opt|
        puts "    #{key}"
      end
    else
      puts "without any options"
    end
    
    # run_rails
  end
  
  def to_s
    "Rails appname: #{@app_name}\nOptions: (not implemented)"
  end
  
  private
  
  # this method virtually runs the "rails" command
  def run_rails
    nil
  end
end

opts = ARGV
puts "Behold, this is Suprails"

suprails = Suprails.new
execute_rails = false

case opts.length
when 0
  # TODO: interactive
  puts '0 argument given, quitting'
when 1
  # TODO: create a rails app based on saved preferences
  suprails.app_name = opts[0]
  execute_rails = true
else
  # TODO: parse the arguments and create a rails app
  suprails.app_name = opts.shift
  suprails.parse_command_line(opts)
  execute_rails = true
end

suprails.create_project if execute_rails