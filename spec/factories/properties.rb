FactoryBot.define do
  factory :property do
    sequence(:title) { |n| "Titulo #{n}" }
    description { 'Descrição de testes' }
    rooms { rand(1..5) }
    bathrooms { rand(1..5) }
    parking_slot { true }
    pets { true }
    daily_rate { rand(50..500) }

    property_type
    property_location
    property_owner
  end
end
