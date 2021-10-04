class PropertyTypesController < ApplicationController
  def index
    @property_types = PropertyType.all
  end

  def new
    @property_type = PropertyType.new
  end

  def create
    @property_type = PropertyType.new(property_params)

    if @property_type.save
      redirect_to @property_type
    else
      render :new
    end
  end

  def show
    @property_type = PropertyType.find(params[:id])
  end

  def edit
    @property_type = PropertyType.find(params[:id])
  end

  def update
    @property_type = PropertyType.find(params[:id])

    if @property_type.update(property_params)
      redirect_to @property_type
    else
      render :edit
    end
  end

  private

  def property_params
    params.require(:property_type).permit(:name)
  end
end
