['commands', 'services', 'invariants', 'factories', 'repository', 'queries', 'events', 'subscribers'].each do |name|
  Dir[File.dirname(__FILE__) + "/team/#{name}/*.rb"].each { |file| require_relative file }
end

require_relative 'team/repository'
['factories'].each do |name|
  Dir[File.dirname(__FILE__) + "/team/#{name}/*.rb"].each { |file| require_relative file }
end

module SoccerSeason
  module Domain
    module Teams
      class Team
        include Support::Factories::FactoryLoader
        include Support::Invariants::InvariantLoader
        include Support::Commands::CommandLoader
        include Support::Queries::QueryLoader

        attr_reader :name, :id

        def initialize(name:)
          @name = name
        end

        private

        attr_writer :name, :id
      end
    end
  end
end
