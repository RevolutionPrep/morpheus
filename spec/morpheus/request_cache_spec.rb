require 'spec_helper'

describe Morpheus::RequestCache do
  let(:app) { mock(:call => nil) }
  let(:cache) { Morpheus::RequestCache.new(app) }

  describe '#initialize' do
    it 'takes an app instance and sets its instance variable' do
      obj = Object.new
      cache = Morpheus::RequestCache.new(obj)
      cache.instance_variable_get('@app').should eql(obj)
    end
  end

  describe '#call' do
    it 'clears the cache hash' do
      Morpheus::RequestCache.cache.should_receive(:clear)
      cache.call(Object.new)
    end

    it 'delegates to the app with the env' do
      env = Object.new
      app.should_receive(:call).with(env)
      cache.call(env)
    end
  end

  describe '.cache' do
    it 'returns the global cache hash' do
      cache_hash = Morpheus::RequestCache.cache
      cache_hash.should be_kind_of(Hash)
      cache_hash.should be_empty
    end
  end

end
