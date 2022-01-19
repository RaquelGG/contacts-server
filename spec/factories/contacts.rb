FactoryBot.define do
    factory :contact do
      name { Faker::Name.first_name }
      surname { Faker::Name.last_name }
      email { Faker::Internet.email }
      tel { Faker::PhoneNumber.cell_phone_in_e164 }
    end
end