require 'rails_helper'

describe 'PropertyOwner views own properties' do
  it 'using menu' do
    property_owner = PropertyOwner.create!(email: 'jane@doe.com.br', password: '123456789')

    login_as property_owner, scope: :property_owner
    visit root_path

    expect(page).to have_link('Meus Imóveis', href: my_properties_properties_path)
  end

  it 'and should view their own properties' do
    property_type = PropertyType.create!(name: 'Casa')
    property_location = PropertyLocation.create!(name: 'Sudeste')
    jane = PropertyOwner.create!(email: 'jane@doe.com.br', password: '123456789')
    peter = PropertyOwner.create!(email: 'peter@parker.com.br', password: '123456789')

    Property.create!({ title: 'Casa com quintal em Copacabana',
                       description: 'Excelente casa, recém reformada com 2 vagas de garagem',
                       rooms: 3, parking_slot: true, bathrooms: 2, pets: true, daily_rate: 500,
                       property_type: property_type, property_location: property_location, property_owner: jane })
    Property.create!({ title: 'Casa com piscina em Mauá',
                       description: 'Ótima casa com internet rápida',
                       rooms: 5, parking_slot: false, bathrooms: 4, pets: true, daily_rate: 1500,
                       property_type: property_type, property_location: property_location, property_owner: peter })

    login_as jane, scope: :property_owner
    visit root_path
    click_on 'Meus Imóveis'

    expect(page).to have_content('Casa com quintal em Copacabana')
    expect(page).not_to have_content('Casa com piscina em Mauá')
  end

  it 'and has no properties yet' do
    property_owner = PropertyOwner.create!(email: 'jane@doe.com.br', password: '123456789')

    login_as property_owner, scope: :property_owner
    visit root_path
    click_link 'Meus Imóveis'

    expect(page).to have_content('Você ainda não cadastrou nenhum imóvel')
  end
end
