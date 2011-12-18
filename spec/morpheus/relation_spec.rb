require 'spec_helper'

describe Morpheus::Relation do

  describe '#where' do
    it 'makes a request to find all of the given records, with the where parameters' do
      Dog.should_receive(:get).with('/dogs', { :name => 'Daisy', :breed => 'English Bulldog' })
      Dog.where(:name => 'Daisy', :breed => 'English Bulldog').all
    end
  end

  describe '#limit' do
    it 'makes a request to find all of the given records, with the limit parameter' do
      Dog.should_receive(:get).with('/dogs', { :limit => 2 })
      Dog.limit(2).all
    end
  end

  describe '#page' do
    it 'makes a request to find all of the given records, with the chained parameters' do
      Dog.results_per_page = 10
      Dog.should_receive(:get).with('/dogs', { :limit => 10, :offset => 20 })
      Dog.page(3).all
    end
  end

  describe '#all' do
    pending
  end

  describe '#to_a' do
    pending
  end

  describe '#to_json' do
    pending
  end

  describe 'chaining relations' do
    it 'makes a request to find all of the given records, with the chained parameters' do
      Dog.results_per_page = 10
      Dog.should_receive(:get).with('/dogs', { :name => 'Daisy', :breed => 'English Bulldog', :limit => 2, :offset => 20 })
      Dog.where(:name => 'Daisy', :breed => 'English Bulldog').page(3).limit(2).all
    end
  end

end
