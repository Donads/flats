require 'rails_helper'

describe PropertyLocation do
  context 'validations' do
    it 'name must be present' do
      property_location = PropertyLocation.new
      property_location.valid?
      expect(property_location.errors.full_messages_for(:name)).to include('Nome não pode ficar em branco')
    end

    it 'name must be unique' do
      PropertyLocation.create!(name: 'Teste')
      property_location = PropertyLocation.new(name: 'Teste')
      property_location.valid?
      expect(property_location.errors.full_messages_for(:name)).to include('Nome já está em uso')
    end
  end
end
