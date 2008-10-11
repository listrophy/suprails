#
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
require File.dirname(__FILE__) + '../lib/suprails_plugins'

class Suprails
  include SuprailsPlugins
  
  def initialize(app_name = "", options = nil)
    @app_name = app_name
    @options = options
  end
  
  def app_name=(val)
    @app_name = val
  end
  def app_name
    @app_name
  end
  
  def parse_command_line(args)
    while args.length > 0
      case current = args.shift
      when '--git'
        nil
      when '--gems'
        gem_string = args.shift
        nil
      when '--freeze-rails'
        nil
      end
    end
  end
  
  def create_project(options)
    
  end
  
  def to_s
    "Rails appname: #{@app_name}\nOptions: (not implemented)"
  end
end

opts = ARGV
puts "Behold, this is Suprails"

suprails = Suprails.new

case opts.length
when 0
  # TODO: interactive
  puts '0 arguments'
  nil
when 1
  # TODO: create a rails app based on saved preferences
  suprails.app_name = opts[0]
else
  # TODO: parse the arguments and create a rails app
  suprails.app_name = opts.shift
  suprails.parse_command_line(opts)
  
end

puts suprails.to_s