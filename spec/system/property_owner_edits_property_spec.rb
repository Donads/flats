require 'rails_helper'

describe 'PropertyOwner edits property' do
  it 'successfully' do
    property_type = PropertyType.create!(name: 'Apartamento')
    norte = PropertyLocation.create!(name: 'Norte')
    PropertyLocation.create!(name: 'Sudeste')
    property = Property.create!({ title: 'Cobertura em Manaus',
                                  description: 'Cobertura de 300m2, churrasqueira e sauna privativa',
                                  rooms: 5, parking_slot: false, bathrooms: 4, pets: true, daily_rate: 1500,
                                  property_type: property_type, property_location: norte })
    property_owner = PropertyOwner.create!(email: 'jane@doe.com.br', password: '123456789')

    login_as property_owner, scope: :property_owner
    visit root_path
    click_link property.title
    click_link 'Editar Imóvel'
    fill_in 'Título', with: 'Cobertura espaçosa em Copacabana'
    fill_in 'Descrição', with: 'Cobertura de 300m2, com churrasqueira e sauna privativa'
    fill_in 'Quartos', with: 6
    select 'Sudeste', from: 'Região do Imóvel'
    uncheck 'Animais de Estimação'
    click_button 'Atualizar Imóvel'

    expect(current_path).to eq property_path(property)
    expect(page).to have_content('Cobertura espaçosa em Copacabana')
    expect(page).to have_content('Cobertura de 300m2, com churrasqueira e sauna privativa')
    expect(page).to have_content('Quartos: 6')
    expect(page).to have_content('Sudeste')
    expect(page).to have_content('Animais de Estimação: Não')
    expect(page).to have_link('Editar Imóvel')
    expect(page).not_to have_link('Atualizar Imóvel')
    expect(page).not_to have_content('Edição de Imóvel')
  end

  it 'and must fill all fields' do
    property_type = PropertyType.create!(name: 'Apartamento')
    norte = PropertyLocation.create!(name: 'Norte')
    property = Property.create!({ title: 'Cobertura em Manaus',
                                  description: 'Cobertura de 300m2, churrasqueira e sauna privativa',
                                  rooms: 5, parking_slot: false, bathrooms: 4, pets: true, daily_rate: 1500,
                                  property_type: property_type, property_location: norte })
    property_owner = PropertyOwner.create!(email: 'jane@doe.com.br', password: '123456789')

    login_as property_owner, scope: :property_owner
    visit root_path
    click_link property.title
    click_link 'Editar Imóvel'
    fill_in 'Título', with: ''
    fill_in 'Descrição', with: ''
    fill_in 'Quartos', with: ''
    fill_in 'Banheiros', with: ''
    fill_in 'Diária', with: 0
    click_button 'Atualizar Imóvel'

    expect(page).to have_content('Título não pode ficar em branco')
    expect(page).to have_content('Descrição não pode ficar em branco')
    expect(page).to have_content('Quartos não pode ficar em branco')
    expect(page).to have_content('Banheiros não pode ficar em branco')
    expect(page).to have_content('Diária deve ser maior que 0')
  end
end
