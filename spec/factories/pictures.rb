FactoryGirl.define do
  factory :monument do
    collection
    category
    picture { File.open(File.expand_path('../fixtures/picture.jpg', __dir__)) }
    name 'Monument'
    description 'Monument description'
  end

end
