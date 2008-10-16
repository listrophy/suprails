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

require File.dirname(__FILE__) + '/db'
require File.dirname(__FILE__) + '/gems'

class Runner
  def initialize(app_name, runfile = "~/.suprails")
    @app_name = app_name
    @runfile = File.expand_path(runfile)
    @sources = '.'
  end

  def run
    gems = Gems.new @app_name
    db = DB.new @app_name
    @base = File.expand_path "./#{@app_name}"
    #TODO: for each facet in facets folder (TBD), include and instantiate
    Dir.mkdir(@base)
    text = File.read(@runfile).split('\n')
    text.each {|l| instance_eval(l)}
  end

  def sources sourcefolder
    @sources = File.expand_path "#{sourcefolder}/"
  end

  def rails
    `rails #{@app_name}`
  end
  
  def frozen_rails
    `rails #{@app_name} --freeze`
  end

  def debug p = ''
    puts "debug: #{p}"
  end

  def plugin plugin_location
    `cd #{@app_name}; script/plugin #{plugin_location}`
  end

  def generate generator, *opts
    if opts.length
      args = ''
      opts.each {|x| args += " #{x}"}
      `cd #{@app_name}; script/generate #{generator} #{args}`
    else
      `cd #{@app_name}; script/generate #{generator}`
    end
  end

  def folder folder_name
    path = "#{@base}/"
    paths = folder_name.split('/')
    paths.each do |p|
      path += "#{p}/"
      Dir.mkdir path if !File.exists? path
    end
  end

  def file source_file, destination
    require 'ftools'
    source = File.expand_path "#{@sources}/#{source_file}"
    dest = File.expand_path "./#{@app_name}/#{destination}"
    # file = File.new source
    File.copy(source, dest, true) if File.exists? source
  end

  def delete file_name
    file_name = "#{@base}/file_name"
    File.delete file_name if File.exists?(file_name)
  end

  def gpl
    puts 'Installing the GPL into COPYING'
    require 'net/http'
    http = Net::HTTP.new('www.gnu.org')
    path = '/licenses/gpl-3.0.txt'
    File.open("#{@base}/COPYING", 'w') do |f|
      resp, data = http.get(path)
      f.puts(data)
    end
  end

  def rake *opts
    if opts.length
      args = ''
      opts.each {|x| args += " #{x}"}
      `cd #{@app_name}; rake #{args}`
    else
      `cd #{@app_name}; rake`
    end
  end

  def git
    gem = false
    begin
      gem = require 'git'
    rescue LoadError => e
      puts 'try installing the git gem... just sayin\''
      nil
    end
    if gem
      g = Git.init(@base)
    else
      `cd #{@app_name}; git init`
    end
  end

  def svn
    `cd #{@app_name}; svnadmin create`
  end
  
  #TODO: This should be generated via a facet, not explicitly defined
  def haml
    puts "haml not yet implemented"
  end
end
