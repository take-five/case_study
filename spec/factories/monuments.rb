FactoryGirl.define do
  factory :monument do
    collection
    category
    name 'Monument'
    description 'Monument description'

    after(:create) do |monument, evaluator|
      create :picture, monument: monument
    end
  end
end
