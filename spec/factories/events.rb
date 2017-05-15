FactoryGirl.define do
  factory :event do
    title { Faker::LordOfTheRings.location }
    description { Faker::Lorem.sentence }
    created_by { Faker::LordOfTheRings.character  }
    expires_at { Faker::Date.forward(365) }
    group_id nil
  end
end
