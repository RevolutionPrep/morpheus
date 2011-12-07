module Morpheus
  module Client
    class Railtie < Rails::Railtie

      if defined?(ActiveRecord)
        ActiveRecord::Base.send(:include, Morpheus::Client::Associations)
        ActiveRecord::Base.send(:include, Morpheus::UrlSupport)
      end

      initializer "morpheus.client.configure_request_cache" do |app|
        app.middleware.use Morpheus::RequestQueue
        app.middleware.use Morpheus::RequestCache
      end

      initializer "morpheus.configure_logger", :after => :initialize_logger do |app|
        Morpheus::Configuration.logger = Rails.logger
      end

      initializer "morpheus.client.log_subscriber", :after => "morpheus.configure_logger" do
        Morpheus::Client::LogSubscriber.attach_to :morpheus
      end

    end
  end
end
