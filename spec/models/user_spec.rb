require 'rails_helper'

RSpec.describe User, :type => :model do
  describe 'Constraints' do
    it { is_expected.to validate_presence_of :email }
    it { is_expected.to validate_presence_of :username }

    describe 'Unique attributes' do
      before { create :user }

      it { is_expected.to validate_uniqueness_of :email }
      it { is_expected.to validate_uniqueness_of :username }
    end
  end

  describe 'Associations' do
    it { is_expected.to have_many(:collections).dependent(:destroy) }
  end
end
