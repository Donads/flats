class PropertyLocationsController < ApplicationController
  def index
    @property_locations = PropertyLocation.all
  end

  def new
    @property_location = PropertyLocation.new
  end

  def create
    @property_location = PropertyLocation.new(property_params)

    if @property_location.save
      redirect_to @property_location
    else
      render :new
    end
  end

  def show
    @property_location = PropertyLocation.find(params[:id])
  end

  def edit
    @property_location = PropertyLocation.find(params[:id])
  end

  def update
    @property_location = PropertyLocation.find(params[:id])

    if @property_location.update(property_params)
      redirect_to @property_location
    else
      render :edit
    end
  end

  private

  def property_params
    params.require(:property_location).permit(:name)
  end
end
