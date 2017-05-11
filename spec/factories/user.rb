FactoryGirl.define do
  factory :user do
    first_name 'First'
    last_name 'Last'
    sequence :email do |index|
      "test#{index}@test.com"
    end
    password '12345678'
    password_confirmation '12345678'
  end
end