require 'spec_helper'

describe Morpheus::Introspection do

  describe '#persisted?' do
    before(:each) do
      @attendee = Attendee.new
    end

    context 'when the record is not persisted' do
      it 'returns false' do
        @attendee.should_not be_persisted
      end
    end

    context 'when the record is persisted' do
      before(:each) do
        stub_web!
        @attendee.save
      end

      it 'returns true' do
        @attendee.should be_persisted
      end
    end

    def stub_web!
      Morpheus::Configuration.hydra.stub(:post, "#{Morpheus::Configuration.host}/attendees").and_return(build_morpheus_response(
        201,
        {
          :id      => 1,
          :valid   => true,
          :errors  => {}
        }
      ))
    end

  end

  describe '#new_record?' do
    before(:each) do
      @attendee = Attendee.new
    end

    context 'when the record is new' do
      it 'returns true' do
        @attendee.should be_new_record
      end
    end

    context 'when the record is not new' do
      before(:each) do
        stub_web!
        @attendee.save
      end

      it 'returns false' do
        @attendee.should_not be_new_record
      end
    end

    def stub_web!
      Morpheus::Configuration.hydra.stub(:post, "#{Morpheus::Configuration.host}/attendees").and_return(build_morpheus_response(
        201,
        {
          :id      => 1,
          :valid   => true,
          :errors  => {}
        }
      ))
    end

  end

  describe '#destroyed?' do
    it 'returns false' do
      Dog.new.should_not be_destroyed
    end
  end

  describe '#respond_to?' do
    before(:each) do
      @dog = Dog.new(:name => 'Fido', :age => 10)
    end

    context 'if the query method is a method on the object' do
      it 'returns true' do
        @dog.should respond_to(:bark!)
      end
    end

    context 'if the query method is not a method on the object' do
      it 'returns false' do
        @dog.should_not respond_to(:bite!)
      end
    end

    context 'if the query method is an attribute on the object' do
      it 'returns true' do
        @dog.should respond_to(:age)
      end
    end

    context 'if the query method is not an attribute on the object' do
      it 'returns false' do
        @dog.should_not respond_to(:weight)
      end
    end
  end

end
