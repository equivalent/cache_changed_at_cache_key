require 'spec_helper'

# Event represent record that doesn't have column cache_changed_at in database

describe Event, 'touch_cache' do
  let!(:event){ FactoryGirl.create :event, :created_in_past }

  before{ event.touch_cache }
  it 'should update  updated_at' do
    expect(event.updated_at).to be_within(delta).of(Time.now)
  end
end

describe Event, 'touch' do
  let!(:event){ FactoryGirl.create :event, :created_in_past }

  it 'should update both cache_changed_at and updated_at' do
    event.touch
    event.reload

    expect(event.updated_at).to be_within(delta).of(Time.now)
  end
end

describe 'cache_key' do
  let!(:event){ FactoryGirl.create :event, :created_in_past }
  subject{ event.cache_key }

  it "should be generaterd from cache_changed_at" do
    should eq "events/#{event.id}-#{event.updated_at.utc.to_s(:number)}"
  end

end
