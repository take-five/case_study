require 'rails_helper'

RSpec.describe SearchQuery do
  def query(input)
    described_class.new(input)
  end

  def to_boolean(input)
    query(input).to_s
  end

  it { expect(query(nil)).not_to be_valid }
  it { expect(query(' ')).not_to be_valid }
  it { expect(query(' ? ')).not_to be_valid }
  it { expect(query(' & ')).not_to be_valid }
  it { expect(query('word')).to be_valid }

  it { expect(to_boolean(nil)).to eq '' }
  it { expect(to_boolean('foo')).to eq 'foo' }
  it { expect(to_boolean('foo & bar')).to eq 'foo & bar' }
  it { expect(to_boolean('foo, bar&baz')).to eq 'foo & bar & baz' }
  it { expect(to_boolean('foo-bar, baz?')).to eq 'foo-bar & baz' }
end