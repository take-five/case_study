FactoryGirl.define do
  factory :picture do
    monument
    name 'Picture name'
    description 'Picture description'
    taken_at { Date.today }
    image { File.open(File.expand_path('../fixtures/picture.jpg', __dir__)) }
  end

end
