FactoryGirl.define do
  factory :event do
    title "MyString"

    trait :created_in_past do
      after :create do |b|
        sameday = 3.days.ago
        b.update_column :updated_at, sameday
        b.update_column :created_at, sameday
      end
    end
  end
end
