require 'rails_helper'

describe 'Visitor filter properties by type' do
  it 'should view links on nav bar' do
    PropertyType.create!(name: 'Apartamento')
    PropertyType.create!(name: 'Casa')
    PropertyType.create!(name: 'Sitio')

    visit root_path

    expect(page).to have_link('Apartamento')
    expect(page).to have_link('Casa')
    expect(page).to have_link('Sitio')
  end

  it 'on the type page successfully' do
    apartamento = PropertyType.create!(name: 'Apartamento')
    casa = PropertyType.create!(name: 'Casa')
    property_location = PropertyLocation.create!(name: 'Sudeste')

    property_1 = Property.create!({ title: 'Cobertura em Manaus',
                                    description: 'Cobertura de 300m2, churrasqueira e sauna privativa',
                                    rooms: 5, parking_slot: false, bathrooms: 4, pets: true, daily_rate: 1500,
                                    property_type: apartamento, property_location: property_location })
    property_2 = Property.create!({ title: 'Casa com quintal em Copacabana',
                                    description: 'Excelente casa, recém reformada com 2 vagas de garagem',
                                    rooms: 3, parking_slot: true, bathrooms: 2, pets: true, daily_rate: 500,
                                    property_type: casa, property_location: property_location })

    visit root_path
    click_link 'Tipos de Imóveis'
    click_link 'Casa'

    expect(current_path).to eq property_type_path(property_2)
    expect(page).to have_css('h1', text: 'Imóveis do tipo Casa')
    expect(page).not_to have_content('Cobertura em Manaus')
    expect(page).to have_link('Casa com quintal em Copacabana')
  end

  it 'on the homepage successfully' do
    apartamento = PropertyType.create!(name: 'Apartamento')
    casa = PropertyType.create!(name: 'Casa')
    property_location = PropertyLocation.create!(name: 'Sudeste')

    Property.create!({ title: 'Cobertura em Manaus',
                       description: 'Cobertura de 300m2, churrasqueira e sauna privativa',
                       rooms: 5, parking_slot: false, bathrooms: 4, pets: true, daily_rate: 1500,
                       property_type: apartamento, property_location: property_location })
    Property.create!({ title: 'Casa com quintal em Copacabana',
                       description: 'Excelente casa, recém reformada com 2 vagas de garagem',
                       rooms: 3, parking_slot: true, bathrooms: 2, pets: true, daily_rate: 500,
                       property_type: casa, property_location: property_location })

    visit root_path
    click_link 'Casa'

    expect(current_path).to eq root_path
    expect(page).not_to have_content('Cobertura em Manaus')
    expect(page).to have_link('Casa com quintal em Copacabana')
  end
end
