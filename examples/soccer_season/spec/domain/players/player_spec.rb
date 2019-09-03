require 'spec_helper'

describe SoccerSeason::Players::Player do
  subject { match }

  describe '.default' do
    SoccerSeason::Players::Player.default(
      name: 'redteam', team: { name: 'foo' }
    )
  end
end
