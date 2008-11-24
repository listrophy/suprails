require File.dirname(__FILE__) + '/../lib/insertion_helper.rb'
require 'test/unit' unless defined? $ZENTEST and $ZENTEST
require 'rubygems'
require 'mocha'

class TestInsertionHelper < Test::Unit::TestCase

  def setup
    @test_file = 'ljkalkjsdfljkasd.txt'
    @helper = InsertionHelper.new
    File.open(@test_file, 'w') do |f|
      f.puts "line 1"
      f.puts "line 3"
    end
  end

  def test_insert_at
    InsertionHelper.insert_at(@test_file, 2, "on line two")
    verify_file_contents "line 1\non line two\nline 3\n"
  end
  
  def test_insertion_with_file_sub!
    InsertionHelper.file_sub!(@test_file, /(line 3)/, "on line two with file_sub!\n\\1")
    verify_file_contents "line 1\non line two with file_sub!\nline 3\n"
  end
  
  def test_insert_above
    InsertionHelper.insert_above(@test_file, "3", "inserted")
    verify_file_contents "line 1\ninserted\nline 3\n"
  end
  
  def verify_file_contents(contents)
    File.open(@test_file, 'r') do |f|
      assert_equal contents, f.read
    end
  end

  def teardown
    File.delete @test_file
  end
  
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