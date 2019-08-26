module LeanCoffee
  module Meetings
    class Meeting
      module Commands
        class MoveDiscussionToTop
          attr_reader :args, :head

          def initialize(meeting, discussion)
            @meeting = meeting
            @head = meeting
            @discussion = discussion
          end

          def call
            discussion = @discussion
            @meeting.discussion_list.instance_eval do
              for_top = @positions.find do |position|
                position.discussion == discussion
              end

              @positions.unshift @positions.delete(for_top)
            end

            self
          end
        end
      end
    end
  end
end