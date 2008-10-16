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
    if gems.length
      args = ''
      gems.each {|x| args += " #{x}"}
      result = `gem update #{args}`
      if result
        puts 'Gem update failed. Please enter your admin password for sudo gem update:'
        `sudo gem update #{args}`
      end
    else
      result = `gem update`
      if result
        puts 'Gem update failed. Please enter your admin password for sudo gem update:'
        `sudo gem update`
      end
    end
  end
  
  def config *gems
    # need to do some file editing here
    @gems = []
    lines = ''
    gems.each do |g|
      @gems << g
      lines += "  config.gem '#{g}'\n"
    end
    output = []
    File.open("#{@app_name}/config/environment.rb", 'r') do |f|
      f.each {|l| output << l }
    end
    insertion_point = 0
    output.each_index do |i|
      if output[i] =~ /config\.gem/
        insertion_point = i
        break
      end
    end
    gems.each do |gem|
      output.insert(insertion_point, "  config.gem #{gem}")
    end
    File.open("#{@app_name}/config/environment.rb", 'w') do |f|
      output.each do |l|
        f.puts l
      end
    end
  end
  
  def unpack
    `cd #{@app_name}; rake gems:unpack`
  end
end

