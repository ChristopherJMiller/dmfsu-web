require 'ffaker'

FactoryGirl.define do
  factory :announcement do
    title FFaker::HipsterIpsum.words
    post FFaker::HipsterIpsum.paragraph
    admin
  end
end
