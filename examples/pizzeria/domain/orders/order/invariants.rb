Dir[File.dirname(__FILE__) + '/invariants/*.rb'].each {|file| require_relative file }

module Pizzeria
  module Orders
    class Order
      module Invariants
      end
    end
  end
end