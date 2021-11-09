FactoryBot.define do
  factory :property_owner do
    sequence(:email) { |n| "proprietario#{n}@teste.com.br" }
    password { '123456' }
  end
end
