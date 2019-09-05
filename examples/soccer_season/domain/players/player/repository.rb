module SoccerSeason
  module Domain
    module Players
      class Player
        class Repository
          include Singleton
          def self.save(object)
            object.test_invariants
            instance.save(object)
          end

          def self.fetch(domain_object)
            instance.fetch(domain_object)
          end

          def initialize
            @objects = {}
          end

          def fetch(domain_object)
            @objects[domain_object.id]
          end

          def save(object)
            @objects[object.hash] = object

            object.instance_eval do
              @id = object.hash
            end

            object
          end
        end
      end
    end
  end
end
