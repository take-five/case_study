class Collection < ActiveRecord::Base
  belongs_to :user

  has_many :monuments, :dependent => :destroy

  validates :name, :presence => true
end
