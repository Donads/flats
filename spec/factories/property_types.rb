FactoryBot.define do
  factory :property_type do
    sequence(:name) { |n| "Tipo #{n}" }
  end
end
