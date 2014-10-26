require 'rails_helper'

RSpec.describe MonumentsController, :type => :controller do
  before { @user = create :user }
  before { @collection = create :collection, :user => @user }

  describe 'GET #search' do
    before { @category = create :category }
    before { @monument = create :monument, :category => @category,  :name => 'tower of hope'}

    it 'searches for monuments' do
      get :search, :search => {:name => 'tower hope', :category_id => @category.id }

      expect(assigns(:results)).to eq [@monument]
    end
  end

  describe 'GET #show' do
    before { @monument = create :monument, :collection => @collection }

    it 'shows information about monument' do
      get :show, :collection_id => @collection, :id => @monument

      expect(response).to be_success
      expect(assigns(:monument)).to eq @monument
    end
  end

  describe 'GET #new' do
    it_restricts_access_to 'create monument' do
      get :new, :collection_id => @collection
    end

    it 'renders collections/new template' do
      sign_in @user

      get :new, :collection_id => @collection

      expect(response).to be_success
      expect(response).to have_rendered 'new'
    end
  end

  describe 'POST #create' do
    before { @category = create :category }

    it_restricts_access_to 'create monument' do
      post :create, :collection_id => @collection, :monument => {:name => 'xxx'}
    end

    it 'renders collections/new template if errors occur' do
      sign_in @user

      post :create, :collection_id => @collection, :monument => {:name => ''}

      expect(response).to be_success
      expect(response).to have_rendered 'new'
    end

    it 'creates a monument' do
      sign_in @user

      post :create,
           :collection_id => @collection,
           :monument => {
               :category_id => @category.id,
               :name => 'new monument',
               :pictures_attributes => {
                   0 => {
                       :name => 'Picture 1',
                       :description => 'Picture description 1',
                       :image => fixture('picture.jpg')
                   }
               }
           }

      expect(Monument.count).to eq 1

      monument = Monument.first
      expect(monument.name).to eq 'new monument'

      expect(response).to be_redirect
    end
  end

  describe 'GET #edit' do
    before { @monument = create :monument, :collection => @collection }

    it_restricts_access_to 'edit monument' do
      get :edit, :collection_id => @collection, :id => @monument
    end

    it 'renders monuments/edit template' do
      sign_in @user

      get :edit, :collection_id => @collection, :id => @monument

      expect(response).to be_success
      expect(response).to have_rendered 'edit'
    end
  end

  describe 'PUT #update' do
    before { @monument = create :monument, :collection => @collection }

    let(:picture) { @monument.pictures.first }
    let(:another_category) { create :category }

    let(:monument_data) do
      Hash[
          :name => 'New name',
          :description => 'New description',
          :category_id => another_category,
          :pictures_attributes => {
              '0' => { :id => picture.id, :_destroy => 1 },
              '1' => {
                  :name => 'New picture',
                  :description => 'New picture description',
                  :image => fixture_file_upload('picture.jpg'),
                  :_destroy => 'false'
              }
          }
      ]
    end

    it_restricts_access_to 'update monument' do
      put :update, :collection_id => @collection, :id => @monument, :monument => monument_data
    end

    it 'renders monuments/edit template if errors occur' do
      sign_in @user

      expect {
        put :update, :collection_id => @collection, :id => @monument, :monument => {:name => ''}
      }.not_to change{@monument.reload}

      expect(response).to be_success
      expect(response).to have_rendered 'edit'
    end

    it 'updates monument' do
      sign_in @user

      put :update, :collection_id => @collection, :id => @monument, :monument => monument_data

      @monument.reload

      expect(@monument.name).to eq 'New name'
      expect(@monument.description).to eq 'New description'
      expect(@monument.category).to eq another_category
      expect(@monument.pictures.size).to eq 1

      picture = @monument.pictures.first
      expect(picture.name).to eq 'New picture'
      expect(picture.description).to eq 'New picture description'
      expect(File).to exist(picture.image.file.path)
    end
  end

  describe 'DELETE #destroy' do
    before { @monument = create :monument, :collection => @collection }

    it_restricts_access_to 'destroy monument' do
      delete :destroy, :collection_id => @collection, :id => @monument
    end

    it 'destroys monument' do
      sign_in @user

      expect {
        delete :destroy, :collection_id => @collection, :id => @monument
      }.to change(Monument, :count).from(1).to(0)

      expect(response).to be_redirect
    end
  end
end