module Morpheus
  module Attributes
    extend ActiveSupport::Concern

    module ClassMethods

      def property(name, typecast_class = nil)
        typecast_attributes.store(name.to_sym, typecast_class)
        default_attributes.store(name.to_sym, nil)

        define_attribute_accessor(name)
      end

      def default_attributes
        @attributes ||= HashWithIndifferentAccess.new(superclass.respond_to?(:default_attributes) ? superclass.default_attributes : {})
      end

      def typecast_attributes
        @typecast_attributes ||= HashWithIndifferentAccess.new(superclass.respond_to?(:default_attributes) ? superclass.default_attributes : {})
      end

      def attribute_defined?(attribute)
        default_attributes.keys.include?(attribute.to_s)
      end

      def define_attribute_accessor(method)
        method = method.to_s.delete('=')
        define_method("#{method}=") do |value|
          send("#{method}_will_change!")
          update_attribute(method, value)
        end

        define_method(method) do
          attributes[method]
        end

        define_attribute_methods [method]
      end
      private :define_attribute_accessor

    end

    module InstanceMethods

      def attributes
        @attributes ||= self.class.default_attributes.dup
      end

      def read_attribute_for_validation(key)
        attributes[key]
      end

      def typecast(attribute, value)
        TypeCaster.cast(value, self.class.typecast_attributes[attribute.to_sym])
      end

      def attributes_without_basic_attributes
        attributes_to_reject = %w( id errors valid )
        self.class.reflections.keys.each do |key|
          attributes_to_reject.push(key.to_s)
        end
        attributes.reject do |key, value|
          attributes_to_reject.include?(key)
        end
      end

      def update_attribute(attribute, value)
        reflection = self.class.reflect_on_association(attribute)
        if reflection
          update_reflection(reflection, attribute, value)
        else
          attributes[attribute.to_sym] = typecast(attribute, value)
        end
      end

      def update_reflection(reflection, attribute, value)
        return unless value
        if reflection.macro == :has_many # need to construct each member of array one-by-one
          association_object = send(attribute)
          value.each do |a_value|
            if a_value.instance_of? reflection.klass
              target = a_value
            else
              target = reflection.build_association(a_value)
            end
            association_object << target
          end
        elsif reflection.macro == :belongs_to
          if value.instance_of? reflection.klass
            target = value
          else
            if reflection.options[:polymorphic]
              polymorphic_class = send("#{reflection.name}_type".to_sym)
              polymorphic_class = value['type'] if value.include?('type')
              target = polymorphic_class.constantize.new(value)
            else
              target = reflection.build_association(value)
            end
          end
          send("#{attribute}=", target)
        else
          if value.instance_of? reflection.klass
            target = value
          else
            target = reflection.build_association(value)
          end
          send("#{attribute}=", target)
        end
      end

      def merge_attributes(new_attributes)
        new_attributes.each do |key, value|
          case key.to_sym
          when :errors
            value.each do |k, v|
              v.each do |message|
                errors.add(k, message)
              end
            end
          when :valid
            @valid = value
          else
            update_attribute(key, value)
          end
        end
        self
      end
      private :merge_attributes

    end

  end
end
