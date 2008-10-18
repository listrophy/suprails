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

class DB
  attr_reader :development, :test, :production
  class Environment
    def initialize db_type
      @db_type = db_type
    end
    def adapter adapter
      # puts "db.#{@db_type}.adapter #{adapter}"
      puts 'database.yml modification not yet implemented'
    end
    def db db
      # puts "db.#{@db_type}.db #{db}"
      puts 'database.yml modification not yet implemented'
    end
    def database datab
      db datab
    end
    def host h
      # puts "db.#{@db_type}.host #{h}"
      puts 'database.yml modification not yet implemented'
    end
    def username uname
      # puts "db.#{@db_type}.username #{uname}"
      puts 'database.yml modification not yet implemented'
    end
    def password passwd
      # puts "db.#{@db_type}.password #{passwd}"
      puts 'database.yml modification not yet implemented'
    end
    def socket s
      # puts "db.#{@db_type}.socket #{s}"
      puts 'database.yml modification not yet implemented'
    end
    def timeout to
      # puts "db.#{@db_type}.timeout #{to}"
      puts 'database.yml modification not yet implemented'
    end
  end
  def initialize app_name
    @development = Environment.new 'development'
    @test = Environment.new 'test'
    @production = Environment.new 'production'
    @app_name = app_name
  end
  
  def create
    `cd #{@app_name}; rake db:create`
  end
  def migrate
    `cd #{@app_name}; rake db:migrate`
  end
    
end
