module PolarisResource
  module Finders
    extend ActiveSupport::Concern

    module ClassMethods

      def find(*args)
        options = args.extract_options!
        if args.length == 1
          case args.first
          when Integer, String
            get(find_one_uri(args.first.to_i))
          when Array
            get(find_all_uri, { :ids => args.first })
          else
            raise ArgumentError, "Unrecognized argument (#{args.first.inspect})."
          end
        else
          get(find_all_uri, { :ids => args })
        end
      end

      def all
        get(find_all_uri)
      end

      def first
        limit(1).first
      end

      def where(query_attributes)
        Relation.new(self).where(query_attributes)
      end

      def limit(amount)
        Relation.new(self).limit(amount)
      end

      def page(page_number)
        Relation.new(self).page(page_number)
      end

      def results_per_page
        @results_per_page || 10
      end

      def results_per_page=(_results_per_page)
        @results_per_page = _results_per_page
      end

      def find_one_uri(id)
        "#{find_all_uri}/#{id}"
      end
      private :find_one_uri

      def find_all_uri
        "/#{plural_url_name}"
      end

    end

  end
end