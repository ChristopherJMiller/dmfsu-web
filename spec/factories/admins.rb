require 'ffaker'

FactoryGirl.define do
  factory :admin do
    name FFaker::Name.name
    email { FFaker::Internet.email }
    password 'password1234'
    password_confirmation 'password1234'
    approved true
  end
end
