require 'rails_helper'

RSpec.describe PropertyReservationMailer, type: :mailer do
  context 'new reservation' do
    it 'notifies property owner' do
      property_type = create(:property_type, name: 'Casa')
      property_location = create(:property_location, name: 'Sudeste')
      john = PropertyOwner.create!(email: 'john@doe.com.br', password: '123456789')
      property = Property.create!({ title: 'Casa com quintal em Copacabana',
                                    description: 'Excelente casa, recém reformada com 2 vagas de garagem',
                                    rooms: 3, parking_slot: true, bathrooms: 2, pets: true, daily_rate: 100,
                                    property_type: property_type, property_location: property_location, property_owner: john })
      reservation = create(:property_reservation, property: property)

      mail = PropertyReservationMailer.with(reservation: reservation).notify_new_reservation

      expect(mail.to).to eq [john.email]
      expect(mail.from).to eq ['contato@yandonadi.dev']
      expect(mail.subject).to eq "Nova reserva para seu imóvel #{property.title}"
      expect(mail.body).to include "Olá #{john.email}, #{reservation.user.email} realizou uma reserva para o seu imóvel."
    end
  end
end
