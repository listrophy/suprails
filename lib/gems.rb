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
    to_insert = []
    @gems = []

    gems.each do |g|
      to_insert << "  config.gem '#{g}'\n"
      @gems << g
    end
    
    file_contents = []

    File.open("#{@app_name}/config/environment.rb", 'r') do |f|
      f.each {|l| file_contents << l }
    end
    
    insertion_point = 0
    file_contents.reverse.each_index do |i|
      if file_contents[i] =~ /config\.gem/
        insertion_point = i
        break
      end
    end
    
    to_insert.each {|x| file_contents.insert(insertion_point, x) }

    File.open("#{@app_name}/config/environment.rb", 'w') do |f|
      file_contents.each do |l|
        f.puts l
      end
    end
    # `cd #{@app_name}; rake gems:install`
  end
  
  def unpack
    `cd #{@app_name}; rake gems:unpack`
  end
end

