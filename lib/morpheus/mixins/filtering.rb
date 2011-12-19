module Morpheus
  module Filtering

    def self.included(base)
      base.extend(ClassMethods)
    end

    module ClassMethods

      def filter(name, &block)
        (@filters ||= []) << Filter.new(name, &block)
      end

      def find_filter(name)
        (@filters ||= []).find { |filter| filter.name == name }
      end

    end

  end
end
