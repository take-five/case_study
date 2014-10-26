class MonumentsController < ApplicationController
  filter_resource_access :nested_in => :collection, :no_attribute_check => []
  respond_to :html

  def show
    respond_with(@monument)
  end

  def new
    respond_with(@monument)
  end

  def create
    @monument = @collection.monuments.build(monument_params)

    if @monument.save
      redirect_to collection_monument_path(@collection, @monument), :notice => 'Monument created'
    else
      render :new
    end
  end

  def edit
    respond_with(@monument)
  end

  def update
    if @monument.update_attributes(monument_params)
      redirect_to collection_monument_path(@collection, @monument), :notice => 'Monument updated'
    else
      render :edit
    end
  end

  def destroy
    if @monument.destroy
      redirect_to user_collection_path(@collection.user, @collection), :notice => 'Monument destroyed'
    else
      redirect_to collection_monument_path(@collection, @monument), :alert => 'Failed to destroy monument'
    end
  end

  private
  def monument_params
    params.require(:monument).permit(
        :category_id, :name, :description,
        :pictures_attributes => [:id, :name, :description, :image, :_destroy]
    )
  end
end