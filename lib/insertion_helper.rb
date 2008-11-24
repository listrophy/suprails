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

class InsertionHelper
  
  def self.insert_at filename, line_number, contents
    file_contents = File.readlines(filename)
    file_contents.insert(line_number-1, "#{contents}\n")
    File.open(filename, 'w') {|f| f << file_contents }
  end
  
  def self.file_sub! filename, pattern, contents
    file_contents = File.read(filename)
    file_contents.sub!(pattern, contents)
    File.open(filename, 'w') {|f| f << file_contents }
  end
  
  def self.insert_above filename, search_string, contents
    file_contents = File.read(filename)
    file_contents.sub!(/(^.*#{Regexp.escape(search_string)}.*$)/, "#{contents}\n\\1")
    File.open(filename, 'w') {|f| f << file_contents}
  end
end