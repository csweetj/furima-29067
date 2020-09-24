FactoryBot.define do
  factory :item do
    name                {Faker::Name.initials}
    describe {Faker::Lorem.sentence}
    price   {Faker::Number.number(digits: 4)}
    category_id {2}
    condition_id {2}
    delivery_day_id {2}
    delivery_fee_id {2}
    prefecture_id {2}
    association :user 
  end
end
