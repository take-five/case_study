require 'rails_helper'

RSpec.describe UsersController, :type => :controller do
  describe 'GET #index' do
    before { @user = create :user }

    it 'shows users list' do
      get :index

      expect(response).to be_success
      expect(assigns(:users)).to eq [@user]
    end
  end

  describe 'GET #show' do
    before { @user = create :user }
    before { @collection = create :collection, :user => @user }

    it 'shows user collections' do
      get :show, :id => @user

      expect(response).to be_success
      expect(assigns(:user)).to eq @user
      expect(assigns(:collections)).to eq [@collection]
    end
  end
end