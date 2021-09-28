require 'rails_helper'

describe 'Visitor filter properties by location' do
  it 'should view links on nav bar' do
    # Arrange
    PropertyLocation.create!(name: 'Centro-Oeste')
    PropertyLocation.create!(name: 'Nordeste')
    PropertyLocation.create!(name: 'Norte')
    PropertyLocation.create!(name: 'Sudeste')
    PropertyLocation.create!(name: 'Sul')

    # Act
    visit root_path

    # Assert
    expect(page).to have_link('Centro-Oeste')
    expect(page).to have_link('Nordeste')
    expect(page).to have_link('Norte')
    expect(page).to have_link('Sudeste')
    expect(page).to have_link('Sul')
  end

  it 'on the location page successfully' do
    # Arrange
    property_type = PropertyType.create!(name: 'Apartamento')
    norte = PropertyLocation.create!(name: 'Norte')
    sudeste = PropertyLocation.create!(name: 'Sudeste')

    property_1 = Property.create!({ title: 'Cobertura em Manaus',
                                    description: 'Cobertura de 300m2, churrasqueira e sauna privativa',
                                    rooms: 5, parking_slot: false, bathrooms: 4, pets: true, daily_rate: 1500,
                                    property_type: property_type, property_location: norte })
    property_2 = Property.create!({ title: 'Cobertura em Copacabana',
                                    description: 'Excelente casa, recém reformada com 2 vagas de garagem',
                                    rooms: 3, parking_slot: true, bathrooms: 2, pets: true, daily_rate: 500,
                                    property_type: property_type, property_location: sudeste })

    # Act
    visit root_path
    click_link 'Regiões de Imóveis'
    click_on 'Sudeste'

    # Assert
    expect(current_path).to eq property_location_path(property_2)
    expect(page).to have_css('h1', text: 'Imóveis da região Sudeste')
    expect(page).not_to have_content('Cobertura em Manaus')
    expect(page).to have_link('Cobertura em Copacabana')
  end

  it 'on the homepage successfully' do
    # Arrange
    property_type = PropertyType.create!(name: 'Apartamento')
    norte = PropertyLocation.create!(name: 'Norte')
    sudeste = PropertyLocation.create!(name: 'Sudeste')

    property_1 = Property.create!({ title: 'Cobertura em Manaus',
                                    description: 'Cobertura de 300m2, churrasqueira e sauna privativa',
                                    rooms: 5, parking_slot: false, bathrooms: 4, pets: true, daily_rate: 1500,
                                    property_type: property_type, property_location: norte })
    property_2 = Property.create!({ title: 'Cobertura em Copacabana',
                                    description: 'Excelente casa, recém reformada com 2 vagas de garagem',
                                    rooms: 3, parking_slot: true, bathrooms: 2, pets: true, daily_rate: 500,
                                    property_type: property_type, property_location: sudeste })

    # Act
    visit root_path
    click_link 'Sudeste'

    # Assert
    expect(current_path).to eq root_path
    expect(page).not_to have_content('Cobertura em Manaus')
    expect(page).to have_link('Cobertura em Copacabana')
  end
end
