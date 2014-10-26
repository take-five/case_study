class CollectionsController < ApplicationController
  before_action :load_user
  before_action :load_collection, :except => [:new, :create]
  before_action :build_collection, :only => [:new, :create]

  filter_access_to :all, :attribute_check => true

  respond_to :html

  def show
    @monuments = @collection.monuments.page(params[:page])

    respond_with(@collection)
  end

  def new
    @collection = @user.collections.build

    respond_with(@collection)
  end

  def create
    if @collection.save
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

  def load_user
    @user = User.find(params[:user_id])
  end

  def load_collection
    @collection = @user.collections.find(params[:id])
  end

  def build_collection
    @collection = @user.collections.build(params[:collection] ? collection_params : {})
  end
end