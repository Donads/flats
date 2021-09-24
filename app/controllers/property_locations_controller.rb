class PropertyLocationsController < ApplicationController
  def index
    @property_locations = PropertyLocation.all
  end

  def new
    @property_location = PropertyLocation.new
  end

  def create
    @property_location = PropertyLocation.new(params.require(:property_location).permit(:name))

    if @property_location.save
      redirect_to @property_location
    else
      render :new
    end
  end

  def show
    @property_location = PropertyLocation.find(params[:id])
  end
end
