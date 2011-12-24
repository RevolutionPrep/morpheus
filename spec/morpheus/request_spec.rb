require 'spec_helper'

describe Morpheus::Request do
  let(:request) do
    Morpheus::Request.new('/path', :method => :get, :params => { :one => 1 })
  end
  let(:response) { Morpheus::Response.new }

  describe '#initialize' do
    pending
  end

  describe '#cache_key' do
    it 'returns a hash of the array [method, url, params]' do
      key = [request.method, request.url, request.params].hash
      request.cache_key.should eql(key)
    end
  end

  describe '#response=' do
    it 'sets the response for this request' do
      request.response = response
      request.response.should eql(response)
    end

    it 'sets the response in the RequestCache' do
      request.response = response
      Morpheus::RequestCache.cache[request.cache_key].should eql(response)
    end

    it 'tags the response for caching' do
      response.should_receive(:tag_for_caching!)
      request.response = response
    end
  end

  describe '#response' do
    it 'checks to see if the request is in the queue' do
      Morpheus::RequestQueue.should_receive(:has_request?).with(request)
      request.response
    end

    context 'when the request is in the RequestQueue' do
      before do
        Morpheus::RequestQueue.stub(:has_request?).and_return(true)
      end

      it 'calls .run! on RequestQueue' do
        Morpheus::RequestQueue.should_receive(:run!)
        request.response
      end
    end

    context 'when the request is not in the RequestQueue' do
      before do
        Morpheus::RequestQueue.stub(:has_request?).and_return(false)
      end

      it 'does not call .run! on RequestQueue' do
        Morpheus::RequestQueue.should_not_receive(:run!)
        request.response
      end
    end

    context 'when the RequestCache has a cached response for this request' do
      before do
        Morpheus::RequestCache.cache[request.cache_key] = response
      end

      it 'returns the response from the cache' do
        request.response.should eql(response)
      end
    end

    context 'when the RequestCache does not have a cached response for this request' do
      pending
    end
  end

  describe '.enqueue' do
    let(:method) { :get }
    let(:path)   { '/path' }
    let(:params) { { :one => 1 } }

    context 'when using method, path, and params' do
      it 'creates a new Request object with the path, method, and params' do
        Morpheus::Request.should_receive(:new).with(path, { :method => method, :params => params })
        Morpheus::Request.enqueue(method, path, params)
      end
    end

    context 'when only using method and path' do
      it 'creates a new Request object with only the path and method' do
        Morpheus::Request.should_receive(:new).with(path, { :method => method })
        Morpheus::Request.enqueue(method, path, {})
      end
    end

    it 'queues up the request on the RequestQueue' do
      Morpheus::Request.stub(:new).and_return(request)
      Morpheus::RequestQueue.should_receive(:enqueue).with(request)
      Morpheus::Request.enqueue(method, path, params)
    end
  end

end
