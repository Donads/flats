class Property < ApplicationRecord
  belongs_to :property_type
  belongs_to :property_location

  validates :title, :description, :rooms, :bathrooms, :daily_rate, presence: true
  validates :daily_rate, numericality: true
  validates :rooms, :bathrooms, numericality: { only_integer: true }
end
