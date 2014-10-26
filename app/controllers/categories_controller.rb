class CategoriesController < ApplicationController
  filter_resource_access
  respond_to :html

  def index
    @categories = Category.ordered.page(params[:page])

    respond_with(@categories)
  end

  def show
    @monuments = @category.monuments.includes(:pictures).page(params[:page])

    respond_with(@category)
  end

  def new
    respond_with(@category)
  end

  def create
    @category = Category.new(category_params)

    if @category.save
      redirect_to root_path, :notice => 'Category created'
    else
      render :new
    end
  end

  def edit
    respond_with(@category)
  end

  def update
    if @category.update_attributes(category_params)
      redirect_to root_path, :notice => 'Category updated'
    else
      render :edit
    end
  end

  def destroy
    if @category.destroy
      redirect_to root_path, :notice => 'Category destroyed'
    else
      redirect_to root_path, :alert => 'Failed to destroy category due to some reasons'
    end
  end

  private
  def category_params
    params.require(:category).permit(:name)
  end
end