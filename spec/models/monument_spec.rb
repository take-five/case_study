require 'rails_helper'

RSpec.describe Monument, :type => :model do
  # Returns fd referring to opened fixture file
  def fixture(name)
    Rails.root.join('spec', 'fixtures', name).open
  end

  describe 'Constraints' do
    it { is_expected.to validate_presence_of :name }
    it { is_expected.to validate_presence_of(:collection).with_message(/does not exist/) }
    it { is_expected.to validate_presence_of(:category).with_message(/does not exist/) }
  end

  describe 'Associations' do
    it { is_expected.to belong_to :collection }
    it { is_expected.to belong_to :category }
    it { is_expected.to have_many :pictures }
  end
end
