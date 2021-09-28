class HomeController < ApplicationController
  def index
    @properties = Property.all

    if params[:location]
      @properties = @properties.joins(:property_location).where(property_location: { name: params[:location] })
    end
    if params[:type]
      @properties = @properties.joins(:property_type).where(property_type: { name: params[:type] })
    end

    @property_locations = PropertyLocation.all
    @property_types = PropertyType.all
  end
end
