require File.dirname(__FILE__) + '/../lib/runner.rb'
require 'test/unit' unless defined? $ZENTEST and $ZENTEST
require 'rubygems'
require 'mocha'

class TestFacets < Test::Unit::TestCase

  Facet.define 'facet_name' do; end
  
  def setup
    Runner.new('test_app')
    @facet = Facet.registered_facets['facet_name']
  end

  def test_generate
    @facet.expects(:runinside).with('script/generate model ')
    @facet.generate('model')
  end

  def test_generate_with_options
    @facet.expects(:runinside).with('script/generate model user ')
    @facet.generate('model user')
  end

  def test_generate_with_options_as_symbols
    @facet.expects(:runinside).with('script/generate model user')
    @facet.generate(:model, :user)
  end

  def test_svn
    @facet.expects(:runinside).with('svnadmin create')
    @facet.svn
  end

  def test_git
    @facet.expects(:runinside).with('git init')
    @facet.git
  end

  def test_plugin
    @facet.expects(:runinside).with('script/plugin install a')
    @facet.plugin('a')
  end

  def test_rake
    @facet.expects(:runinside).with('rake ')
    @facet.rake()
  end

  def test_rake_with_options
    @facet.expects(:runinside).with('rake test')
    @facet.rake('test')
  end

  def test_runinside
    @facet.expects(:shell).with( "cd test_app; cmd")
    @facet.runinside('cmd')
  end

  def test_runinside_with_options
    @facet.expects(:shell).with( "cd test_app; cmd a b")
    @facet.runinside('cmd a b')
  end
  
end