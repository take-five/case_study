require 'rails_helper'

RSpec.describe PicturesController, :type => :controller do
  before { @picture = create :picture }

  describe 'GET #show' do
    it 'show picture info' do
      get :show, :monument_id => @picture.monument, :id => @picture

      expect(response).to be_success
      expect(assigns(:picture)).to eq @picture
    end
  end
end