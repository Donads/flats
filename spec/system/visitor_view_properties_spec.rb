# spec/system/visitor_view_properties_spec.rb

require 'rails_helper'

describe 'Visitor visits homepage' do
  it 'and views properties' do
    # Arrange
    Property.create({ title: 'Casa com quintal em Copacabana',
                      description: 'Excelente casa, recém reformada com 2 vagas de garagem',
                      rooms: 3, parking_slot: true })
    Property.create({ title: 'Cobertura em Manaus',
                      description: 'Cobertura de 300m2, churrasqueira e sauna privativa',
                      rooms: 5, parking_slot: false })

    # Act
    visit root_path

    # Assert
    # 2 imoveis -> casa com quintal em copacabana; cobertura em manaus
    expect(page).to have_text('Casa com quintal em Copacabana')
    expect(page).to have_text('Excelente casa, recém reformada com 2 vagas de garagem')
    expect(page).to have_text('Cobertura em Manaus')
    expect(page).to have_text('Cobertura de 300m2, churrasqueira e sauna privativa')
  end

  it 'and there is no property available' do
    # Arrange

    # Act
    visit root_path

    # Assert
    expect(page).to have_text('Nenhum imóvel disponível')
  end

  it 'and view property details' do
    # Arrange
    Property.create({ title: 'Casa com quintal em Copacabana',
                      description: 'Excelente casa, recém reformada com 2 vagas de garagem',
                      rooms: 3, parking_slot: true, bathrooms: 2, pets: true, daily_rate: 500 })
    Property.create({ title: 'Cobertura em Manaus',
                      description: 'Cobertura de 300m2, churrasqueira e sauna privativa',
                      rooms: 5, parking_slot: false })

    # Act
    visit root_path
    click_on 'Casa com quintal em Copacabana'

    # Assert
    expect(page).to_not have_text('Cobertura em Manaus')
    expect(page).to have_text('Casa com quintal em Copacabana')
    expect(page).to have_text('Excelente casa, recém reformada com 2 vagas de garagem')
    expect(page).to have_text('Quartos: 3')
    expect(page).to have_text('Banheiros: 2')
    expect(page).to have_text('Aceita Pets: Sim')
    expect(page).to have_text('Estacionamento: Sim')
    expect(page).to have_text('Diária: R$ 500,00')
  end

  it 'and view property details and return to home page' do
    # Arrange
    Property.create({ title: 'Casa com quintal em Copacabana',
                      description: 'Excelente casa, recém reformada com 2 vagas de garagem',
                      rooms: 3, parking_slot: true, bathrooms: 2, pets: true, daily_rate: 500 })
    Property.create({ title: 'Cobertura em Manaus',
                      description: 'Cobertura de 300m2, churrasqueira e sauna privativa',
                      rooms: 5, parking_slot: false })

    # Act
    visit root_path
    click_on 'Casa com quintal em Copacabana'
    click_on 'Voltar'

    # Assert
    expect(current_path).to eq root_path
    expect(page).to have_text('Casa com quintal em Copacabana')
    expect(page).to have_text('Cobertura em Manaus')
  end
end
