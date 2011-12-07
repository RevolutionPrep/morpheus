require 'spec_helper'

describe Morpheus::Base, "ActiveModel Lint" do

  let(:model_under_test) { Morpheus::Base.new }
  it_behaves_like "ActiveModel"

end

describe Morpheus::Base, "implements Morpheus::Associations" do
  
  it "includes the Morpheus::Associations module" do
    Morpheus::Base.included_modules.should include(Morpheus::Associations)
  end
  
end

describe Morpheus::Base, "implements Morpheus::Attributes" do
  
  it "includes the Morpheus::Attributes module" do
    Morpheus::Base.included_modules.should include(Morpheus::Attributes)
  end
  
end

describe Morpheus::Base, "implements Morpheus::Conversion" do
  
  it "includes the Morpheus::Finders module" do
    Morpheus::Base.included_modules.should include(Morpheus::Conversion)
  end
  
end

describe Morpheus::Base, "implements Morpheus::Finders" do
  
  it "includes the Morpheus::Finders module" do
    Morpheus::Base.included_modules.should include(Morpheus::Finders)
  end
  
end

describe Morpheus::Base, "implements Morpheus::Introspection" do
  
  it "includes the Morpheus::Finders module" do
    Morpheus::Base.included_modules.should include(Morpheus::Introspection)
  end
  
end

describe Morpheus::Base, "implements Morpheus::Persistence" do
  
  it "includes the Morpheus::Persistence module" do
    Morpheus::Base.included_modules.should include(Morpheus::Persistence)
  end
  
end

describe Morpheus::Base, "implements Morpheus::ResponseParsing" do
  
  it "includes the Morpheus::Finders module" do
    Morpheus::Base.included_modules.should include(Morpheus::ResponseParsing)
  end
  
end

describe Morpheus::Base, ".initialize" do
  
  context "when no attributes hash is supplied" do
    
    before(:each) do
      @auto = Automobile.new
    end
    
    it "has attributes that are set to nil" do
      @auto.attributes.should eql(HashWithIndifferentAccess.new({ :id => nil, :bhp => nil, :wheels => nil, :hybrid => nil, :name => nil }))
    end
    
  end
  
  context "when an attributes hash is supplied" do
    
    before(:each) do
      @auto = Automobile.new(
        :bhp    => 300,
        :wheels => 4,
        :hybrid => false,
        :name   => "Roadster"
      )
    end
    
    it "has attributes that are set to nil" do
      @auto.attributes.should eql(HashWithIndifferentAccess.new({ :id => nil, :bhp => 300, :wheels => 4, :hybrid => false, :name => "Roadster" }))
    end
    
  end
  
end

describe Morpheus::Base, "defines an id property by default" do
  
  it "defines setter and getter methods for the id property" do
    base = Morpheus::Base.new(:id => 5)
    
    Morpheus::Base.stub(:get).and_return(base)
    @base = Morpheus::Base.find(1)
    @base.should respond_to(:id)
    @base.id.should eql(5)
  end
  
  it "creates an attribute entry for the id property" do
    Morpheus::Base.new.attributes.should include(:id)
  end
  
end

describe Morpheus::Base, ".==" do
  pending
end

describe Morpheus::Base, "#base_class" do

  it "returns the current class" do
    Dog.base_class.should eql(Dog)
  end

end
