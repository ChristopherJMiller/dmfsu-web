class Event < ApplicationRecord
  validates :title, presence: true

  validates :description, presence: true
  validates :description, length: {maximum: 2048}

  validates :location, presence: true
  validates :location, length: {maximum: 256}

  validates :start_time, presence: true

  validates :end_time, presence: true
end
