require File.dirname(__FILE__) + '/../lib/db.rb'
require 'test/unit' unless defined? $ZENTEST and $ZENTEST
require 'rubygems'
require 'mocha'

class TestDb < Test::Unit::TestCase

  def setup
    @db = DB.new('test_app')
    @test_file = 'test_app/config/database.yml'
  end

  def test_save_yaml
    database_hash = { 'adapter' => 'mysql',
		      'username' => 'user',
		      'pass' => 'pass'
                    }
    dev_hash = database_hash.merge({'database' => 'test_app_dev'})
    test_hash = database_hash.merge({'database' => 'test_app_test'})
    prod_hash = database_hash.merge({'database' => 'test_app_prod'})
    environment_hash = { 'development' => dev_hash,
                         'test' => test_hash,
                         'production' => prod_hash
                       }
    @db.save_yaml environment_hash
    verify_yaml_contents({'development' => dev_hash, 'production' => prod_hash,
        'test' => test_hash})
  end

  def verify_yaml_contents(hash)
    File.open(@test_file, 'r') do |file|
      assert_equal YAML::load(file), hash
    end
  end

  def teardown
    File.delete @test_file
    Dir.delete 'test_app/config'
    Dir.delete 'test_app'
  end
end
