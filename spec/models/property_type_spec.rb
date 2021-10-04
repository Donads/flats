require 'rails_helper'

describe PropertyType do
  context 'validations' do
    it 'name must be present' do
      property_type = PropertyType.new
      property_type.valid?
      expect(property_type.errors.full_messages_for(:name)).to include('Nome não pode ficar em branco')
    end

    it 'name must be unique' do
      PropertyType.create!(name: 'Teste')
      property_type = PropertyType.new(name: 'Teste')
      property_type.valid?
      expect(property_type.errors.full_messages_for(:name)).to include('Nome já está em uso')
    end
  end
end
