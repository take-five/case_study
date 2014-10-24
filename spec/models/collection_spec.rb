require 'rails_helper'

RSpec.describe Collection, :type => :model do
  it { is_expected.to belong_to :user }

  it { is_expected.to have_many(:monuments).dependent(:destroy) }
end
