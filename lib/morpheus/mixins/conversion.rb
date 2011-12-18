module Morpheus
  module Conversion

    def to_model
      self
    end

    def to_param
      id.to_s unless new_record?
    end

    def to_key
      attributes.keys if persisted?
    end

  end
end
