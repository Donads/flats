FactoryBot.define do
  factory :property_location do
    sequence(:name) { |n| "Local #{n}" }
  end
end
