class User < ApplicationRecord
  has_many :property_reservations, dependent: :restrict_with_error
  has_many :properties, through: :property_reservations

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
