class Property < ApplicationRecord
  belongs_to :property_type
  belongs_to :property_location

  validates :title, :description, :rooms, :bathrooms, :daily_rate, presence: true

  validates :rooms, :bathrooms, :daily_rate, numericality: { greater_than: 0 }
  validates :rooms, :bathrooms, numericality: { only_integer: true }

  validates :parking_slot, :pets, inclusion: [true, false]
  validates :parking_slot, :pets, exclusion: [nil]
end
