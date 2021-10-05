require 'rails_helper'

describe 'Visitor registers property location' do
  it 'successfully' do
    name = 'Nome para teste de cadastro'

    visit root_path
    click_link 'Regiões de Imóveis'
    click_link 'Cadastrar'
    fill_in 'Nome', with: name
    click_button 'Criar Região do Imóvel'

    expect(current_path).to eq property_location_path(PropertyLocation.last)
    expect(page).to have_content(name)
  end

  it 'with an empty name and fails' do
    visit root_path
    click_link 'Regiões de Imóveis'
    click_link 'Cadastrar'
    fill_in 'Nome', with: ''
    click_button 'Criar Região do Imóvel'

    expect(current_path).to eq property_locations_path
    expect(page).to have_content("#{PropertyLocation.human_attribute_name('name')} #{I18n.t('errors.messages.blank')}")
  end

  it 'with a duplicated name and fails' do
    name = 'Nome de região que será repetida'
    PropertyLocation.create!(name: name)

    visit root_path
    click_link 'Regiões de Imóveis'
    click_link 'Cadastrar'
    fill_in 'Nome', with: name
    click_button 'Criar Região do Imóvel'

    expect(current_path).to eq property_locations_path
    expect(page).to have_content("#{PropertyLocation.human_attribute_name('name')} #{I18n.t('errors.messages.taken')}")
  end
end
