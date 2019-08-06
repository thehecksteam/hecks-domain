require_relative 'match/factories'
require_relative 'match/repository'
require_relative 'match/commands'
require_relative 'match/invariants'

module SoccerSeason
  module Matches
    class Match
      include HecksDomain::Factories::FactoryLoader
      include Helpers::Repository
      include HecksDomain::Commands::CommandLoader
      include Invariants

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