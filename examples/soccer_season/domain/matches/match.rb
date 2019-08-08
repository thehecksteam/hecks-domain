require_relative 'match/factories'
require_relative 'match/invariants'
require_relative 'match/repository'
require_relative 'match/commands'

module SoccerSeason
  module Matches
    class Match
      include HecksDomain::Factories::FactoryLoader
      include Invariants
      include Helpers::Repository
      include HecksDomain::Commands::CommandLoader

      attr_accessor :fixture, :goals, :teams, :pitch, :result, :id

      def initialize fixture:, goals:, teams:, pitch:, result:
        @fixture = fixture
        @goals = goals
        @teams = teams
        @pitch = pitch
        @result = result
      end
    end
  end
end
