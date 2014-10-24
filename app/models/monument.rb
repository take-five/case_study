class Monument < ActiveRecord::Base
  belongs_to :collection
  belongs_to :category

  mount_uploader :picture, PictureUploader

  validates :name, presence: true
  validates :picture,
            presence: true,
            file_size: { maximum: 4.megabytes },
            integrity: true,
            processing: true
  validates :collection, existence: true
  validates :category, existence: true

  scope :with_category, ->(category) { where(:category_id => category) }
  # This scope expects valid TSQUERY (could be parsed and checked via SearchQuery)
  scope :search, ->(tsquery) {
    where("to_tsvector(name) @@ to_tsquery(#{connection.quote(tsquery.to_s)})")
  }
end
