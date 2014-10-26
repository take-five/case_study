class Category < ActiveRecord::Base
  has_many :monuments, dependent: :restrict_with_exception

  validates :name, presence: true, uniqueness: true

  scope :ordered, -> { order(:name) }
end
