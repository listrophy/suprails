require File.dirname(__FILE__) + '/../lib/runner.rb'
require 'test/unit' unless defined? $ZENTEST and $ZENTEST
require 'rubygems'
require 'mocha'

class TestRunner < Test::Unit::TestCase

  def setup
    @runner = Runner.new('test_app')
  end

  def test_generate
    @runner.expects(:runcommand).with('script/generate model ')
    @runner.generate('model')
  end

  def test_generate_with_options
    @runner.expects(:runcommand).with('script/generate model user ')
    @runner.generate('model user')
  end

  def test_generate_with_options_as_symbols
    @runner.expects(:runcommand).with('script/generate model user')
    @runner.generate(:model, :user)
  end

  def test_svn
    @runner.expects(:runcommand).with('svnadmin create')
    @runner.svn
  end

  def test_git
    @runner.expects(:runcommand).with('git init')
    @runner.git
  end

  def test_plugin
    @runner.expects(:runcommand).with('script/plugin install a')
    @runner.plugin('a')
  end

  def test_rake
    @runner.expects(:runcommand).with('rake ')
    @runner.rake()
  end

  def test_rake_with_options
    @runner.expects(:runcommand).with('rake test')
    @runner.rake('test')
  end

  def test_runcommand
    @runner.expects(:shell).with( "cd test_app; cmd")
    @runner.runcommand('cmd')
  end

  def test_runcommand_with_options
    @runner.expects(:shell).with( "cd test_app; cmd a b")
    @runner.runcommand('cmd a b')
  end

end