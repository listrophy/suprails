#! /usr/bin/env ruby
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
  # --update-gems
  #     checks for new versions of gems before installing them
  # --save-opts
  #     saves (overwrites) the given options to ~/.suprails
  def parse_command_line(args)
    while args.length > 0
      case current = args.shift
      when '--git'
        @options[:git] = true
      when '--gems'
        gem_string = args.shift
        @options[:gems] = gem_string.split(' ')
      when '--freeze-rails'
        @options[:freeze_rails] = true
      when '--update-gems'
        @options[:update_gems] = true
      when '--save-opts'
        @options[:save_opts] = true
      else
        puts "invalid argument: #{current}"
      end
    end
  end
  
  def create_project
    puts "application creation not yet implemented"
    puts "you were about to create an app:"
    puts to_s
    
    # run_rails
  end
  
  def to_s
    ret = "Rails appname: #{@app_name}\nOptions:\n"
    if @options.length > 0
      @options.each {|key,opt| ret += "  #{key}\n"}
    else
      ret += "  none"
    end
    ret
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
interactive_mode = false

case opts.length
when 0
  interactive_mode = true
when 1
  suprails = Suprails.new opts[0]
  execute_rails = true
else
  suprails = Suprails.new opts.shift
  suprails.parse_command_line(opts)
  execute_rails = true
end

if execute_rails
  suprails.create_project
elsif interactive_mode
  #TODO: write interactive mode
  puts 'interactive mode not yet implemented, quitting'
end