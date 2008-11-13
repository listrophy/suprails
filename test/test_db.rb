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
    verify_file_contents "--- \ndevelopment: \n  adapter: mysql\n  username: user\n  database: test_app_dev\n  pass: pass\nproduction: \n  adapter: mysql\n  username: user\n  database: test_app_prod\n  pass: pass\ntest: \n  adapter: mysql\n  username: user\n  database: test_app_test\n  pass: pass\n"
  end

  def verify_file_contents(contents)
    File.open(@test_file, 'r') do |f|
      assert_equal contents, f.read
    end
  end

  def teardown
    File.delete @test_file
    Dir.delete 'test_app/config'
    Dir.delete 'test_app'
  end
end
