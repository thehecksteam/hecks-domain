
module LeanCoffee
  module Discussions
    class Timebox

      attr_reader :duration, :extension

      def initialize(duration:, extension:)
        @duration = duration
        @extension = extension
      end

      private

      attr_writer :duration, :extension
    end
  end
end
