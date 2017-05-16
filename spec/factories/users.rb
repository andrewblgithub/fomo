FactoryGirl.define do
  factory :user do
    name { Faker::LordOfTheRings.character }
    email 'foo@bar.com'
    password 'foobar'
  end
end
