module Morpheus
  module ResponseParsing

    def self.included(base)
      base.extend(ClassMethods)
    end

    module ClassMethods

      def response_from_request(request, metadata)
        ResponseParser.parse(self, request, metadata)
      end

    end

    def build_from_response(response)
      content = Yajl::Parser.parse(response.body)['content']
      if content.keys.include?('type')
        content['type'].constantize.new.merge_attributes(content)
      else
        merge_attributes(content)
      end
    end
    private :build_from_response

  end
end
