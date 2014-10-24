class MonumentsSearch
  include ActiveModel::Validations

  attr_accessor :name, :category_id

  # mutually exclusive validations
  validates :name,
            :presence => true,
            :unless => 'category_id.present?'

  validates :category_id,
            :presence => true,
            :numericality => { only_integer: true, greater_than: 0 },
            :unless => 'name.present?'

  validate :validate_category, :if => 'category_id.present?'

  def initialize(params)
    @name, @category_id = params.values_at(:name, :category_id).map(&:presence)
  end

  def search
    if valid?
      search_by_name search_by_category all
    end
  end

  protected
  def all
    Monument.includes(:collection => :user)
  end

  def search_by_category(scope)
    if category.present?
      scope.with_category(category)
    else
      scope
    end
  end

  def search_by_name(scope)
    if search_query.valid?
      scope.search(search_query)
    else
      scope
    end
  end

  private
  def search_query
    @search_query ||= SearchQuery.new(name)
  end

  def category
    defined?(@category) && category_id ?
        @category :
        @category = Category.find_by_id(category_id)
  end

  def validate_category
    errors.add(:category_id, :invalid) unless category.present?
  end
end