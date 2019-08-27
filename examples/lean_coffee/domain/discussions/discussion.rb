require_relative 'discussion/commands'
require_relative 'discussion/invariants'
require_relative 'discussion/factories'
require_relative 'discussion/repository'
require_relative 'discussion/queries'
require_relative 'discussion/events'
require_relative 'discussion/subscribers'

module LeanCoffee
  module Discussions
    class Discussion
      include HecksDomain::Factories::FactoryLoader
      include HecksDomain::Invariants::InvariantLoader
      include HecksDomain::Commands::CommandLoader
      include HecksDomain::Queries::QueryLoader

      attr_reader :topic, :votes, :timebox, :id

      def initialize(topic:, votes:, timebox:)
        @topic = topic
        @votes = votes
        @timebox = timebox
      end

      private

      attr_writer :topic, :votes, :timebox, :id
    end
  end
end
