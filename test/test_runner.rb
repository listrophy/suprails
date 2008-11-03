require File.dirname(__FILE__) + '/../lib/runner.rb'
require 'test/unit' unless defined? $ZENTEST and $ZENTEST
require 'rubygems'
require 'mocha'

class TestRunner < Test::Unit::TestCase

  def setup
    @runner = Runner.new('test_app')
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
    @runner.expects(:shell).with( "cd test_app; cmd")
    @runner.runinside('cmd')
  end

  def test_runinside_with_options
    @runner.expects(:shell).with( "cd test_app; cmd a b")
    @runner.runinside('cmd a b')
  end

end