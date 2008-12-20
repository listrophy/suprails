require File.dirname(__FILE__) + '/../lib/runner.rb'
require 'test/unit' unless defined? $ZENTEST and $ZENTEST
require 'rubygems'
require 'mocha'

class TestRunner < Test::Unit::TestCase

  def setup
    @app_name = 'test_app'
    @runner = Runner.new(@app_name)
  end

  def test_rails
    @runner.expects(:shell).with( "rails #{@app_name}")
    @runner.rails
  end
  
  def test_frozen_rails
    @runner.expects(:shell).with( "rails #{@app_name} --freeze")
    @runner.frozen_rails
  end

  def test debug
    message = "test message"
    @runner.expects(:puts).with(regexp_matches(/#{message}/))
    @runner.debug(message)
  end
  
  def test_generate
    @runner.expects(:runinside).with('script/generate model ')
    @runner.generate('model')
  end

  def test_generate_with_options
    @runner.expects(:runinside).with('script/generate model user ')
    @runner.generate('model user')
  end

  def test_generate_with_options_as_symbols
    @runner.expects(:runinside).with('script/generate model user')
    @runner.generate(:model, :user)
  end

  def test_folder
    folder_name = "new_folder/subdir"
    Dir.mkdir(Runner.base)
    @runner.folder folder_name
    assert File.exists? "#{Runner.base}/#{folder_name}"
    Dir.delete "#{Runner.base}/#{folder_name}"
    Dir.delete "#{Runner.base}/new_folder"
  end
  
  def test_svn
    @runner.expects(:runinside).with('svnadmin create')
    @runner.svn
  end

  def test_git
    @runner.expects(:runinside).with('git init')
    @runner.git
  end

  def test_plugin
    @runner.expects(:runinside).with('script/plugin install a')
    @runner.plugin('a')
  end

  def test_rake
    @runner.expects(:runinside).with('rake ')
    @runner.rake()
  end

  def test_rake_with_options
    @runner.expects(:runinside).with('rake test')
    @runner.rake('test')
  end

  def test_runinside
    @runner.expects(:shell).with( "cd #{@app_name}; cmd")
    @runner.runinside('cmd')
  end

  def test_runinside_with_options
    @runner.expects(:shell).with( "cd #{@app_name}; cmd a b")
    @runner.runinside('cmd a b')
  end
  
end