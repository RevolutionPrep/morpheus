require 'spec_helper'

describe Morpheus::Attributes do

  describe '.property' do
    it 'defines setter and getter methods for the given property' do
      @book = Book.new
      @book.should respond_to(:title)
      @book.title = 'Test Title'
      @book.title.should eql('Test Title')
    end

    it 'creates an attribute entry for this property' do
      Book.new.attributes.should include(:title)
    end
  end

  describe '.default_attributes' do
    it 'returns the default attributes has which will be applied as the attributes when a new object is instantiated' do
      Book.default_attributes.should eql(HashWithIndifferentAccess.new({ :id => nil, :title => nil, :author_id => nil }))
    end
  end

  describe '.typecast_attributes' do
    pending
  end

  describe '.attribute_defined?' do
    pending
  end

  describe '#attributes' do
    it 'returns the attributes hash' do
      Book.new.attributes.should eql(HashWithIndifferentAccess.new({ :id => nil, :title => nil, :author_id => nil }))
    end
  end

  describe '#read_attribute_for_validation' do
    pending
  end

  describe '#typecast' do
    pending
  end

  describe '#attributes_without_basic_attributes' do
    pending
  end

  describe "#update_attribute" do
    it 'updates the attribute with the given value' do
      @book = Book.new(:title => 'Horton Hears a Who')
      @book.title.should eql('Horton Hears a Who')
      @book.update_attribute(:title, 'One Fish, Two Fish, Red Fish, Blue Fish')
      @book.title.should eql('One Fish, Two Fish, Red Fish, Blue Fish')
    end
  end

  describe '#update_reflection' do
    pending
  end

  describe '#merge_attributes' do
    it 'updates each attribute with the given value' do
      @book = Book.new(:title => 'Green Eggs and Ham')
      @book.id.should be_nil
      @book.title.should eql('Green Eggs and Ham')
      @book.send(:merge_attributes, { :title => 'One Fish, Two Fish, Red Fish, Blue Fish', :id => 5 })
      @book.id.should eql(5)
      @book.title.should eql('One Fish, Two Fish, Red Fish, Blue Fish')
    end
  end

  describe 'dirty tracking' do
    it 'includes the ActiveModel::Dirty module' do
      Morpheus::Base.included_modules.should include(ActiveModel::Dirty)
    end

    it 'tracks dirty state for property values' do
      @book = Book.new
      @book.should_not be_title_changed
      @book.title = 'Dirty title'
      @book.should be_title_changed
    end
  end

  describe 'validations' do
    it 'includes the ActiveModel::Validations module' do
      Morpheus::Base.included_modules.should include(ActiveModel::Validations)
    end
  end

end
