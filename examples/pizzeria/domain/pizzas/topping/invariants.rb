Dir[File.dirname(__FILE__) + '/invariants/*.rb'].each {|file| require_relative file }

module Pizzeria
  module Pizzas
    class Topping
      module Invariants
      end
    end
  end
end
