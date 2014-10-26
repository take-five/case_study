class PicturesController < ApplicationController
  respond_to :html

  def show
    @monument = Monument.find(params[:monument_id])
    @picture = @monument.pictures.find(params[:id])

    respond_with(@picture)
  end
end