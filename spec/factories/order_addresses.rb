FactoryBot.define do
  factory :order_address do
    token {"tok_abcdefghijk00000000000000000"}
    postal_code {"123-4567"}
    prefecture {3}
    city {Faker::Address.city}
    house_number {Faker::Address.street_address}
    building_name {Faker::Address.secondary_address}
    phone_number {Faker::PhoneNumber.phone_number}
  end
end
