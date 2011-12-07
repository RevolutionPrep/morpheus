module Morpheus
  module Associations
    autoload :Association,          'morpheus/associations/association'
    autoload :BelongsToAssociation, 'morpheus/associations/belongs_to_association'
    autoload :HasManyAssociation,   'morpheus/associations/has_many_association'
    autoload :HasOneAssociation,    'morpheus/associations/has_one_association'

    extend ActiveSupport::Concern

    module ClassMethods

      def belongs_to(association, options = {})
        attribute_id_sym  = "#{association}_id".to_sym

        property attribute_id_sym

        create_reflection(:belongs_to, association, options)

        define_method association do
          instance_variable_get("@#{association}") ||
            instance_variable_set("@#{association}", BelongsToAssociation.new(self, association, :options => options))
        end

        define_method "#{association}=" do |target|
          instance_variable_set("@#{association}", BelongsToAssociation.new(self, association, :target => target, :options => options))
          send("#{association}_id=", target.id)
        end
      end

      def has_many(association, options = {})
        create_reflection(:has_many, association, options)

        define_method association do
          instance_variable_get("@#{association}") ||
            instance_variable_set("@#{association}", HasManyAssociation.new(self, association, :options => options))
        end
      end

      def has_one(association, options = {})
        create_reflection(:has_one, association, options)

        define_method association do
          instance_variable_get("@#{association}") ||
            instance_variable_set("@#{association}", HasOneAssociation.new(self, association, :options => options))
        end

        define_method "#{association}=" do |target|
          instance_variable_set("@#{association}", HasOneAssociation.new(self, association, :target => target, :options => options))
        end
      end

    end

  end
end
