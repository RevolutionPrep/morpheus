require 'spec_helper'

describe PolarisResource::Finders, "#find" do
  
  context "when the argument is a single integer" do
    
    context "when this record exists on the external service" do
      
      before(:each) do
        body = {
          :status  => 200,
          :content => Dog.new(:name => "Daisy", :breed => "English Bulldog").attributes.merge(:id => 1)
        }
        @response = PolarisResource::Response.new(:code => 200, :headers => "", :body => body.to_json, :time => 0.3)
        PolarisResource::Request.stub(:get).and_return(@response)
      end
      
      it "makes a request to /dogs/1 at the external service" do
        PolarisResource::Request.should_receive(:get).with("/dogs/1", {}).and_return(@response)
        Dog.find(1)
      end
      
      it "returns the instance representing this found record" do
        @dog = Dog.find(1)
        @dog.should be_a(Dog)
        @dog.id.should eql(1)
        @dog.name.should eql("Daisy")
        @dog.breed.should eql("English Bulldog")
      end
      
    end
    
    context "when this record does not exist on the external service" do
      
      before(:each) do
        body = {
          :status  => 404,
          :content => nil
        }
        @response = PolarisResource::Response.new(:code => 404, :headers => "", :body => body.to_json, :time => 0.3)
        PolarisResource::Request.stub(:get).and_return(@response)
      end
      
      it "raises a ResourceNotFound error" do
        lambda { Dog.find(1) }.should raise_error(PolarisResource::ResourceNotFound, "Couldn't find Dog with ID=1")
      end
      
    end
    
  end
  
  context "when the argument is a single array" do
    
    context "when all records exists on the external service" do
      
      before(:each) do
        dogs =  [Dog.new(:name => "Daisy", :breed => "English Bulldog").attributes.merge(:id => 1)]
        dogs << Dog.new(:name => "Wilbur", :breed => "Hounddog").attributes.merge(:id => 2)
        dogs << Dog.new(:name => "Fido", :breed => "Dalmatian").attributes.merge(:id => 3)
        body = {
          :status  => 200,
          :content => dogs
        }
        @response = PolarisResource::Response.new(:code => 200, :headers => "", :body => body.to_json, :time => 0.3)
        PolarisResource::Request.stub(:get).and_return(@response)
      end
      
      it "makes a request to /dogs?ids=1,2,3 at the external service" do
        PolarisResource::Request.should_receive(:get).with("/dogs", { :ids => [1,2,3] }).and_return(@response)
        Dog.find([1,2,3])
      end
      
      it "returns an array of instances representing these found records" do
        @dogs = Dog.find([1,2,3])
        @dogs.should be_an(Array)
        @dogs.should have(3).dogs
        @dogs.each do |dog|
          dog.should be_a(Dog)
        end
      end
      
    end
    
    context "when there is a requested record that does not exist on the external service" do
      
      before(:each) do
        body = {
          :status  => 404,
          :content => nil
        }
        @response = PolarisResource::Response.new(:code => 404, :headers => "", :body => body.to_json, :time => 0.3)
        PolarisResource::Request.stub(:get).and_return(@response)
      end
      
      it "raises a ResourceNotFound error" do
        lambda { Dog.find([1,2,3]) }.should raise_error(PolarisResource::ResourceNotFound, "Couldn't find all Dogs with IDs (1, 2, 3)")
      end
      
    end
    
  end
  
  context "when there are multiple arguments, each being an integer" do
    
    context "when all records exists on the external service" do
      
      before(:each) do
        dogs =  [Dog.new(:name => "Daisy", :breed => "English Bulldog").attributes.merge(:id => 1)]
        dogs << Dog.new(:name => "Wilbur", :breed => "Hounddog").attributes.merge(:id => 2)
        dogs << Dog.new(:name => "Fido", :breed => "Dalmatian").attributes.merge(:id => 3)
        body = {
          :status  => 200,
          :content => dogs
        }
        @response = PolarisResource::Response.new(:code => 200, :headers => "", :body => body.to_json, :time => 0.3)
        PolarisResource::Request.stub(:get).and_return(@response)
      end
      
      it "makes a request to /dogs?ids=1,2,3 at the external service" do
        PolarisResource::Request.should_receive(:get).with("/dogs", { :ids => [1,2,3] }).and_return(@response)
        Dog.find(1,2,3)
      end
      
      it "returns an array of instances representing these found records" do
        @dogs = Dog.find(1,2,3)
        @dogs.should be_an(Array)
        @dogs.should have(3).dogs
        @dogs.each do |dog|
          dog.should be_a(Dog)
        end
      end
      
    end
    
    context "when there is a requested record that does not exist on the external service" do
      
      before(:each) do
        body = {
          :status  => 404,
          :content => nil
        }
        @response = PolarisResource::Response.new(:code => 404, :headers => "", :body => body.to_json, :time => 0.3)
        PolarisResource::Request.stub(:get).and_return(@response)
      end
      
      it "raises a ResourceNotFound error" do
        lambda { Dog.find(1,2,3) }.should raise_error(PolarisResource::ResourceNotFound, "Couldn't find all Dogs with IDs (1, 2, 3)")
      end
      
    end
    
  end
  
end

describe PolarisResource::Finders, "#all" do

  before(:each) do
    dogs =  [Dog.new(:name => "Daisy", :breed => "English Bulldog").attributes.merge(:id => 1)]
    dogs << Dog.new(:name => "Wilbur", :breed => "Hounddog").attributes.merge(:id => 2)
    dogs << Dog.new(:name => "Fido", :breed => "Dalmatian").attributes.merge(:id => 3)
    body = {
      :status  => 200,
      :content => dogs
    }
    @response = PolarisResource::Response.new(:code => 200, :headers => "", :body => body.to_json, :time => 0.3)
    PolarisResource::Request.stub(:get).and_return(@response)
  end
  
  it "returns all found records" do
    @dogs = Dog.all
    @dogs.should be_an(Array)
    @dogs.should have(3).dogs
    @dogs.each do |dog|
      dog.should be_a(Dog)
    end
  end

end

describe PolarisResource::Finders, "#first" do
  
  before(:each) do
    body = {
      :status  => 200,
      :content => [Dog.new(:name => "Daisy", :breed => "English Bulldog").attributes.merge(:id => 1)]
    }
    @response = PolarisResource::Response.new(:code => 200, :headers => "", :body => body.to_json, :time => 0.3)
    PolarisResource::Request.stub(:get).and_return(@response)
  end
  
  it "returns first found record" do
    @dog = Dog.first
    @dog.should be_a(Dog)
  end
  
end

describe PolarisResource::Finders, "#where" do
  
  context "when the where attribute is an acceptable attribute" do
    
    context "for a where clause with one attribute" do
      
      before(:each) do
        dogs =  [Dog.new(:name => "Daisy", :breed => "English Bulldog").attributes.merge(:id => 1)]
        body = {
          :status  => 200,
          :content => dogs
        }
        @response = PolarisResource::Response.new(:code => 200, :headers => "", :body => body.to_json, :time => 0.3)
      end
      
      it "makes a request to find all records with the given query parameter" do
        PolarisResource::Request.should_receive(:get).with("/dogs", { :name => "Daisy" }).and_return(@response)
        Dog.where(:name => "Daisy").first
      end
      
    end
    
    context "for a where clause with multiple attributes" do
      
      before(:each) do
        dogs =  [Dog.new(:name => "Daisy", :breed => "English Bulldog").attributes.merge(:id => 1)]
        body = {
          :status  => 200,
          :content => dogs
        }
        @response = PolarisResource::Response.new(:code => 200, :headers => "", :body => body.to_json, :time => 0.3)
      end
      
      it "makes a request to find all records with the given query parameters" do
        PolarisResource::Request.should_receive(:get).with("/dogs", { :breed => "English Bulldog", :name => "Daisy" }).and_return(@response)
        Dog.where(:name => "Daisy", :breed => "English Bulldog").first
      end
      
    end
    
  end
  
end

describe PolarisResource::Finders, "#limit" do
  
  before(:each) do
    dogs =  [Dog.new(:name => "Daisy", :breed => "English Bulldog").attributes.merge(:id => 1)]
    dogs << Dog.new(:name => "Wilbur", :breed => "Hounddog").attributes.merge(:id => 2)
    dogs << Dog.new(:name => "Fido", :breed => "Dalmatian").attributes.merge(:id => 3)
    body = {
      :status  => 200,
      :content => dogs
    }
    @response = PolarisResource::Response.new(:code => 200, :headers => "", :body => body.to_json, :time => 0.3)
  end

  it "makes a request to find all of the given records, but with a given limit" do
    PolarisResource::Request.should_receive(:get).with("/dogs", { :limit => 10 }).and_return(@response)
    Dog.limit(10).all
  end

end

describe PolarisResource::Finders, "#page" do
  
  before(:each) do
    Dog.results_per_page = 10
    
    dogs =  [Dog.new(:name => "Daisy", :breed => "English Bulldog").attributes.merge(:id => 1)]
    dogs << Dog.new(:name => "Wilbur", :breed => "Hounddog").attributes.merge(:id => 2)
    dogs << Dog.new(:name => "Fido", :breed => "Dalmatian").attributes.merge(:id => 3)
    body = {
      :status  => 200,
      :content => dogs
    }
    @response = PolarisResource::Response.new(:code => 200, :headers => "", :body => body.to_json, :time => 0.3)
  end

  it "makes a request to find all of the given records, but with a given limit and offset" do
    PolarisResource::Request.should_receive(:get).with("/dogs", { :limit => 10, :offset => 20 }).and_return(@response)
    Dog.page(3).all
  end
  
end

describe PolarisResource::Finders, "#results_per_page" do
  
  it "defaults to 10" do
    Dog.results_per_page.should eql(10)
  end
  
  context "when set to something other than the default" do
    
    before(:each) do
      Dog.results_per_page = 25
    end
    
    it "returns the number of results to be returned on a page request" do
      Dog.results_per_page.should eql(25)
    end
    
  end
  
end