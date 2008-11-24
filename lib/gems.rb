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

class Gems
  def initialize app_name
    @app_name = app_name
  end
  
  def update *gems
    args = gems.inject('') {|text, g| "#{text} #{g}"}
    result = `gem update #{args}`
    if result
      puts 'Gem update failed. Please enter your admin password for sudo gem update:'
      `sudo gem update #{args}`
    end
  end 
 
  def config *gems
    @gems |= gems
    to_insert = gems.inject("") {|text, g| "#{text}  config.gem '#{g}'\n"}
    file = "#{@app_name}/config/environment.rb"
    # InsertionHelper.file_sub! file, /(^.*config\.gem.*$)/, "#{to_insert}\\1"
    InsertionHelper.insert_above file, "config.gem", to_insert[0..-2]
  end
  
  def unpack
    `cd #{@app_name}; rake gems:unpack`
  end
end

