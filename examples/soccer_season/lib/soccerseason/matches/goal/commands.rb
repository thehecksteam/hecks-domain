Dir[File.dirname(__FILE__) + '/commands/*.rb'].each {|file| require_relative file }
module SoccerSeason
  module Matches
    class Goal
      module Commands
      end
    end
  end
end