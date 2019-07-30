module Pizzeria
  module Helpers
    module FactoryLoader
      def self.included(base)
        base::Factories.constants.each do |constant|
          base.class_eval "
            def self.#{constant.to_s.underscore}(args)
              Factories::#{constant}.factory(*args)
            end
          "
        end
      end
    end
  end
end