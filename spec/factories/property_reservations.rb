FactoryBot.define do
  factory :property_reservation do
    start_date { 1.day.from_now }
    end_date { 3.days.from_now }
    guests { rand(1..10) }

    property
    user
  end
end
