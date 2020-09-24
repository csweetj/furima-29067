FactoryBot.define do
  factory :item do
    name                {Faker::Name.initials}
    describe {Faker::Lorem.sentence}
    price   {Faker::Number.number(digits: 4)}
    association :user 
  end
end
