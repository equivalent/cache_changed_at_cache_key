require 'spec_helper'

# Blog represent record that has column cache_changed_at in database

describe Blog, 'factories sanity' do
  context 'when using with_different_times trait' do
    let!(:blog){ FactoryGirl.create :blog, :with_different_times }
    it do
      expect(blog.cache_changed_at).not_to be_within(delta).of(blog.updated_at)
    end
  end

  context "when using with_same_times trait" do
    let!(:blog){ FactoryGirl.create :blog, :with_same_times }
    it do
      expect(blog.cache_changed_at).to be_within(delta).of(blog.updated_at)
    end
  end
end

describe Blog, 'new record save' do
  let!(:blog){ Blog.create title: 'new record' }

  it 'should generate cache_changed_at time same as updated_at' do
    expect(blog.cache_changed_at).to be_within(delta).of(blog.updated_at)
  end
end

describe Blog, 'updating existing record' do
  let!(:blog){ FactoryGirl.create :blog, :with_different_times }

  before do
    blog.save!
    blog.reload
  end

  it 'should update cache_changed_at' do
    expect(blog.cache_changed_at).to be_within(delta).of(blog.updated_at)
    blog.cache_changed_at.should be_kind_of Time
  end
end

describe Blog, 'touch_cache' do
  let!(:blog){ FactoryGirl.create :blog, :with_same_times }

  before{ blog.touch_cache }
  it 'should update cache_changed_at but not updated_at' do
    expect(blog.cache_changed_at).to be_within(delta).of(Time.now)
    expect(blog.cache_changed_at).not_to be_within(delta).of(blog.updated_at)
  end
end


describe Blog, 'touch' do
  let!(:blog){ FactoryGirl.create :blog, :with_same_times }

  it 'should update both cache_changed_at and updated_at' do
    blog.touch
    blog.reload

    expect(blog.updated_at).to  be_within(delta).of(Time.now)
    expect(blog.cache_changed_at).to  be_within(delta).of(Time.now)

    expect(blog.cache_changed_at).to be_within(delta).of(blog.updated_at)
  end
end


describe 'cache_key' do
  subject{ blog.cache_key }

  context "when persisted record" do
    let!(:blog){ FactoryGirl.create :blog, :with_different_times }
    it "should be generaterd from cache_changed_at" do
      should eq "blogs/#{blog.id}-#{blog.cache_changed_at.utc.to_s(:number)}"
    end
  end

  context "when new record" do
    let!(:blog){ FactoryGirl.build :blog }
    it "should use the native ActiveRecord functionality" do
      should eq "blogs/new"
    end
  end


end
