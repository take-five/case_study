require 'rails_helper'

RSpec.describe MonumentsSearch do
  describe 'Constraints' do
    before { @category = create(:category) }
    let(:empty) { ' ' }
    let(:unknown_id) { @category.id + 1000 }
    let(:negative_number) { -1 }
    let(:float_number) { 1.1 }

    subject { described_class.new(:name => nil, :category_id => nil) }

    it { is_expected.not_to allow_value(empty).for(:name) }
    it { is_expected.not_to allow_value(empty).for(:category_id) }
    it { is_expected.not_to allow_value('not a number').for(:category_id) }
    it { is_expected.not_to allow_value(negative_number).for(:category_id) }
    it { is_expected.not_to allow_value(float_number).for(:category_id) }
    it { is_expected.not_to allow_value(unknown_id).for(:category_id) }

    it { is_expected.to allow_value(@category.id).for(:category_id) }

    context 'when category_id is set' do
      before { subject.category_id = @category.id }

      it { is_expected.to allow_value(empty).for(:name) }
    end

    context 'when name is set' do
      before { subject.name = 'foo bar' }

      it { is_expected.to allow_value(empty).for(:category_id) }
    end
  end

  describe 'search' do
    before { @castles = create(:category) }
    before { @towers = create(:category) }

    before { @castle = create(:monument, :name => 'large castle', :category => @castles) }
    before { @tower = create(:monument, :name => 'large tower', :category => @towers) }

    def search(params)
      described_class.new(params).results
    end

    context 'when searched by category' do
      it 'returns monuments from given category' do
        expect(search(:category_id => @castles.id)).to eq [@castle]
        expect(search(:category_id => @towers.id)).to eq [@tower]
      end
    end

    context 'when searched by name' do
      it 'returns monuments with name matching ALL given words' do
        expect(search(:name => 'large castle')).to eq [@castle]
        expect(search(:name => 'large')).to match_array [@castle, @tower]
        expect(search(:name => 'tower')).to match_array [@tower]
        expect(search(:name => 'small tower')).to eq []
      end
    end

    context 'when searched by name and category' do
      it 'returns monuments from given category with name matching ALL given words' do
        expect(search(:name => 'large', :category_id => @castles.id)).to eq [@castle]
      end
    end

    context 'when search is invalid' do
      it { expect(search({})).to eq [] }
    end
  end
end