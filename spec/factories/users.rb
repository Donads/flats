FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "usuario#{n}@teste.com.br" }
    password { '123456' }
  end
end
