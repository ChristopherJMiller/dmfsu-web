class Announcement < ApplicationRecord
  belongs_to :admin

  validates :title, presence: true
  validates :title, length: {maximum: 64}
  validates :post, presence: true
  validates :post, length: {maximum: 5120}
  validates :admin, presence: true
end
