require 'rails_helper'

describe 'Visitor signs up' do
  it 'as property_owner' do
    property_owner = { email: 'jane@doe.com.br', password: '123456789' }

    visit root_path
    click_link 'Entrar como Proprietário'
    click_link 'Registrar'
    fill_in 'E-mail', with: property_owner[:email]
    fill_in 'Senha', with: property_owner[:password]
    fill_in 'Confirmação de Senha', with: property_owner[:password]
    within 'form' do
      click_button 'Registrar'
    end

    expect(page).to have_content('Login efetuado com sucesso.')
    expect(page).to have_content("Logado como #{PropertyOwner.model_name.human}")
    expect(page).to have_content(property_owner[:email])
    expect(page).to have_link('Cadastrar Imóvel', href: new_property_path)
    expect(page).to have_link('Sair', href: destroy_property_owner_session_path)
    expect(page).not_to have_link('Entrar')
  end

  it 'as user' do
    user = { email: 'user@test.com', password: '123456789' }

    visit root_path
    click_link 'Entrar como Usuário'
    click_link 'Registrar'
    fill_in 'E-mail', with: user[:email]
    fill_in 'Senha', with: user[:password]
    fill_in 'Confirmação de Senha', with: user[:password]
    within 'form' do
      click_button 'Registrar'
    end

    expect(page).to have_content('Login efetuado com sucesso.')
    expect(page).to have_content("Logado como #{User.model_name.human}")
    expect(page).to have_content(user[:email])
    expect(page).to have_link('Sair', href: destroy_user_session_path)
    expect(page).not_to have_link('Cadastrar Imóvel')
    expect(page).not_to have_link('Entrar')
  end
end
