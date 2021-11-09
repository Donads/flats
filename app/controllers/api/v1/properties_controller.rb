class Api::V1::PropertiesController < Api::V1::ApiController
  def create
    @property = Property.new(property_params)

    if @property.save
      render status: 201, json: show_property
    else
      render status: 400, json: '{ "error": "Não foi possível criar o objeto" }'
    end
  end

  def index
    @properties = Property.all

    render json: @properties.as_json(except: %i[created_at updated_at property_location_id property_type_id
                                                property_owner_id],
                                     include: { property_location: { only: %i[name] },
                                                property_type: { only: %i[name] } })
  end

  def show
    @property = Property.find(params[:id])
    render json: show_property
  end

  private

  def property_params
    params.require(:property).permit(:title, :description, :rooms, :parking_slot, :bathrooms,
                                     :pets, :daily_rate, :property_type_id, :property_location_id, :property_owner_id)
  end

  def show_property
    @property.as_json(except: %i[created_at updated_at property_location_id property_type_id
                                 property_owner_id],
                      include: { property_location: { only: %i[name] },
                                 property_type: { only: %i[name] }, property_owner: { only: %i[email] } })
  end
end
