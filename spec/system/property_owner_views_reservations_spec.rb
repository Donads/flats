require 'rails_helper'

describe 'PropertyOwner views reservations' do
  it 'Views all reservations from owned properties' do
    property_type = PropertyType.create!(name: 'Casa')
    property_location = PropertyLocation.create!(name: 'Sudeste')
    user = User.create!(email: 'yan@donadi.com.br', password: '123456789')

    john = PropertyOwner.create!(email: 'john@doe.com.br', password: '123456789')
    johns_property_1 = Property.create!({ title: 'Casa com quintal em Copacabana',
                                          description: 'Excelente casa, recém reformada com 2 vagas de garagem',
                                          rooms: 3, parking_slot: true, bathrooms: 2, pets: true, daily_rate: 100,
                                          property_type: property_type, property_location: property_location, property_owner: john })
    johns_property_2 = Property.create!({ title: 'Sobrado Novo',
                                          description: 'Sobrado divertido',
                                          rooms: 3, parking_slot: true, bathrooms: 2, pets: true, daily_rate: 100,
                                          property_type: property_type, property_location: property_location, property_owner: john })

    jane = PropertyOwner.create!(email: 'jane@doe.com.br', password: '123456789')
    janes_property_1 = Property.create!({ title: 'Casa de Praia',
                                          description: 'Casa de frente pra praia',
                                          rooms: 3, parking_slot: true, bathrooms: 2, pets: true, daily_rate: 100,
                                          property_type: property_type, property_location: property_location, property_owner: jane })

    current_date_john = Date.today
    future_date_john = 3.days.from_now.to_date
    PropertyReservation.create!(start_date: current_date_john, end_date: future_date_john, guests: 2,
                                property: johns_property_1, user: user)
    current_date_jane = 2.days.from_now.to_date
    future_date_jane = 7.days.from_now.to_date
    PropertyReservation.create!(start_date: current_date_jane, end_date: future_date_jane, guests: 2,
                                property: janes_property_1, user: user)

    login_as john, scope: :property_owner
    visit root_path
    click_link 'Meus Imóveis'
    click_link 'Casa com quintal em Copacabana'

    expect(page).to have_content('Propostas')
    expect(page).to have_content('Reserva de yan@donadi.com.br')
    expect(page).to have_content("Data de Início: #{I18n.l(current_date_john)}")
    expect(page).to have_content("Data de Término: #{I18n.l(future_date_john)}")
    expect(page).to have_content('Situação: Pendente')
    expect(page).not_to have_content('Reserve Agora')
  end

  it "Doesn't view reservations from other owners" do
    property_type = PropertyType.create!(name: 'Casa')
    property_location = PropertyLocation.create!(name: 'Sudeste')
    user = User.create!(email: 'yan@donadi.com.br', password: '123456789')

    john = PropertyOwner.create!(email: 'john@doe.com.br', password: '123456789')

    jane = PropertyOwner.create!(email: 'jane@doe.com.br', password: '123456789')
    janes_property_1 = Property.create!({ title: 'Casa de Praia',
                                          description: 'Casa de frente pra praia',
                                          rooms: 3, parking_slot: true, bathrooms: 2, pets: true, daily_rate: 100,
                                          property_type: property_type, property_location: property_location, property_owner: jane })

    current_date_jane = 2.days.from_now.to_date
    future_date_jane = 7.days.from_now.to_date
    PropertyReservation.create!(start_date: current_date_jane, end_date: future_date_jane, guests: 2,
                                property: janes_property_1, user: user)

    login_as john, scope: :property_owner
    visit root_path
    click_link 'Casa de Praia'

    expect(current_path).to eq property_path(janes_property_1)
    expect(page).not_to have_content('Data de Início:')
    expect(page).not_to have_content('Data de Término:')
    expect(page).not_to have_content('Propostas')
    expect(page).not_to have_content('Reserva de')
    expect(page).not_to have_content('Reserve Agora')
  end

  it 'Views accepted reservation' do
    property_type = PropertyType.create!(name: 'Casa')
    property_location = PropertyLocation.create!(name: 'Sudeste')
    user = User.create!(email: 'yan@donadi.com.br', password: '123456789')

    john = PropertyOwner.create!(email: 'john@doe.com.br', password: '123456789')
    johns_property_1 = Property.create!({ title: 'Casa com quintal em Copacabana',
                                          description: 'Excelente casa, recém reformada com 2 vagas de garagem',
                                          rooms: 3, parking_slot: true, bathrooms: 2, pets: true, daily_rate: 100,
                                          property_type: property_type, property_location: property_location, property_owner: john })
    johns_property_2 = Property.create!({ title: 'Sobrado Novo',
                                          description: 'Sobrado divertido',
                                          rooms: 3, parking_slot: true, bathrooms: 2, pets: true, daily_rate: 100,
                                          property_type: property_type, property_location: property_location, property_owner: john })

    jane = PropertyOwner.create!(email: 'jane@doe.com.br', password: '123456789')
    janes_property_1 = Property.create!({ title: 'Casa de Praia',
                                          description: 'Casa de frente pra praia',
                                          rooms: 3, parking_slot: true, bathrooms: 2, pets: true, daily_rate: 100,
                                          property_type: property_type, property_location: property_location, property_owner: jane })

    current_date_john = Date.today
    future_date_john = 3.days.from_now.to_date
    PropertyReservation.create!(start_date: current_date_john, end_date: future_date_john, guests: 2,
                                property: johns_property_1, user: user)
    current_date_jane = 1.days.from_now.to_date
    future_date_jane = 7.days.from_now.to_date
    PropertyReservation.create!(start_date: current_date_jane, end_date: future_date_jane, guests: 2,
                                property: janes_property_1, user: user)

    login_as john, scope: :property_owner
    visit root_path
    click_link 'Meus Imóveis'
    click_link 'Casa com quintal em Copacabana'
    click_link 'Aceitar Reserva' # TODO: Expandir teste para casos onde existam múltiplos pedidos de reserva no mesmo imóvel

    expect(current_path).to eq property_path(johns_property_1)
    expect(page).to have_content('Propostas')
    expect(page).to have_content('Reserva de yan@donadi.com.br')
    expect(page).to have_content('Data de Início:')
    expect(page).to have_content(I18n.localize(current_date_john))
    expect(page).to have_content('Data de Término:')
    expect(page).to have_content(I18n.localize(future_date_john))
    expect(page).to have_content('Situação: Aceita')
    expect(page).not_to have_content('Reserve Agora')
  end
end
