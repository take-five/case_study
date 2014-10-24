# This class parses user query "foo bar baz" and
# translates it to boolean query "foo & bar & baz"
#
# Example:
#   q = SearchQuery.new('foo, bar & baz')
#   q.to_s # => 'foo & bar & baz'
#
# A little bit naive, maybe it could be written as stream lexer.
class SearchQuery
  # Regexp to split input to words
  MATCH_WORDS = /[\p{Word}-]+/

  def initialize(input)
    @input = input.presence || ''
  end

  def valid?
    to_s.present?
  end

  def to_s
    @boolean ||= @input.scan(MATCH_WORDS).join(' & ')
  end
end