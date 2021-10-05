# spec/system/visitor_view_properties_spec.rb

require 'rails_helper'

describe 'Visitor visits homepage' do
  it 'and views properties' do
    property_owner = PropertyOwner.create!(email: 'jane@doe.com.br', password: '123456789')
    property_type = PropertyType.create!(name: 'Casa')
    property_location = PropertyLocation.create!(name: 'Sudeste')

    Property.create!({ title: 'Casa com quintal em Copacabana',
                       description: 'Excelente casa, recém reformada com 2 vagas de garagem',
                       rooms: 3, parking_slot: true, bathrooms: 2, pets: true, daily_rate: 500,
                       property_type: property_type, property_location: property_location, property_owner: property_owner })
    Property.create!({ title: 'Cobertura em Manaus',
                       description: 'Cobertura de 300m2, churrasqueira e sauna privativa',
                       rooms: 5, parking_slot: false, bathrooms: 4, pets: true, daily_rate: 1500,
                       property_type: property_type, property_location: property_location, property_owner: property_owner })

    visit root_path

    # 2 imoveis -> casa com quintal em copacabana; cobertura em manaus
    expect(page).to have_content('Casa com quintal em Copacabana')
    expect(page).to have_content('Excelente casa, recém reformada com 2 vagas de garagem')
    expect(page).to have_content('Cobertura em Manaus')
    expect(page).to have_content('Cobertura de 300m2, churrasqueira e sauna privativa')
  end

  it 'and there is no property available' do
    visit root_path

    expect(page).to have_content('Nenhum imóvel disponível')
  end

  it 'and views property details' do
    property_owner = PropertyOwner.create!(email: 'jane@doe.com.br', password: '123456789')
    property_type = PropertyType.create!(name: 'Casa')
    property_location = PropertyLocation.create!(name: 'Sudeste')

    Property.create!({ title: 'Casa com quintal em Copacabana',
                       description: 'Excelente casa, recém reformada com 2 vagas de garagem',
                       rooms: 3, parking_slot: true, bathrooms: 2, pets: true, daily_rate: 500,
                       property_type: property_type, property_location: property_location, property_owner: property_owner })
    Property.create!({ title: 'Cobertura em Manaus',
                       description: 'Cobertura de 300m2, churrasqueira e sauna privativa',
                       rooms: 5, parking_slot: false, bathrooms: 4, pets: true, daily_rate: 1500,
                       property_type: property_type, property_location: property_location, property_owner: property_owner })

    visit root_path
    click_link 'Casa com quintal em Copacabana'

    expect(page).to_not have_content('Cobertura em Manaus')
    expect(page).to have_content('Casa com quintal em Copacabana')
    expect(page).to have_content('Excelente casa, recém reformada com 2 vagas de garagem')
    expect(page).to have_content('Quartos: 3')
    expect(page).to have_content('Banheiros: 2')
    expect(page).to have_content('Animais de Estimação: Sim')
    expect(page).to have_content('Vaga de Estacionamento: Sim')
    expect(page).to have_content('Diária: R$ 500,00')
    expect(page).to have_content('Casa')
    expect(page).to have_content('Sudeste')
  end

  it 'and views property details then returns to home page' do
    property_owner = PropertyOwner.create!(email: 'jane@doe.com.br', password: '123456789')
    property_type = PropertyType.create!(name: 'Casa')
    property_location = PropertyLocation.create!(name: 'Sudeste')

    Property.create!({ title: 'Casa com quintal em Copacabana',
                       description: 'Excelente casa, recém reformada com 2 vagas de garagem',
                       rooms: 3, parking_slot: true, bathrooms: 2, pets: true, daily_rate: 500,
                       property_type: property_type, property_location: property_location, property_owner: property_owner })
    Property.create!({ title: 'Cobertura em Manaus',
                       description: 'Cobertura de 300m2, churrasqueira e sauna privativa',
                       rooms: 5, parking_slot: false, bathrooms: 4, pets: true, daily_rate: 1500,
                       property_type: property_type, property_location: property_location, property_owner: property_owner })

    visit root_path
    click_link 'Casa com quintal em Copacabana'
    click_link 'Voltar'

    expect(current_path).to eq root_path
    expect(page).to have_content('Casa com quintal em Copacabana')
    expect(page).to have_content('Cobertura em Manaus')
  end
end
