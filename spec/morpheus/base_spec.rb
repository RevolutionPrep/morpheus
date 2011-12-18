require 'spec_helper'

describe Morpheus::Base do

  describe 'ActiveModel lint' do
    let(:model_under_test) { Morpheus::Base.new }
    it_behaves_like 'ActiveModel'
  end

  describe 'implements Morpheus::Associations' do
    it 'includes the Morpheus::Associations module' do
      Morpheus::Base.included_modules.should include(Morpheus::Associations)
    end
  end

  describe 'implements Morpheus::Attributes' do
    it 'includes the Morpheus::Attributes module' do
      Morpheus::Base.included_modules.should include(Morpheus::Attributes)
    end
  end

  describe 'implements Morpheus::Conversion' do
    it 'includes the Morpheus::Conversion module' do
      Morpheus::Base.included_modules.should include(Morpheus::Conversion)
    end
  end

  describe 'implements Morpheus::Filtering' do
    it 'includes the Morpheus::Filtering module' do
      Morpheus::Base.included_modules.should include(Morpheus::Filtering)
    end
  end

  describe 'implements Morpheus::Finders' do
    it 'includes the Morpheus::Finders module' do
      Morpheus::Base.included_modules.should include(Morpheus::Finders)
    end
  end

  describe 'implements Morpheus::Introspection' do
    it 'includes the Morpheus::Introspection module' do
      Morpheus::Base.included_modules.should include(Morpheus::Introspection)
    end
  end

  describe 'implements Morpheus::Persistence' do
    it 'includes the Morpheus::Persistence module' do
      Morpheus::Base.included_modules.should include(Morpheus::Persistence)
    end
  end

  describe 'implements Morpheus::Reflections' do
    it 'includes the Morpheus::Reflections module' do
      Morpheus::Base.included_modules.should include(Morpheus::Reflections)
    end
  end

  describe 'implements Morpheus::RequestHandling' do
    it 'includes the Morpheus::RequestHandling module' do
      Morpheus::Base.included_modules.should include(Morpheus::RequestHandling)
    end
  end

  describe 'implements Morpheus::ResponseParsing' do
    it 'includes the Morpheus::ResponseParsing module' do
      Morpheus::Base.included_modules.should include(Morpheus::ResponseParsing)
    end
  end

  describe 'implements Morpheus::UrlSupport' do
    it 'includes the Morpheus::UrlSupport module' do
      Morpheus::Base.included_modules.should include(Morpheus::UrlSupport)
    end
  end

  describe '#initialize' do
    context 'when no attributes hash is supplied' do
      before(:each) do
        @auto = Automobile.new
      end

      it 'has attributes that are set to nil' do
        @auto.attributes.should eql(HashWithIndifferentAccess.new({ :id => nil, :bhp => nil, :wheels => nil, :hybrid => nil, :name => nil }))
      end
    end

    context 'when an attributes hash is supplied' do
      before(:each) do
        @auto = Automobile.new(
          :bhp    => 300,
          :wheels => 4,
          :hybrid => false,
          :name   => 'Roadster'
        )
      end

      it 'has attributes that are set to nil' do
        @auto.attributes.should eql(HashWithIndifferentAccess.new({ :id => nil, :bhp => 300, :wheels => 4, :hybrid => false, :name => 'Roadster' }))
      end
    end
  end

  describe 'defines an id property by default' do
    it 'defines setter and getter methods for the id property' do
      base = Morpheus::Base.new(:id => 5)
      Morpheus::Base.stub(:get).and_return(base)
      @base = Morpheus::Base.find(1)
      @base.should respond_to(:id)
      @base.id.should eql(5)
    end

    it 'creates an attribute entry for the id property' do
      Morpheus::Base.new.attributes.should include(:id)
    end
  end

  describe Morpheus::Base, '#==' do
    pending
  end

  describe Morpheus::Base, '.base_class' do
    it 'returns the current class' do
      Dog.base_class.should eql(Dog)
    end
  end

  describe '#method_missing' do
    pending
  end
end
