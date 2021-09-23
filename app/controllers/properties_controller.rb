class PropertiesController < ApplicationController
  def new
    @property = Property.new
  end

  def create
    @property = Property.new(params.require(:property).permit(:title, :description, :rooms, :parking_slot, :bathrooms,
                                                              :pets, :daily_rate, :property_type_id, :property_location_id))

    if @property.save
      redirect_to @property
    else
      redirect_to new_property_path
    end
  end

  def show
    @property = Property.find(params[:id])
  end
end
