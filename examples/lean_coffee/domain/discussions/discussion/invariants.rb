Dir[File.dirname(__FILE__) + '/invariants/*.rb'].each {|file| require_relative file }

module LeanCoffee
  module Discussions
    class Discussion
      module Invariants
      end
    end
  end
end
