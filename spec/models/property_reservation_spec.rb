require 'rails_helper'

RSpec.describe PropertyReservation, type: :model do
  describe 'code must be uniq' do
    it {
      reservation = create(:property_reservation)
      allow(SecureRandom).to receive(:alphanumeric).and_return(reservation.code, 'ABCD1234')
      other_reservation = create(:property_reservation)

      expect(other_reservation).to be_valid
      expect(other_reservation.code).to eq('ABCD1234')
    }

    it {
      reservation = create(:property_reservation)
      other_reservation = build(:property_reservation, code: reservation.code)
      other_reservation.save

      expect(other_reservation).to be_invalid
    }
  end

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
