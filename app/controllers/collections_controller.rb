class CollectionsController < ApplicationController
  filter_resource_access :nested_in => :user, :no_attribute_check => []
  respond_to :html

  def show
    @monuments = @collection.monuments.page(params[:page])

    respond_with(@collection)
  end

  def new
    respond_with(@collection)
  end

  def create
    if @user.collections.create(collection_params)
      redirect_to user_path(@user), :notice => 'Collection created'
    else
      render :new
    end
  end

  def edit
    respond_with(@collection)
  end

  def update
    if @collection.update_attributes(collection_params)
      redirect_to user_path(@user), :notice => 'Collection updated'
    else
      render :edit
    end
  end

  def destroy
    if @collection.destroy
      redirect_to user_path(@user), :notice => 'Collection destroyed'
    else
      redirect_to user_path(@user), :alert => 'Failed to destroy collection'
    end
  end

  private
  def collection_params
    params.require(:collection).permit(:name)
  end
end