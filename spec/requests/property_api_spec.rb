require 'rails_helper'

describe 'Property API' do
  context 'GET /api/v1/properties' do
    it 'shows properties' do
      property = create(:property, title: 'Apartamento com churrasqueira')
      other_property = create(:property, title: 'Casa com piscina')

      get '/api/v1/properties'

      expect(response).to have_http_status 200
      expect(parsed_body.first[:title]).to eq('Apartamento com churrasqueira')
      expect(parsed_body.second[:title]).to eq('Casa com piscina')
      expect(parsed_body.count).to eq 2
    end

    it 'returns no properties' do
      get '/api/v1/properties'

      expect(response).to have_http_status 200
      expect(parsed_body).to be_empty
    end
  end

  context 'GET /api/v1/properties/:id' do
    it 'show property details' do
      property = create(:property, title: 'Apartamento Legal', bathrooms: 5, daily_rate: 200, pets: true)

      get "/api/v1/properties/#{property.id}"

      expect(response).to have_http_status 200
      expect(response.content_type).to include('application/json')
      expect(parsed_body[:title]).to eq 'Apartamento Legal'
      expect(parsed_body[:bathrooms]).to eq 5
      expect(parsed_body[:daily_rate]).to eq '200.0'
      expect(parsed_body[:pets]).to eq true
    end

    it 'returns status 404 if property does not exist' do
      allow(Property).to receive(:find).and_raise(ActiveRecord::RecordNotFound)

      get '/api/v1/properties/1'

      expect(response).to have_http_status 404
      expect(parsed_body[:error]).to eq 'Objeto não encontrado'
    end

    it 'returns status 500 if database is not available' do
      allow(Property).to receive(:find).and_raise(ActiveRecord::ActiveRecordError)

      get '/api/v1/properties/1'

      expect(response).to have_http_status 500
      expect(parsed_body[:error]).to eq 'Erro interno'
    end
  end

  context 'POST /api/v1/properties' do
    it 'create new property' do
      property_location = create(:property_location, name: 'Sudeste')
      property_type = create(:property_type, name: 'Apartamento')
      property_owner = create(:property_owner, email: 'proprietario@teste.com.br')

      params = { property: { title: 'Apartamento Legal', description: 'Apartamento com vista pra praia', rooms: 4,
                             bathrooms: 5, daily_rate: 200, pets: true, parking_slot: true,
                             property_location_id: property_location.id, property_type_id: property_type.id,
                             property_owner_id: property_owner.id } }

      post '/api/v1/properties', params: params

      expect(response).to have_http_status 201
      expect(response.content_type).to include('application/json')
      expect(parsed_body[:id]).to eq Property.last.id
      expect(parsed_body[:title]).to eq 'Apartamento Legal'
      expect(parsed_body[:description]).to eq 'Apartamento com vista pra praia'
      expect(parsed_body[:bathrooms]).to eq 5
      expect(parsed_body[:daily_rate]).to eq '200.0'
      expect(parsed_body[:pets]).to eq true
      expect(parsed_body[:property_location][:name]).to eq 'Sudeste'
      expect(parsed_body[:property_type][:name]).to eq 'Apartamento'
      expect(parsed_body[:property_owner][:email]).to eq 'proprietario@teste.com.br'
    end
  end
end
