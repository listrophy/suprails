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
require File.dirname(__FILE__) + '/suprails_plugins'

class Suprails
  include SuprailsPlugins
  
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
    puts "application creation not yet implemented. You were about to create an app:"
    puts to_s

    runner = Runner.new
    runner.run

    # run_rails
  end

  def write_prefs
    open(File.expand_path("~/.suprails"), 'w') do |f|
      f.puts '---'
      f.puts '# This is the Suprails config file'
      f.puts "git: #{@options['git'] ? 'true' : 'false'}"
      f.puts "freeze-rails: #{@options['freeze-rails'] ? 'true' : 'false'}"
      f.puts "update-gems: #{@options['update-gems'] ? 'true' : 'false'}"
      f.puts "gems: #{@options['gems'] ? @options['gems'].join(' ') : 'false'}"
    end
  end

  class Gems
    def update *gems
      puts "gems.update: #{gems}"
    end
    def config *gems
      puts "gems.config: #{gems}"
    end
    def unpack
      puts "gems.config"
    end
  end

  class DB
    attr_reader :development, :test, :production
    class Environment
      def initialize db_type
        @db_type = db_type
      end
      def adapter adapter
        puts "db.#{@db_type}.adapter #{adapter}"
      end
      def db db
        puts "db.#{@db_type}.db #{db}"
      end
      def database datab
        db datab
      end
      def host h
        puts "db.#{@db_type}.host #{h}"
      end
      def username uname
        puts "db.#{@db_type}.username #{uname}"
      end
      def password passwd
        puts "db.#{@db_type}.password #{passwd}"
      end
      def socket s
        puts "db.#{@db_type}.socket #{s}"
      end
      def timeout to
        puts "db.#{@db_type}.timeout #{to}"
      end
    end
    def initialize
      @development = Environment.new 'development'
      @test = Environment.new 'test'
      @production = Environment.new 'production'
    end
    
    def create
      puts 'db.create'
    end
      
  end

  class Runner
    def initialize(runfile = "~/.suprails")
      @runfile = File.expand_path(runfile)
    end

    def run
      gems = Gems.new
      db = DB.new
      text = File.read(@runfile).split('\n')
      text.each {|l| instance_eval(l)}
    end

    def sources sourcefile
      puts "source: #{sourcefile}"
    end

    def rails
      puts "rails"
    end

    def freeze
      puts "freeze"
    end

    def plugin plugin_location
      puts "plugin: #{plugin_location}"
    end

    def generate generator, *opts
      puts "generate: #{generator}, #{opts}"
    end

    def folder folder_name
      puts "folder: #{folder_name}"
    end

    def file source_file, destination
      puts "file: #{source_file}, #{destination}"
    end

    def delete file_name
      puts "delete: #{file_name}"
    end

    def gpl
      puts "gpl"
    end

    def rake *opts
      puts "rake: #{opts}"
    end

    def git
      puts "git"
    end
  
    def svn
      puts "svn"
    end
  
    def haml
      puts "haml"
    end
  
  end
  
  def to_s
    "Rails appname: #{@app_name}\n"
  end
  
end
