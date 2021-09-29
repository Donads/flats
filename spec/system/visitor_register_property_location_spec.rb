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
    click_button 'Criar Região do Imóvel'

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
    click_button 'Criar Região do Imóvel'

    # Assert
    expect(current_path).to eq property_locations_path
    expect(page).to have_content("#{PropertyLocation.human_attribute_name('name')} #{I18n.t('errors.messages.blank')}")
  end

  it 'with a duplicated name and fails' do
    # Arrange
    name = 'Nome de região que será repetida'
    PropertyLocation.create!(name: name)

    # Act
    visit root_path
    click_link 'Regiões de Imóveis'
    click_link 'Cadastrar'
    fill_in 'Nome', with: name
    click_button 'Criar Região do Imóvel'

    # Assert
    expect(current_path).to eq property_locations_path
    expect(page).to have_content("#{PropertyLocation.human_attribute_name('name')} #{I18n.t('errors.messages.taken')}")
  end
end
