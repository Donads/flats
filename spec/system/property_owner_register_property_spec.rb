require 'rails_helper'

describe 'PropertyOwner register property' do
  it 'successfully' do
    property_owner = PropertyOwner.create!(email: 'jane@doe.com.br', password: '123456789')
    PropertyType.create!(name: 'Casa')
    PropertyLocation.create!(name: 'Sudeste')

    login_as property_owner, scope: :property_owner
    visit root_path
    click_link 'Cadastrar Imóvel'
    fill_in 'Título', with: 'Casa em Florianópolis'
    fill_in 'Descrição', with: 'Ótima casa perto da USFC'
    fill_in 'Quartos', with: '3'
    fill_in 'Banheiros', with: '2'
    fill_in 'Diária', with: 200
    select 'Casa', from: 'Tipo de Imóvel'
    select 'Sudeste', from: 'Região do Imóvel'
    check 'Animais de Estimação'
    check 'Vaga de Estacionamento'
    click_button 'Criar Imóvel'

    expect(page).to have_content('Casa em Florianópolis')
    expect(page).to have_content('Ótima casa perto da USFC')
    expect(page).to have_content('Quartos: 3')
    expect(page).to have_content('Banheiros: 2')
    expect(page).to have_content('Animais de Estimação: Sim')
    expect(page).to have_content('Vaga de Estacionamento: Sim')
    expect(page).to have_content('Diária: R$ 200,00')
    expect(page).to have_content('Casa')
    expect(page).to have_content('Sudeste')
  end

  it 'and must fill all fields' do
    property_owner = PropertyOwner.create!(email: 'jane@doe.com.br', password: '123456789')
    PropertyType.create!(name: 'Casa')
    PropertyLocation.create!(name: 'Sudeste')

    login_as property_owner, scope: :property_owner
    visit root_path
    click_link 'Cadastrar Imóvel'
    # fill_in 'Título', with: ''
    # fill_in 'Descrição', with: ''
    # fill_in 'Quartos', with: ''
    # fill_in 'Banheiros', with: ''
    # fill_in 'Diária', with: 0
    select 'Casa', from: 'Tipo de Imóvel'
    select 'Sudeste', from: 'Região do Imóvel'
    click_button 'Criar Imóvel'

    expect(page).to have_content('Título não pode ficar em branco')
    expect(page).to have_content('Descrição não pode ficar em branco')
    expect(page).to have_content('Quartos não pode ficar em branco')
    expect(page).to have_content('Banheiros não pode ficar em branco')
    expect(page).to have_content('Diária não pode ficar em branco')
  end

  it 'and fills it with invalid formats' do
    property_owner = PropertyOwner.create!(email: 'jane@doe.com.br', password: '123456789')
    PropertyType.create!(name: 'Casa')
    PropertyLocation.create!(name: 'Sudeste')

    login_as property_owner, scope: :property_owner
    visit root_path
    click_link 'Cadastrar Imóvel'
    fill_in 'Título', with: 'Casa em Florianópolis'
    fill_in 'Descrição', with: 'Ótima casa perto da USFC'
    fill_in 'Quartos', with: 'a'
    fill_in 'Banheiros', with: 2.5
    fill_in 'Diária', with: 'a'
    select 'Casa', from: 'Tipo de Imóvel'
    select 'Sudeste', from: 'Região do Imóvel'
    click_button 'Criar Imóvel'

    expect(page).to have_content('Quartos não é um número')
    expect(page).to have_content('Banheiros não é um número inteiro')
    expect(page).to have_content('Diária não é um número')
  end

  it 'cant be accessed via route' do
    visit new_property_path

    expect(current_path).to eq(new_property_owner_session_path)
  end
end
