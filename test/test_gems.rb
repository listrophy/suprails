require File.dirname(__FILE__) + '/../lib/runner.rb'
require 'test/unit' unless defined? $ZENTEST and $ZENTEST
require 'rubygems'
require 'mocha'

class TestGems < Test::Unit::TestCase

  def setup
    @gems = Gems.new('test_app')
  end
  
  def test_nothing
  end
  # def test_config_with_single_string_arg
  #   # @gems.expects(:)
  #   @gems.config('haml')
  # end


  # Kept for reference
  # def test_generate
  #   @runner.expects(:runinside).with('script/generate model ')
  #   @runner.generate('model')
  # end
  # 
  # def test_generate_with_options
  #   @runner.expects(:runinside).with('script/generate model user ')
  #   @runner.generate('model user')
  # end
  # 
  # def test_generate_with_options_as_symbols
  #   @runner.expects(:runinside).with('script/generate model user')
  #   @runner.generate(:model, :user)
  # end

  
end