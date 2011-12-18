require 'spec_helper'

describe Morpheus::Associations::Association do

  describe '#initialize' do
    pending
  end

  describe '#id' do
    before(:each) do
      meeting =  Meeting.new(:id => 5, :title => 'Rails Development')
      Meeting.stub(:get).and_return(meeting)
    end

    it 'calls the loaded target and retrieves the id' do
      @speaker = Speaker.new(:meeting_id => 5)
      @speaker.meeting.id.should eql(5)
    end
  end

  describe '#nil?' do
    pending
  end

  describe '#to_param' do
    pending
  end

  describe '#try' do
    pending
  end

  describe '#includes' do
    pending
  end

  describe '#loaded_target' do
    before(:each) do
      @meeting =  Meeting.new(:id => 5, :title => 'Rails Development')
    end

    it 'loads target only once' do
      Meeting.should_receive(:get).once.and_return(@meeting)
      @speaker = Speaker.new(:meeting_id => 5)
      @speaker.meeting.id
      @speaker.meeting.id
    end
  end

  describe '#method_missing' do
    before(:each) do
      meeting =  Meeting.new(:id => 5, :title => 'Rails Development')
      Meeting.stub(:get).and_return(meeting)
    end

    it 'calls the loaded target and tries the method on the target' do
      @speaker = Speaker.new(:meeting_id => 5)
      @speaker.meeting.title
    end
  end

end
