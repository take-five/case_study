require 'rails_helper'

RSpec.describe CollectionsController, :type => :controller do
  before { bypass_rescue }
  before { @user = create :user }

  # Shortcut to raise_error(ApplicationController::PermissionDenied)
  def restrict_access
    raise_error(ApplicationController::PermissionDenied)
  end

  # Usage:
  #   it_restricts_access_to('create collection') { |user| get :new, :user_id => user }
  def self.it_restricts_access_to(action_name, &block)
    it 'restricts access if user is not logged in' do
      expect { instance_exec(@user, &block) }.to restrict_access
    end

    it "restricts access if user tries to #{action_name} under another login" do
      @other = create :user
      sign_in @other
      expect { instance_exec(@user, &block) }.to restrict_access
    end
  end

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
    it_restricts_access_to 'create collection' do |user|
      get :new, :user_id => user
    end

    it 'renders collections/new template' do
      sign_in @user

      get :new, :user_id => @user

      expect(response).to be_success
      expect(response).to have_rendered 'new'
    end
  end

  describe 'POST #create' do
    it_restricts_access_to 'create collection' do |user|
      post :create, :user_id => user, :collection => {:name => 'xxx'}
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

    it_restricts_access_to 'edit collection' do |user|
      get :edit, :user_id => user, :id => @collection
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

    it_restricts_access_to 'update collection' do |user|
      put :update, :user_id => user, :id => @collection
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
end