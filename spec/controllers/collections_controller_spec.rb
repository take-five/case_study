require 'rails_helper'

RSpec.describe CollectionsController, :type => :controller do
  before { @user = create :user }

  describe 'GET #show' do
    before { @collection = create :collection, :user => @user }
    before { @monument = create :monument, :collection => @collection }

    it 'shows monuments from collection' do
      get :show, :user_id => @user, :id => @collection

      expect(response).to be_success
      expect(assigns(:monuments)).to eq [@monument]
    end
  end

  describe 'GET #new' do
    it_restricts_access_to 'create collection' do
      get :new, :user_id => @user
    end

    it 'renders collections/new template' do
      sign_in @user

      get :new, :user_id => @user

      expect(response).to be_success
      expect(response).to have_rendered 'new'
    end
  end

  describe 'POST #create' do
    it_restricts_access_to 'create collection' do
      post :create, :user_id => @user, :collection => {:name => 'xxx'}
    end

    it 'renders collections/new template if errors occur' do
      sign_in @user

      post :create, :user_id => @user, :collection => {:name => ''}

      expect(response).to be_success
      expect(response).to have_rendered 'new'
    end

    it 'creates a collection' do
      sign_in @user

      post :create, :user_id => @user, :collection => {:name => 'new collection'}

      expect(Collection.count).to eq 1
      expect(Collection.first.name).to eq 'new collection'

      expect(response).to be_redirect
    end
  end

  describe 'GET #edit' do
    before { @collection = create :collection, :user => @user }

    it_restricts_access_to 'edit collection' do
      get :edit, :user_id => @user, :id => @collection
    end

    it 'renders categories/edit template' do
      sign_in @user

      get :edit, :user_id => @user, :id => @collection

      expect(response).to be_success
      expect(response).to have_rendered 'edit'
    end
  end

  describe 'PUT #update' do
    before { @collection = create :collection, :user => @user }

    it_restricts_access_to 'update collection' do
      put :update, :user_id => @user, :id => @collection
    end

    it 'renders categories/new template if errors occur' do
      sign_in @user

      expect {
        put :update, :user_id => @user, :id => @collection, :collection => {:name => ''}
      }.not_to change{@collection.reload}

      expect(response).to be_success
      expect(response).to have_rendered 'edit'
    end

    it 'updates category' do
      sign_in @user

      expect {
        put :update, :user_id => @user, :id => @collection, :collection => {:name => 'new name'}
      }.to change{@collection.reload.name}.to('new name')

      expect(response).to be_redirect
    end
  end

  describe 'DELETE #destroy' do
    before { @collection = create :collection, :user => @user }

    it_restricts_access_to 'destroy collection' do
      delete :destroy, :user_id => @user, :id => @collection
    end

    it 'destroys collection' do
      sign_in @user

      expect {
        delete :destroy, :user_id => @user, :id => @collection
      }.to change(Collection, :count).from(1).to(0)

      expect(response).to be_redirect
    end
  end

end