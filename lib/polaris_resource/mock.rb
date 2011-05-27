module Polaris
  module Resource
    class Mock

      def initialize(mock_class, id, attributes = {}, options = {})
        @mock_class = mock_class.to_s
        @attributes = HashWithIndifferentAccess.new(attributes).merge({ 'id' => id })
        @options    = options
        
        @attributes.keys.each do |attribute|
          (class << self; self; end).class_eval do
            define_method attribute do
              @attributes[attribute]
            end
            
            define_method "#{attribute}=" do |value|
              @attributes[attribute] = value
            end
          end
        end
        
        stub_finder_methods!
      end

      def id
        @attributes[:id]
      end
      
      def status
        @options[:status] || 200
      end

      def self.mock(mock_class, id)
        new(mock_class, id)
      end
      
      def self.clear!
        Polaris::Resource::Configuration.hydra.clear_stubs
      end
      
      def self.matches?(request)
        Polaris::Resource::Configuration.hydra.stubs.any? do |stub|
          stub.matches?(request)
        end
      end
      
      private
      
      def stub_finder_methods!
        stub_find_one!
      end
      
      def stub_find_one!
        response = Typhoeus::Response.new(:code => status, :headers => "", :body => @attributes.merge({ :id => 1 }).to_json, :time => 0.3)
        Polaris::Resource::Configuration.hydra.stub(:get, find_one_uri).and_return(response)
      end
      
      def find_one_uri
        "#{Polaris::Resource::Configuration.host}/#{@mock_class.underscore.pluralize}/#{id}"
      end

    end
  end
end