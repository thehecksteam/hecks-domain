Dir[File.dirname(__FILE__) + '/commands/*.rb'].each {|file| require_relative file }

module Pizzeria
  module Pizzas
    module Commands
    end
  end
end