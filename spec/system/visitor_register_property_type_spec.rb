require 'rails_helper'

describe 'Visitor register property type' do
  it 'successfully' do
    name = 'Nome para teste de cadastro'

    visit root_path
    click_link 'Tipos de Imóveis'
    click_link 'Cadastrar'
    fill_in 'Nome', with: name
    click_button 'Criar Tipo de Imóvel'

    expect(current_path).to eq property_type_path(PropertyType.last)
    expect(page).to have_content(name)
  end

  it 'with an empty name and fails' do
    visit root_path
    click_link 'Tipos de Imóveis'
    click_link 'Cadastrar'
    fill_in 'Nome', with: ''
    click_button 'Criar Tipo de Imóvel'

    expect(current_path).to eq property_types_path
    expect(page).to have_content("#{PropertyType.human_attribute_name('name')} #{I18n.t('errors.messages.blank')}")
  end

  it 'with a duplicated name and fails' do
    name = 'Nome de tipo que será repetido'
    PropertyType.create!(name: name)

    visit root_path
    click_link 'Tipos de Imóveis'
    click_link 'Cadastrar'
    fill_in 'Nome', with: name
    click_button 'Criar Tipo de Imóvel'

    expect(current_path).to eq property_types_path
    expect(page).to have_content("#{PropertyType.human_attribute_name('name')} #{I18n.t('errors.messages.taken')}")
  end
end
