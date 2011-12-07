module Morpheus
  module Client
    module Associations
      extend ActiveSupport::Concern

      module ClassMethods

        def belongs_to_resource(association, options = {})
          define_method association do
            instance_variable_get("@#{association}") ||
              instance_variable_set("@#{association}", Morpheus::Associations::BelongsToAssociation.new(self, association, :options => options))
          end

          define_method "#{association}=" do |target|
            instance_variable_set("@#{association}", Morpheus::Associations::BelongsToAssociation.new(self, association, :target => target, :options => options))
            send("#{association}_id=", target.id)
          end

        end

        def has_many_resources(association, options = {})
          define_method association do
            instance_variable_get("@#{association}") ||
              instance_variable_set("@#{association}", Morpheus::Associations::HasManyAssociation.new(self, association, :options => options))
          end

          define_method "#{association}=" do |target|
            instance_variable_set("@#{association}", Morpheus::Associations::HasManyAssociation.new(self, association, :target => target, :options => options))
          end
        end

        def has_one_resource(association, options = {})
          define_method association do
            instance_variable_get("@#{association}") ||
              instance_variable_set("@#{association}", Morpheus::Associations::HasOneAssociation.new(self, association, :options => options))
          end

          define_method "#{association}=" do |target|
            instance_variable_set("@#{association}", Morpheus::Associations::HasOneAssociation.new(self, association, :target => target, :options => options))
          end
        end

      end

    end
  end
end
