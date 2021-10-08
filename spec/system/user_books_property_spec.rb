require 'rails_helper'

describe 'User books property' do
  it 'successfully' do
    user = User.create!(email: 'yan@donadi.com.br', password: '123456789')
    property_owner = PropertyOwner.create!(email: 'jane@doe.com.br', password: '123456789')
    property_type = PropertyType.create!(name: 'Casa')
    property_location = PropertyLocation.create!(name: 'Sudeste')
    property = Property.create!({ title: 'Casa com quintal em Copacabana',
                                  description: 'Excelente casa, recém reformada com 2 vagas de garagem',
                                  rooms: 3, parking_slot: true, bathrooms: 2, pets: true, daily_rate: 100,
                                  property_type: property_type, property_location: property_location, property_owner: property_owner })
    current_date = Date.today
    future_date = 3.days.from_now

    login_as user, scope: :user
    visit root_path
    click_link property.title
    fill_in 'Data de Início', with: current_date
    fill_in 'Data Final', with: future_date
    fill_in 'Quantidade de Pessoas', with: 3
    click_on 'Enviar Reserva'

    expect(page).to have_content('Pedido de reserva enviado com sucesso!')
    expect(page).to have_content("Data de Início: #{I18n.l(current_date)}")
    expect(page).to have_content("Data de Término: #{I18n.l(future_date.to_date)}")
    expect(page).to have_content(/3/)
    expect(page).to have_content('Valor Total: R$ 300,00')
  end
end
