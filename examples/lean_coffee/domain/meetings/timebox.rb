
module LeanCoffee
  module Meetings
    class Timebox

      attr_reader :duration, :start_time, :end_time

      def initialize(duration:, start_time: nil, end_time: nil)
        @duration = duration
        @start_time = start_time
        @end_time = end_time
      end

      private

      attr_writer :duration, :start_time, :end_time
    end
  end
end
