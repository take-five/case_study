require 'rails_helper'

RSpec.describe Picture, :type => :model do
  it { is_expected.to belong_to :monument }

  describe 'Constraints' do
    it { is_expected.to validate_presence_of :image }

    describe 'File extension' do
      let(:wrong_file) { Tempfile.new(['spec', '.txt']) }
      let(:proper_file) { fixture 'picture.jpg' }

      it { is_expected.not_to allow_value(wrong_file).for(:image) }
      it { is_expected.to allow_value(proper_file).for(:image) }
    end

    describe 'File size' do
      let(:wrong_file) { Tempfile.new(['spec', '.jpg']) }

      # generate more than 4 MB file
      before { 1025.times { wrong_file.write('x' * 4096) } }

      it { is_expected.not_to allow_value(wrong_file).for(:image).with_message(/too big/) }
    end

    describe 'File content' do
      let(:wrong_file) { Tempfile.new(['spec', '.jpg']).tap { |file| file.write('random content') } }

      it { is_expected.not_to allow_value(wrong_file).for(:image).with_message(/not an image/) }
    end
  end

  describe 'File uploading' do
    let(:picture) { create :picture, :image => fixture('big_picture.jpg') }
    let(:image) { picture.image }

    it { expect(image).to be_no_larger_than 900, 600 }
    it { expect(image.thumb).to be_no_larger_than 640, 480 }

    it 'caches image dimensions' do
      expect(image).to have_dimensions(picture.width, picture.height)
    end
  end
end
