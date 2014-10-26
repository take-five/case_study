require 'rails_helper'

RSpec.describe CategoriesController, :type => :controller do
  describe 'GET #index' do
    before { @towers = create :category, :name => 'Towers' }
    before { @castles = create :category, :name => 'Castles' }

    it 'shows categories list ordered by name' do
      get :index

      expect(response).to be_success
      expect(assigns(:categories)).to eq [@castles, @towers]
    end
  end

  describe 'GET #show' do
    before { @category = create :category }
    before { @monument = create :monument, :category => @category }

    it 'shows given category monuments' do
      get :show, :id => @category.id

      expect(response).to be_success
      expect(assigns(:monuments)).to eq [@monument]
    end
  end

  describe 'GET #new' do
    it 'renders categories/new template' do
      get :new

      expect(response).to be_success
      expect(response).to have_rendered 'new'
    end
  end

  describe 'POST #create' do
    it 'renders categories/new template if errors occur' do
      post :create, :category => {:name => ''}

      expect(response).to be_success
      expect(response).to have_rendered 'new'
    end

    it 'creates a category' do
      post :create, :category => {:name => 'new category'}

      expect(Category.count).to eq 1
      expect(Category.first.name).to eq 'new category'

      expect(response).to be_redirect
    end
  end

  describe 'GET #edit' do
    before { @category = create :category }

    it 'renders categories/edit template' do
      get :edit, :id => @category.id

      expect(response).to be_success
      expect(response).to have_rendered 'edit'
    end
  end

  describe 'PUT #update' do
    before { @category = create :category }

    it 'renders categories/new template if errors occur' do
      expect {
        post :update, :id => @category.id, :category => {:name => ''}
      }.not_to change{@category.reload}

      expect(response).to be_success
      expect(response).to have_rendered 'edit'
    end

    it 'updates category' do
      expect {
        post :update, :id => @category.id, :category => {:name => 'new name'}
      }.to change{@category.reload.name}.to('new name')

      expect(response).to be_redirect
    end
  end

  describe 'DELETE #destroy' do
    before { @category = create :category }

    it 'destroys category' do
      expect {
        delete :destroy, :id => @category.id
      }.to change(Category, :count).from(1).to(0)

      expect(response).to be_redirect
    end
  end
end