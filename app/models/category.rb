class Category < ActiveRecord::Base
  has_many :monuments, dependent: :restrict_with_exception

  validates :name, presence: true, uniqueness: true

  # @api private
  def self.escape_search_query(query)
    query.gsub(/[%_]/) { |match| p "\\#{match}" }
  end

  scope :ordered, -> { order(:name) }
  scope :contains, -> (text) {
    if text.present?
      query = "%#{escape_search_query(text)}%"
      where(arel_table[:name].matches(query))
    else
      current_scope
    end
  }
end
