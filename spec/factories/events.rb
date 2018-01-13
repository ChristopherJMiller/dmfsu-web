require 'ffaker'

FactoryGirl.define do
  factory :event do
    title FFaker::HipsterIpsum.words
    description FFaker::HipsterIpsum.paragraph
    location FFaker::Address.street_address
    start_time FFaker::Time.datetime
    end_time FFaker::Time.datetime
  end
end
