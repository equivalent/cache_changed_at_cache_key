FactoryGirl.define do
  factory :blog do
    title 'foo'

    trait :with_different_times do
      after :create do |b|
        sameday = 3.days.ago
        b.update_column :cache_changed_at, 2.days.ago
        b.update_column :updated_at,       sameday
        b.update_column :created_at,       sameday
      end
    end

    trait :with_same_times do
      after :create do |b|
        sameday = 2.days.ago
        b.update_column :cache_changed_at, sameday
        b.update_column :updated_at,       sameday
        b.update_column :created_at,       sameday
      end
    end
  end
end
