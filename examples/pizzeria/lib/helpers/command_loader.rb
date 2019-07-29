module Pizzeria
  module Helpers
    module CommandLoader
      def self.included(base)
        base::Commands.constants.each do |constant|
          base.class_eval "
            def self.#{constant.to_s.underscore}(args)
              Commands::#{constant}.new(*args).call  
            end
          "
        end
      end
    end
  end
end
