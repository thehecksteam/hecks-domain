require_relative 'domain/root_file'
require_relative 'domain/factory_loader'
require_relative 'domain/repository_helper'
require_relative 'domain/string_support'
require_relative 'domain/repository'
require_relative 'domain/aggregate'
require_relative 'domain/domain_object'
require_relative 'domain/value_field'
require_relative 'domain/entity_field'
require_relative 'domain/list_field'
require_relative 'domain/operation'
require_relative 'domain/reference_field'
require_relative 'domain/spec_helper'
require_relative 'domain/fields'


class HecksDomain
  class Domain
    attr_reader :name, :aggregates, :spec_helper, :string_support, 
                :repository_helper, :factory_loader
    attr_accessor :ruby_file

    def initialize(name, &block)
      @name = name
      @aggregates = []
      @spec_helper = SpecHelper.new
      @factory_loader = FactoryLoader.new
      @string_support = StringSupport.new
      @domain_version = nil

      instance_eval(&block)
    end

    def summary(value)
      @summary = value
    end

    def description(value)
      @description = value
    end

    def version(value)
      @version = value
    end

    def authors(value)
      @authors = value
    end

    def email(value)
      @email = value
    end

    def homepage(value)
      @homepage = value
    end

    def aggregate(name, &block)
      @aggregates << Aggregate.new(name, self, &block)
    end

    def binding
      super
    end

    def file_name
      @file_name = folder_name + '.rb'
    end

    def folder_name
      @folder_name = @name.to_s.underscore
    end

    def domain_version(value)
      @domain_version = value
    end
  end
end