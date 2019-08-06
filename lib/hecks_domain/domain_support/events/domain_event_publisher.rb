class HecksDomain
  module Events
    class DomainEventPublisher
      include Singleton
      attr_reader :subscribers
      def initialize
        @subscribers = []
      end

      def self.emit(command, &block)
        instance.emit(DomainEvent.new(command), &block)
      end

      def self.subscribe(subscriber)
        instance.subscribers << subscriber
      end

      def emit(domain_event, &block)
        yield domain_event if block
        @subscribers.each do |subscriber|
          next unless subscriber.event_name == '*' ||
                      subscriber.event_name == domain_event.name

          subscriber.notify(domain_event)
        end
      end
    end
  end
end
