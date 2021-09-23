require 'rails_helper'

describe 'Visitor register property' do
  it 'successfully' do
    # Arrange
    Rails.application.load_seed

    # Act
    visit root_path
    click_on 'Cadastrar Imóvel'
    fill_in 'Título', with: 'Casa em Florianópolis'
    fill_in 'Descrição', with: 'Ótima casa perto da USFC'
    fill_in 'Quartos', with: '3'
    fill_in 'Banheiros', with: '2'
    fill_in 'Diária', with: 200
    select 'Casa', from: 'Tipo de Imóvel'
    select 'Sudeste', from: 'Região do Imóvel'
    check 'Aceita Pets'
    check 'Vaga de Estacionamento'
    click_on 'Cadastrar'

    # Assert
    expect(page).to have_content('Casa em Florianópolis')
    expect(page).to have_content('Ótima casa perto da USFC')
    expect(page).to have_content('Quartos: 3')
    expect(page).to have_content('Banheiros: 2')
    expect(page).to have_content('Aceita Pets: Sim')
    expect(page).to have_content('Estacionamento: Sim')
    expect(page).to have_content('Diária: R$ 200,00')
  end
end
