require 'rails_helper'

describe 'PropertyOwner authentication' do
  it 'cannot create property without being authenticated' do
    post '/properties'

    expect(response).to redirect_to(new_property_owner_session_path)
  end

  it 'cannot access new property form unless authenticated' do
    get '/properties/new'

    expect(response).to redirect_to(new_property_owner_session_path)
  end
end
