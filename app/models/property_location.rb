class PropertyLocation < ApplicationRecord
  validates :name, presence: { message: 'É obrigatório o preenchimento do nome' }
  validates :name, uniqueness: { message: 'Já existe região cadastrada com esse nome' }
end
