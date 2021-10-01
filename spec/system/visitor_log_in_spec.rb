require 'rails_helper'

describe 'Visitor logs in' do
  context 'as property owner' do
    it 'successfully' do
      property_owner = PropertyOwner.create!(email: 'jane@doe.com.br', password: '123456789')

      visit root_path
      click_link 'Entrar'
      fill_in 'E-mail', with: property_owner.email
      fill_in 'Senha', with: property_owner.password
      within 'form' do
        click_button 'Entrar'
      end

      expect(page).to have_content('Login efetuado com sucesso!')
      expect(page).to have_content(property_owner.email)
      expect(page).to have_link('Sair')
      expect(page).to have_link('Cadastrar Imóvel')
      expect(page).not_to have_link('Entrar')
    end

    it 'and logs out' do
      property_owner = PropertyOwner.create!(email: 'jane@doe.com.br', password: '123456789')

      login_as property_owner, scrope: :property_owner
      visit root_path
      click_on 'Sair'

      expect(page).to have_content('Saiu com sucesso')
      expect(page).to have_link('Entrar')
      expect(page).not_to have_content(property_owner.email)
      expect(page).not_to have_link('Sair')
      expect(page).not_to have_link('Cadastrar Imóvel')
    end

    it 'and create an account' do
      # TODO: Fazer depois
    end
  end

  context 'as user' do
    # TODO: Criar model no devise
  end
end
