FactoryGirl.define do
  factory :feed do
    sequence :name do |index|
      "Test Feed #{index}"
    end
  end
end