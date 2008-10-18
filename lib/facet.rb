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

# See: http://eigenclass.org/hiki.rb?ruby+plugins
module FacetSugar
  def def_field(*names)
    class_eval do 
      names.each do |name|
        define_method(name) do |*args| 
          case args.size
          when 0: instance_variable_get("@#{name}")
          else    instance_variable_set("@#{name}", *args)
          end
        end
      end
    end
  end
end

class Facet
  @registered_facets = {}
  class << self
    attr_reader :registered_facets
    private :new
  end

  def self.define(name, &block)
    f = new
    f.instance_eval(&block)
    Facet.registered_facets[name] = f
  end

  extend FacetSugar
  def_field :author, :version, :exposed_methods
end
