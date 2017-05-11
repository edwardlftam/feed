FactoryGirl.define do
  factory :article do
    author 'Author'
    title 'Title'
    subtitle 'Subtitle'
    content 'content'

    feed
  end
end