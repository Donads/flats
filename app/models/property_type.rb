class PropertyType < ApplicationRecord
  validates :name, presence: { message: 'É obrigatório o preenchimento do nome' }
  validates :name, uniqueness: { message: 'Já existe tipo cadastrado com esse nome' }
end
