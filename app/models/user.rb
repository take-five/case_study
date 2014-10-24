class User < ActiveRecord::Base
  # Included devise modules
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :collections, :dependent => :destroy

  validates :username, :presence => true, :uniqueness => true

  # A way to generate URLs like /users/alex/collections
  def to_param
    username
  end
end
