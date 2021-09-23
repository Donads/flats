require 'rails_helper'

describe 'Visitor register property type' do
  it 'successfully' do
    # Arrange
    name = 'Nome para teste de cadastro'

    # Act
    visit root_path
    click_link 'Tipos de Imóveis'
    click_link 'Cadastrar'
    fill_in 'Nome', with: name
    click_button 'Cadastrar'

    # Assert
    expect(current_path).to eq property_type_path(PropertyType.last)
    expect(page).to have_content(name)
  end

  it 'with an empty name and fails' do
    # Arrange

    # Act
    visit root_path
    click_link 'Tipos de Imóveis'
    click_link 'Cadastrar'
    fill_in 'Nome', with: ''
    click_button 'Cadastrar'

    # Assert
    expect(current_path).to eq new_property_type_path
    expect(page).to have_content('É obrigatório o preenchimento do nome')
  end

  it 'with a duplicated name and fails' do
    # Arrange
    name = 'Nome de tipo que será repetido'
    PropertyType.create(name: name)

    # Act
    visit root_path
    click_link 'Tipos de Imóveis'
    click_link 'Cadastrar'
    fill_in 'Nome', with: name
    click_button 'Cadastrar'

    # Assert
    expect(current_path).to eq new_property_type_path
    expect(page).to have_content('Já existe tipo cadastrado com esse nome')
  end
end
