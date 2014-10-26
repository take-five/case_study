class Collection < ActiveRecord::Base
  belongs_to :user

  has_many :monuments, :dependent => :destroy

  validates :user, existence: { allow_new: true }
  validates :name, presence: true
end
