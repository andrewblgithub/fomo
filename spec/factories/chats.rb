FactoryGirl.define do
  factory :chat do
    content { Faker::Lorem.sentence }
    created_by { Faker::LordOfTheRings.character  }
    group_id nil
  end
end
