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

require 'yaml'

class YAMLHelper
  def self.create_yaml(file, values)
    directory = File.dirname(file)
    create_directory_unless_exists(directory)
    File.open(file, 'w') {|f| f << YAML::dump(values) }
  end

  def self.modify_yaml(file, values)
    if File.exist?(file)
      config = YAML::load(File.open(file))
      config.merge!(values)
    else
      config = values
    end
    create_yaml(file, config)
  end

  protected
  def self.create_directory_unless_exists(directory)
    directory = File.expand_path(directory)
    starts_with_slash = directory.index('/') == 0
    dir_arr = directory.split('/')
    curr_dir = starts_with_slash ? '/' : ''
    dir_arr.each do |dir|
      curr_dir << "#{dir}/"
      unless File.exist?(curr_dir)
        Dir.mkdir(curr_dir)
      end
    end
  end
end
