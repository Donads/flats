require 'rails_helper'

describe Property do
  context 'validations' do
    it 'name must be present' do
      property = Property.new
      property.valid?
      expect(property.errors.full_messages_for(:title)).to include('Título não pode ficar em branco')
    end

    it 'description must be present' do
      property = Property.new
      property.valid?
      expect(property.errors.full_messages_for(:description)).to include('Descrição não pode ficar em branco')
    end

    it 'rooms must be present' do
      property = Property.new
      property.valid?
      expect(property.errors.full_messages_for(:rooms)).to include('Quartos não pode ficar em branco')
    end

    it 'bathrooms must be present' do
      property = Property.new
      property.valid?
      expect(property.errors.full_messages_for(:bathrooms)).to include('Banheiros não pode ficar em branco')
    end

    it 'daily_rate must be present' do
      property = Property.new
      property.valid?
      expect(property.errors.full_messages_for(:daily_rate)).to include('Diária não pode ficar em branco')
    end
  end

  context 'numericality' do
    it 'rooms must be a number' do
      property = Property.new(rooms: 'a')
      property.valid?
      expect(property.errors.full_messages_for(:rooms)).to include('Quartos não é um número')
    end

    it 'rooms must be an integer' do
      property = Property.new(rooms: 1.5)
      property.valid?
      expect(property.errors.full_messages_for(:rooms)).to include('Quartos não é um número inteiro')
    end

    it 'rooms must be greater than 0' do
      property = Property.new(rooms: -1)
      property.valid?
      expect(property.errors.full_messages_for(:rooms)).to include('Quartos deve ser maior que 0')
    end

    it 'rooms must be greater than 0' do
      property = Property.new(rooms: 0)
      property.valid?
      expect(property.errors.full_messages_for(:rooms)).to include('Quartos deve ser maior que 0')
    end

    it 'rooms must be greater than 0' do
      property = Property.new(rooms: 1)
      property.valid?
      expect(property.errors.full_messages_for(:rooms)).to eq []
    end

    it 'bathrooms must be a number' do
      property = Property.new(bathrooms: 'a')
      property.valid?
      expect(property.errors.full_messages_for(:bathrooms)).to include('Banheiros não é um número')
    end

    it 'bathrooms must be an integer' do
      property = Property.new(bathrooms: 1.5)
      property.valid?
      expect(property.errors.full_messages_for(:bathrooms)).to include('Banheiros não é um número inteiro')
    end

    it 'bathrooms must be greater than 0' do
      property = Property.new(bathrooms: -1)
      property.valid?
      expect(property.errors.full_messages_for(:bathrooms)).to include('Banheiros deve ser maior que 0')
    end

    it 'bathrooms must be greater than 0' do
      property = Property.new(bathrooms: 0)
      property.valid?
      expect(property.errors.full_messages_for(:bathrooms)).to include('Banheiros deve ser maior que 0')
    end

    it 'bathrooms must be greater than 0' do
      property = Property.new(bathrooms: 1)
      property.valid?
      expect(property.errors.full_messages_for(:bathrooms)).to eq []
    end

    it 'daily_rate must be a number' do
      property = Property.new(daily_rate: 'a')
      property.valid?
      expect(property.errors.full_messages_for(:daily_rate)).to include('Diária não é um número')
    end

    it 'daily_rate must be greater than 0' do
      property = Property.new(daily_rate: -1)
      property.valid?
      expect(property.errors.full_messages_for(:daily_rate)).to include('Diária deve ser maior que 0')
    end

    it 'daily_rate must be greater than 0' do
      property = Property.new(daily_rate: 0)
      property.valid?
      expect(property.errors.full_messages_for(:daily_rate)).to include('Diária deve ser maior que 0')
    end

    it 'daily_rate must be greater than 0' do
      property = Property.new(daily_rate: 1.5)
      property.valid?
      expect(property.errors.full_messages_for(:daily_rate)).to eq []
    end
  end

  context 'boolean fields not nil' do
    it 'parking_slot not nil' do
      property = Property.new(parking_slot: nil)
      property.valid?
      expect(property.errors.full_messages_for(:parking_slot)).to include('Vaga de Estacionamento não está incluído na lista')
    end

    it 'parking_slot not nil' do
      property = Property.new(parking_slot: true)
      property.valid?
      expect(property.errors.full_messages_for(:parking_slot)).to eq []
    end

    it 'parking_slot not nil' do
      property = Property.new(parking_slot: false)
      property.valid?
      expect(property.errors.full_messages_for(:parking_slot)).to eq []
    end

    it 'pets not nil' do
      property = Property.new(pets: nil)
      property.valid?
      expect(property.errors.full_messages_for(:pets)).to include('Animais de Estimação não está incluído na lista')
    end

    it 'pets not nil' do
      property = Property.new(pets: true)
      property.valid?
      expect(property.errors.full_messages_for(:pets)).to eq []
    end

    it 'pets not nil' do
      property = Property.new(pets: false)
      property.valid?
      expect(property.errors.full_messages_for(:pets)).to eq []
    end
  end
end
