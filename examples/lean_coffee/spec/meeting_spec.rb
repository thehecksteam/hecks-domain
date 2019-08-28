require 'spec_helper'

describe LeanCoffee::Meetings::Meeting do
  let(:meeting) do
    described_class.default(
      allowed_votes: 5,
      timebox_extension: 1,
      topics: [],
      time_boxes: { voting: 0, collection: 0, ordering: 0 },
      participants: [{ name: 'Angie' }, { name: 'Chris' }]
    )
  end

  let(:chris) do
    meeting.find_participant(name: 'Chris')
  end

  let(:angie) do
    meeting.find_participant(name: 'Angie')
  end

  let(:lean_coffee_topic) do
    LeanCoffee::Topics::Topic.new(
      value: 'lean coffee', votes: 0, timebox: LeanCoffee::Topics::Timebox.zeroed
    )
  end

  let(:retrospective_topic) do
    LeanCoffee::Topics::Topic.new(
      value: 'retrospective', votes: 0, timebox: LeanCoffee::Topics::Timebox.zeroed
    )
  end

  describe '.example' do
    it 'Needs timeboxes' do
      expect(
        LeanCoffee::Meetings::Meeting.example
      ).to be
    end
  end

  describe '#add_topic!' do
    it 'needs to be in the right phase' do
      expect { meeting.add_topic!(lean_coffee_topic) }
      .to raise_error 'Waiting to choose a phase'
    end

    it 'adds to the topic list' do
      meeting.start_collecting!
      meeting.add_topic!(lean_coffee_topic)
      expect(meeting.topics.count).to eq 1
    end
  end

  describe '#start_collecting' do
    it 'sets the phase' do
      meeting.start_collecting!
      expect(meeting.phase).to eq :collecting
    end

    it 'ends the phase' do
      meeting.start_collecting!
      sleep(0.001)
      expect(meeting.phase).to eq :waiting
    end
  end

  describe '#start_voting' do
    it 'sets the phase' do
      meeting.start_voting!
      expect(meeting.phase).to eq :voting
    end
  end

  describe '#start_ordering!' do
    it 'sets the phase' do
      meeting.start_ordering!
      expect(meeting.phase).to eq :ordering
    end
  end

  describe '#order_by_votes!' do
    before do
      meeting.start_collecting!
      meeting.add_topic!(lean_coffee_topic)
      meeting.add_topic!(retrospective_topic)

      meeting.start_voting!

      meeting.vote!(topic: lean_coffee_topic, participant: chris)
      meeting.vote!(topic: lean_coffee_topic, participant: chris)
      meeting.vote!(topic: retrospective_topic, participant: angie)
      meeting.start_ordering!
    end

    it 'moves the topic with the most votes to be discussed first' do
      meeting.order_by_votes!
      expect(meeting.topics.first).to eq lean_coffee_topic
    end
  end

  describe '#vote!' do
    before do
      meeting.start_voting!
    end

    it 'adds a vote to the topic' do
      meeting.vote!(topic: lean_coffee_topic, participant: chris)
      expect(lean_coffee_topic.votes).to eq 1
    end

    it 'reduces the votes remaining for the participant' do
      meeting.vote!(topic: lean_coffee_topic, participant: chris)
      expect(chris.remaining_votes).to eq 4
    end
  end

  describe '#move_topic_to_top!' do
    before do
      meeting.start_collecting!
      meeting.add_topic!(lean_coffee_topic)
      meeting.add_topic!(retrospective_topic)
      meeting.start_ordering!
    end

    it 'moves the topic to the top of the list' do
      last = meeting.topics.last
      meeting.move_topic_to_top!(last)
      expect(meeting.topics.first).to eq last
    end
  end
  

  describe '#move_topic_to_bottom!' do
    before do
      meeting.start_collecting!
      meeting.add_topic!(lean_coffee_topic)
      meeting.add_topic!(retrospective_topic)
      meeting.start_ordering!
    end

    it 'moves the topic to the top of the list' do
      first = meeting.topics.first
      meeting.move_topic_to_bottom!(first)
      expect(meeting.topics.last).to eq first
    end
  end

  describe '#start_discussing!' do
    before do
      meeting.start_collecting!
      meeting.add_topic!(lean_coffee_topic)
      meeting.add_topic!(retrospective_topic)
    end

    it 'sets the phase' do
      meeting.start_discussing!
      expect(meeting.phase).to eq :discussing
    end

    it 'sets the topic we are currently discussing' do
      meeting.start_discussing!
      expect(meeting.discussing).to eq(lean_coffee_topic)
    end
  end
end