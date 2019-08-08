require 'spec_helper'
require 'date'

describe "Playground" do
  include_examples 'subscriber'

  let(:match) do
    SoccerSeason::Matches::Match.new(
      fixture: fixture,
      teams: [redteam, blueteam],
      pitch: pitch,
      goals: [],
      result: nil
    ).tap(&:save)
  end

  let(:fixture) do
    SoccerSeason::Matches::Fixture.new(
      season: 2012,
      date: Date.today,
      time: Time.now
    )
  end

  let(:redteam) do
    SoccerSeason::Teams::Team.new(
      name: 'redteam'
    ).tap(&:save)
  end

  let(:blueteam) do
    SoccerSeason::Teams::Team.new(
      name: 'blueteam'
    ).tap(&:save)
  end

  let(:pitch) do
    SoccerSeason::Pitches::Pitch.new(
      name: 'downtown'
    ).tap(&:save)
  end

  let(:player_chris) do
    SoccerSeason::Players::Player.new(name: 'chris', team: redteam).tap(&:save)
  end

  let(:player_foster) do
    SoccerSeason::Players::Player.new(name: 'foster', team: redteam).tap(&:save)
  end

  let(:player_clayton) do
    SoccerSeason::Players::Player.new(name: 'clayton', team: blueteam).tap(&:save)
  end

  describe 'Playground' do
    before do
      [player_foster, player_chris, player_chris, player_clayton, player_clayton].each do |player|
        match.add_goal!(time: Time.now, player: player)
      end
    end

    it 'has a head' do
      expect(
        SoccerSeason::Pitches::Head.superclass
      ).to eq SoccerSeason::Pitches::Pitch
    end

    it 'Events' do
      # Events
      HecksDomain::Events.subscribe(LoggingSubscriber.new('*'))

      match.score! do |event|
        Logger.log(event)
      end
    end

    it 'Winner!' do
      match.score!
      expect(match.result.winner).to eq redteam
    end

    it 'Tied Result' do
      match.add_goal!(time: Time.now, player: player_clayton)
      match.score!
      expect(match.result).to be_a(SoccerSeason::Matches::TiedResult)
    end

    it 'Invariants' do
      match.teams << redteam
      expect { match.save }.to raise_error('Must have two teams')
    end
  end
end