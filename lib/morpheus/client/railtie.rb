module Morpheus
  module Client
    class Railtie < Rails::Railtie

      if defined?(ActiveRecord)
        ActiveRecord::Base.send(:include, Morpheus::Client::Associations)
        ActiveRecord::Base.send(:include, Morpheus::UrlSupport)
      end

      initializer "polaris_client.configure_request_cache" do |app|
        app.middleware.use Morpheus::RequestQueue
        app.middleware.use Morpheus::RequestCache
      end

      initializer "polaris_resource.configure_logger", :after => :initialize_logger do |app|
        Morpheus::Configuration.logger = Rails.logger
      end

      initializer "polaris_client.log_subscriber", :after => "polaris_resource.configure_logger" do
        Morpheus::Client::LogSubscriber.attach_to :polaris_resource
      end

    end
  end
end
