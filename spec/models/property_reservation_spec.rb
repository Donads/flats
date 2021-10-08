require 'rails_helper'

RSpec.describe PropertyReservation, type: :model do
  context '#valid?' do
    context 'should not be valid' do
      it 'start date greather than end date' do
        user = User.create!(email: 'yan@donadi.com.br', password: '123456789')
        property_owner = PropertyOwner.create!(email: 'jane@doe.com.br', password: '123456789')
        property_type = PropertyType.create!(name: 'Casa')
        property_location = PropertyLocation.create!(name: 'Sudeste')
        property = Property.create!({ title: 'Casa com quintal em Copacabana',
                                      description: 'Excelente casa, recém reformada com 2 vagas de garagem',
                                      rooms: 3, parking_slot: true, bathrooms: 2, pets: true, daily_rate: 100,
                                      property_type: property_type, property_location: property_location, property_owner: property_owner })

        reservation = PropertyReservation.new(start_date: Date.tomorrow, end_date: Date.today, guests: 2,
                                              property: property, user: user)

        reservation.valid?

        expect(reservation.errors.full_messages_for(:end_date)).to include('Data Final deve ser maior que data inicial')
      end

      it 'end date equal to start date' do
        user = User.create!(email: 'yan@donadi.com.br', password: '123456789')
        property_owner = PropertyOwner.create!(email: 'jane@doe.com.br', password: '123456789')
        property_type = PropertyType.create!(name: 'Casa')
        property_location = PropertyLocation.create!(name: 'Sudeste')
        property = Property.create!({ title: 'Casa com quintal em Copacabana',
                                      description: 'Excelente casa, recém reformada com 2 vagas de garagem',
                                      rooms: 3, parking_slot: true, bathrooms: 2, pets: true, daily_rate: 100,
                                      property_type: property_type, property_location: property_location, property_owner: property_owner })

        current_date = Date.today
        reservation = PropertyReservation.new(start_date: Date.today, end_date: Date.today, guests: 2,
                                              property: property, user: user)

        reservation.valid?

        expect(reservation.errors.full_messages_for(:end_date)).to include('Data Final deve ser maior que data inicial')
      end

      it 'start date in the past' do
        user = User.create!(email: 'yan@donadi.com.br', password: '123456789')
        property_owner = PropertyOwner.create!(email: 'jane@doe.com.br', password: '123456789')
        property_type = PropertyType.create!(name: 'Casa')
        property_location = PropertyLocation.create!(name: 'Sudeste')
        property = Property.create!({ title: 'Casa com quintal em Copacabana',
                                      description: 'Excelente casa, recém reformada com 2 vagas de garagem',
                                      rooms: 3, parking_slot: true, bathrooms: 2, pets: true, daily_rate: 100,
                                      property_type: property_type, property_location: property_location, property_owner: property_owner })

        reservation = PropertyReservation.new(start_date: Date.yesterday, end_date: Date.tomorrow, guests: 2,
                                              property: property, user: user)

        reservation.valid?

        expect(reservation.errors.full_messages_for(:start_date)).to include('Data de Início não pode estar no passado')
      end
    end
  end
end
