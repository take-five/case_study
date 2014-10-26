class Monument < ActiveRecord::Base
  belongs_to :collection
  belongs_to :category

  has_many :pictures, dependent: :destroy
  accepts_nested_attributes_for :pictures, reject_if: :all_blank, allow_destroy: true

  validates :name, presence: true

  validates :collection, existence: { allow_new: true }

  validates :category, existence: { allow_new: true }

  scope :with_category, ->(category) { where(category_id: category) }

  # This scope expects valid TSQUERY (could be parsed and checked via SearchQuery)
  # Otherwise postgresql may produce syntax error.
  #
  # This method is not intended to be called directly from controller!
  scope :search, ->(tsquery) {
    where("to_tsvector(name) @@ to_tsquery(#{connection.quote(tsquery.to_s)})")
  }
end
