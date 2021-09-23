require 'rails_helper'
describe 'Visitor register property location' do
  it 'successfully' do
    # Arrange
    name = 'Nome para teste de cadastro'

    # Act
    visit root_path
    click_link 'Regiões de Imóveis'
    click_link 'Cadastrar'
    fill_in 'Nome', with: name
    click_button 'Cadastrar'

    # Assert
    expect(current_path).to eq property_location_path(PropertyLocation.last)
    expect(page).to have_content(name)
  end

  it 'with an empty name and fails' do
    # Arrange

    # Act
    visit root_path
    click_link 'Regiões de Imóveis'
    click_link 'Cadastrar'
    fill_in 'Nome', with: ''
    click_button 'Cadastrar'

    # Assert
    expect(current_path).to eq new_property_location_path
    expect(page).to have_content('É obrigatório o preenchimento do nome')
  end

  it 'with a duplicated name and fails' do
    # Arrange
    name = 'Nome de região que será repetida'
    PropertyLocation.create(name: name)

    # Act
    visit root_path
    click_link 'Regiões de Imóveis'
    click_link 'Cadastrar'
    fill_in 'Nome', with: name
    click_button 'Cadastrar'

    # Assert
    expect(current_path).to eq new_property_location_path
    expect(page).to have_content('Já existe região cadastrada com esse nome')
  end
end
