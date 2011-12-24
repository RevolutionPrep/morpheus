require 'spec_helper'

describe Morpheus::Configuration do

  describe '.host' do
    context 'when host has not been set' do
      before(:each) do
        Morpheus::Configuration.host = nil
      end

      it 'raises a ConfigurationError' do
        lambda {
          Morpheus::Configuration.host
        }.should raise_error(Morpheus::ConfigurationError,
          'The request HOST has not been set. Please set the host using Morpheus::Configuration.host = "http://www.example.com"')
      end
    end

    context 'when host has been set' do
      before(:each) do
        Morpheus::Configuration.host = 'http://localhost:3000'
      end

      it 'returns the host url string' do
        Morpheus::Configuration.host.should eql('http://localhost:3000')
      end
    end
  end

  describe '.hydra' do
    context 'when hydra has not been set' do
      before(:each) do
        Morpheus::Configuration.hydra = nil
      end

      it 'returns the shared Hydra instance from Typhoeus' do
        Morpheus::Configuration.hydra.should eql(Typhoeus::Hydra.hydra)
      end
    end

    context 'when hydra has been set' do
      before(:each) do
        @hydra = Typhoeus::Hydra.new
        Morpheus::Configuration.hydra = @hydra
      end

      it 'returns the specified Typhoeus Hydra instance' do
        Morpheus::Configuration.hydra.should eql(@hydra)
      end
    end
  end

  describe '.logger' do
    before(:all) do
      @original_logger = Morpheus::Configuration.logger
    end

    after(:all) do
      Morpheus::Configuration.logger = @original_logger
    end

    context 'when logger has not been set' do
      before(:each) do
        Morpheus::Configuration.logger = nil
      end

      it 'returns the default Logger instance' do
        Morpheus::Configuration.logger.should be_a(Logger)
      end
    end

    context 'when logger has been set' do
      before(:each) do
        @logger = Logger.new(STDOUT)
        Morpheus::Configuration.logger = @logger
      end

      it 'returns the specified Logger instance' do
        Morpheus::Configuration.logger.should eql(@logger)
      end
    end
  end

  describe '.allow_net_connect' do
    it 'disables all net connections through Typhoeus' do
      Morpheus::Configuration.allow_net_connect = false
      lambda {
        Typhoeus::Request.get('http://localhost:3000')
      }.should raise_error(Morpheus::NetConnectNotAllowedError)
    end
  end

  describe '.allow_net_connect?' do
    context 'when net connect is allowed' do
      before(:each) do
        Morpheus::Configuration.allow_net_connect = true
      end

      it 'returns true' do
        Morpheus::Configuration.should be_allow_net_connect
      end
    end

    context 'when net connect is not allowed' do
      before(:each) do
        Morpheus::Configuration.allow_net_connect = false
      end

      it 'returns true' do
        Morpheus::Configuration.should_not be_allow_net_connect
      end
    end
  end

end
