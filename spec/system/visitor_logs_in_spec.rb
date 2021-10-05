require 'rails_helper'

describe 'Visitor logs in' do
  context 'as PropertyOwner' do
    it 'successfully' do
      property_owner = PropertyOwner.create!(email: 'jane@doe.com.br', password: '123456789')

      visit root_path
      click_link 'Entrar como Proprietário'
      fill_in 'E-mail', with: property_owner.email
      fill_in 'Senha', with: property_owner.password
      within 'form' do
        click_button 'Entrar'
      end

      expect(page).to have_content('Login efetuado com sucesso!')
      expect(page).to have_content("Logado como #{PropertyOwner.model_name.human}")
      expect(page).to have_content(property_owner.email)
      expect(page).to have_link('Cadastrar Imóvel', href: new_property_path)
      expect(page).to have_link('Sair', href: destroy_property_owner_session_path)
      expect(page).not_to have_link('Entrar')
    end

    it 'and logs out' do
      property_owner = PropertyOwner.create!(email: 'jane@doe.com.br', password: '123456789')

      login_as property_owner, scope: :property_owner
      visit root_path
      click_on 'Sair'

      expect(page).to have_content('Saiu com sucesso')
      expect(page).to have_link('Entrar como Proprietário', href: new_property_owner_session_path)
      expect(page).to have_link('Entrar como Usuário', href: new_user_session_path)
      expect(page).not_to have_content('Logado como')
      expect(page).not_to have_content(property_owner.email)
      expect(page).not_to have_link('Cadastrar Imóvel')
      expect(page).not_to have_link('Sair')
    end
  end

  context 'as User' do
    it 'successfully' do
      user = User.create!(email: 'user@test.com', password: '123456789')

      visit root_path
      click_link 'Entrar como Usuário'
      fill_in 'E-mail', with: user.email
      fill_in 'Senha', with: user.password
      within 'form' do
        click_button 'Entrar'
      end

      expect(page).to have_content('Login efetuado com sucesso!')
      expect(page).to have_content("Logado como #{User.model_name.human}")
      expect(page).to have_content(user.email)
      expect(page).to have_link('Sair', href: destroy_user_session_path)
      expect(page).not_to have_link('Cadastrar Imóvel')
      expect(page).not_to have_link('Entrar')
    end

    it 'and logs out' do
      user = User.create!(email: 'user@test.com', password: '123456789')

      login_as user, scope: :user
      visit root_path
      click_link 'Sair'

      expect(page).to have_content('Saiu com sucesso')
      expect(page).to have_link('Entrar como Proprietário', href: new_property_owner_session_path)
      expect(page).to have_link('Entrar como Usuário', href: new_user_session_path)
      expect(page).not_to have_content('Logado como')
      expect(page).not_to have_content(user.email)
      expect(page).not_to have_link('Cadastrar Imóvel')
      expect(page).not_to have_link('Sair')
    end
  end
end
