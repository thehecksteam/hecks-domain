require_relative 'pitch/factories'
require_relative 'pitch/repository'
require_relative 'pitch/commands'

module SoccerSeason
  module Pitches
    class Pitch
      include HecksDomain::Factories::FactoryLoader
      include Helpers::Repository
      include HecksDomain::Commands::CommandLoader

      attr_accessor :name, :id

      def initialize name:
        @name = name
      end
    end
  end
end