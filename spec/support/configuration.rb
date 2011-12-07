Morpheus::Configuration.host = 'http://localhost:3000'
Morpheus::Configuration.hydra = Typhoeus::Hydra.new
Morpheus::Configuration.allow_net_connect = false

module MorpheusHelper
  
  def build_polaris_response(status, content, errors = nil)
    body = {
      :status  => status,
      :content => content
    }
    body.merge!(errors) if errors
    Morpheus::Response.new(:code => status, :headers => "", :body => body.to_json, :time => 0.3)
  end
  
end

RSpec.configure do |config|
  config.include(MorpheusHelper)
  
  config.before(:each) do
    Morpheus::Configuration.hydra.clear_stubs
    Morpheus::RequestQueue.queue.clear
    Morpheus::RequestCache.cache.clear
  end
end
