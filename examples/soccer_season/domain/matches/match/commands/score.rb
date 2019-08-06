module SoccerSeason
  module Matches
    class Match
      module Commands
        class Score
          attr_reader :args, :head

          def initialize(match, *args)
            @head = match
            @args = args
            @match = match
            @team_a = match.teams.first
            @team_b = match.teams.last
          end

          def get_goals
            @team_a_goals = @match.goals.select { |goal| goal.player.team == @team_a }.count
            @team_b_goals = @match.goals.select { |goal| goal.player.team == @team_b }.count
          end

          def get_winner_and_loser
            if @team_a_goals > @team_b_goals
              @winner = @team_a
              @loser = @team_b
            elsif @team_b_goals > @team_a_goals
              @winner = @team_b
              @loser = @team_a
            end
          end

          def call
            get_goals
            get_winner_and_loser
            if @winner
              @match.result = Result.new(
                winner: @winner,
                loser: @loser
              )
            else
              @match.result = TiedResult.new
            end
              
            @match.save
            self
          end
        end
      end
    end
  end
end