class HecksDomain
  module Generators
    class Spec < Thor::Group
      include Thor::Actions

      attr_reader :aggregate_name, :domain_name, :root_name, :domain, :aggregate, :root

      def initialize(args, options)
        @domain = args[0]
        @aggregate = args[1]
        @root = args[2]

        @domain_name = @domain.name.to_s.underscore
        @aggregate_name = @aggregate.name.to_s.underscore
        @root_name = @root.name.to_s.underscore
        super
      end

      argument :name

      def self.source_root
        File.dirname(__FILE__) + '/../templates'
      end

      def write_directory
        directory('spec', skip: options[:skip_spec_generation])
      end
    end
  end
end
