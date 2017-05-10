FactoryGirl.define do
  factory :user do
    first_name 'First'
    last_name 'Last'
    email 'test@test.com'
    password '12345678'
    password_confirmation '12345678'
  end
end