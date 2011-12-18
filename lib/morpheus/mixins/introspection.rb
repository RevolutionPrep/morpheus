module Morpheus
  module Introspection

    def persisted?
      !id.nil?
    end

    def new_record?
      !persisted?
    end

    def destroyed?
      false
    end

    def respond_to?(method, include_private = false)
      attributes.include?(method) ? true : super
    end

  end
end
