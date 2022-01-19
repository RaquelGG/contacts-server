FactoryBot.define do
    factory :change do
      name { Faker::Name.first_name }
      tel { Faker::PhoneNumber.cell_phone_in_e164 }
    end
end