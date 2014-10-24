FactoryGirl.define do
  factory :user do
    sequence(:email) { |n| "example_#{n}@example.com" }
    sequence(:username) { |n| "user #{n}" }
    password 'a_password'
    password_confirmation { password }
  end
end
