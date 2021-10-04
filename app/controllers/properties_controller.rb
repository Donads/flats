class PropertiesController < ApplicationController
  before_action :require_login, except: %i[show]

  def new
    @property = Property.new
  end

  def create
    @property = Property.new(property_params)

    if @property.save
      redirect_to @property
    else
      render :new
    end
  end

  def show
    @property = Property.find(params[:id])
  end

  private

  def property_params
    params.require(:property).permit(:title, :description, :rooms, :parking_slot, :bathrooms,
                                     :pets, :daily_rate, :property_type_id, :property_location_id)
  end

  def require_login
    redirect_to new_property_owner_session_path unless property_owner_signed_in?
  end
end
