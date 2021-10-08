require 'rails_helper'

describe 'User views own profile' do
  it 'successfully' do
    user = User.create!(email: 'yan@donadi.com.br', password: '123456789')

    login_as user, scope: :user
    visit root_path
    click_link user.email

    expect(page).to have_content('Meu Perfil')
    expect(page).to have_content(user.created_at)
  end
end
