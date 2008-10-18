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

# require 'rubygems'
require File.dirname(__FILE__) + '/runner'

class Suprails
  
  
  def initialize(app_name = "")
    @app_name = app_name
    @run_file = ""
  end

  def app_name=(val)
    @app_name = val
  end
  def app_name
    @app_name
  end

  def create_project
    Runner.new(@app_name).run
  end
  
  def to_s
    "Rails appname: #{@app_name}\n"
  end
  
end
