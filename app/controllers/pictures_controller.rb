class PicturesController < ApplicationController
  filter_resource_access :nested_in => :monument
  respond_to :html

  def show
    respond_with(@picture)
  end
end