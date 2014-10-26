class MonumentsController < ApplicationController
  before_action :load_collection, :except => :search
  before_action :load_monument, :only => [:show, :edit, :update, :destroy]
  before_action :build_monument, :only => [:new, :create]

  filter_access_to :show, :new, :create, :edit, :update, :destroy, :attribute_check => true
  respond_to :html

  def search
    @search = MonumentsSearch.new(params.require(:search).permit(:category_id, :name))
    @results = @search.results.page(params[:page])

    respond_with(@search)
  end

  def show
    respond_with(@monument)
  end

  def new
    respond_with(@monument)
  end

  def create
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
      Rails.logger.debug {
        @monument.errors.inspect
      }
      @monument.pictures.each do |pic|
        Rails.logger.debug { [pic.inspect, pic.errors.inspect] }
      end
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

  def load_collection
    @collection = Collection.find(params[:collection_id])
  end

  def load_monument
    @monument = @collection.monuments.find(params[:id])
  end

  def build_monument
    @monument = @collection.monuments.build(params[:monument] ? monument_params : {})
  end
end