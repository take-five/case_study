require 'rails_helper'

RSpec.describe Monument, :type => :model do
  # Returns fd referring to opened fixture file
  def fixture(name)
    Rails.root.join('spec', 'fixtures', name).open
  end

  describe 'Constraints' do
    it { is_expected.to validate_presence_of :name }
    it { is_expected.to validate_presence_of :picture }
    it { is_expected.to validate_presence_of(:collection).with_message(/does not exist/) }
    it { is_expected.to validate_presence_of(:category).with_message(/does not exist/) }

    describe 'File extension' do
      let(:wrong_file) { Tempfile.new(['spec', '.txt']) }
      let(:proper_file) { fixture 'picture.jpg' }

      it { is_expected.not_to allow_value(wrong_file).for(:picture) }
      it { is_expected.to allow_value(proper_file).for(:picture) }
    end

    describe 'File size' do
      let(:wrong_file) { Tempfile.new(['spec', '.jpg']) }

      # generate more than 4 MB file
      before { 1025.times { wrong_file.write('x' * 4096) } }

      it { is_expected.not_to allow_value(wrong_file).for(:picture).with_message(/too big/) }
    end

    describe 'File content' do
      let(:wrong_file) { Tempfile.new(['spec', '.jpg']).tap { |file| file.write('random content') } }

      it { is_expected.not_to allow_value(wrong_file).for(:picture).with_message(/not an image/) }
    end
  end

  describe 'Associations' do
    it { is_expected.to belong_to :collection }
    it { is_expected.to belong_to :category }
  end

  describe 'File uploading' do
    let(:picture) { create :monument, :picture => fixture('big_picture.jpg') }

    it { expect(picture.picture).to be_no_larger_than 900, 600 }
    it { expect(picture.picture.thumb).to be_no_larger_than 640, 480 }
  end
end
