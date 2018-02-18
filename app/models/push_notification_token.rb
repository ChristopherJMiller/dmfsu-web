class PushNotificationToken < ApplicationRecord
  validates :token, presence: true
end
