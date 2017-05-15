FactoryGirl.define do
  factory :group do
    name { Faker::Lorem.word }
    created_by { Faker::LordOfTheRings.character }
  end
end
