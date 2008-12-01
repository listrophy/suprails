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

require File.dirname(__FILE__) + '/insertion_helper'
require File.dirname(__FILE__) + '/db'
require File.dirname(__FILE__) + '/gems'
require File.dirname(__FILE__) + '/facet'

class Runner
  
  class << self
    attr_accessor :app_name
  end
  
  def initialize(app_name, runfile = "~/.suprails/config")
    Runner.app_name = app_name
    @runfile = File.expand_path(runfile)
    @sources = File.expand_path('~/.suprails/sources/')
    @facets_source = File.expand_path('~/.suprails/facets/')
    Dir["#{@facets_source}/*.rb"].each{|x| load x }
    
    Facet.registered_facets.each do |name, facet|
      self.class.send(:define_method, name) {}
      instance_eval do
        self.class.send(:define_method, name) do |*args|
          args.unshift(Runner.app_name)
          facet.go *args
        end
      end
    end
  end
  
  def methods
    super.each{|x| puts x}
  end

  def run
    gems = Gems.new Runner.app_name
    db = DB.new Runner.app_name
    @base = File.expand_path "./#{Runner.app_name}"
    Dir.mkdir(@base)
    text = File.read(@runfile)
    instance_eval(text)
  end

  def sources sourcefolder
    @sources = File.expand_path "#{sourcefolder}/"
    puts "Using #{@sources} for file sources"
  end

  def rails
    shell "rails #{Runner.app_name}"
  end
  
  def frozen_rails
    shell "rails #{Runner.app_name} --freeze"
  end

  def debug p = ''
    puts "debug: #{p}"
  end

  def plugin plugin_location
    runinside("script/plugin install #{plugin_location}")
  end

  def generate generator, *opts
    runinside("script/generate #{generator} #{opts.join(' ')}")
  end

  def folder folder_name
    path = "#{@base}/"
    puts "New folder: #{@base}"
    paths = folder_name.split('/')
    paths.each do |p|
      path += "#{p}/"
      Dir.mkdir path if !File.exists? path
    end
  end

  def file source_file, destination, absolute = false
    require 'ftools'
    if absolute
      source = File.expand_path "#{source_file}"
    else
      source = File.expand_path "#{@sources}/#{source_file}"
    end
    dest = File.expand_path "./#{Runner.app_name}/#{destination}"
    File.copy(source, dest, true) if File.exists? source
  end

  def delete file_name
    file_name = "#{@base}/#{file_name}"
    puts "Deleting: #{@file_name}"
    File.delete file_name if File.exists?(file_name)
  end

  def gpl
    puts 'Installing the GPL into COPYING'
    require 'net/http'
    http = Net::HTTP.new('www.gnu.org')
    path = '/licenses/gpl-3.0.txt'
    begin
      resp = http.get(path)
      if resp.code == '200'
        File.open("#{@base}/COPYING", 'w') do |f|
          f.puts(resp.body)
        end
      else
        puts "Error #{resp.code} while retrieving GPL text."
      end
    rescue SocketError
      puts 'SocketError: You might not be connected to the internet. GPL retrieval failed.'
    end
  end

  def rake *opts
    runinside("rake #{opts.join(' ')}")
  end

  def git
    runinside('git init')
  end

  def svn
    runinside('svnadmin create')
  end
  
  def runinside *opts
    shell "cd #{Runner.app_name}; #{opts.join(' ')}"
  end
  
  def save
    file @runfile, "doc/suprails.config", true
  end
  
  def new_file filename, contents
    File.open(File.expand_path("./#{Runner.app_name}/#{filename}"), 'w') do |f|
      f.puts contents
    end
    puts "Generating file: #{filename}"
  end
  
  private
  
  def shell cmd
    puts `#{cmd}`
  end
  
end
