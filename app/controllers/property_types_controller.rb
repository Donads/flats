class PropertyTypesController < ApplicationController
  def index
    @property_types = PropertyType.all
  end

  def new
    @property_type = PropertyType.new
  end

  def create
    @property_type = PropertyType.new(params.require(:property_type).permit(:name))

    if @property_type.save
      redirect_to @property_type
    else
      flash[:notice] = @property_type.errors.messages.values.first
      redirect_to new_property_type_path
    end
  end

  def show
    @property_type = PropertyType.find(params[:id])
  end
end
