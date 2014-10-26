module Support
  module Helpers
    # Returns fd referring to opened fixture file
    def fixture(name)
      Rails.root.join('spec', 'fixtures', name).open
    end
  end
end