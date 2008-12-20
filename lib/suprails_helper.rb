require File.dirname(__FILE__) + '/insertion_helper'
require File.dirname(__FILE__) + '/db'
require File.dirname(__FILE__) + '/gems'

module SuprailsHelper
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
    path = "#{Runner.base}/"
    puts "New folder: #{Runner.base}"
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
    file_name = "#{Runner.base}/#{file_name}"
    puts "Deleting: #{file_name}"
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
        File.open("#{Runner.base}/COPYING", 'w') do |f|
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
    file Runner.runfile, "doc/suprails.config", true
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
