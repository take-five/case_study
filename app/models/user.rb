class User < ActiveRecord::Base
  # Included devise modules
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :collections, dependent: :destroy

  validates :username, presence: true, uniqueness: true

  # declarative_authorization requires user object to respond to #role_symbols
  def role_symbols
    [:user]
  end
end
