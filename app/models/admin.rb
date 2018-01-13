class Admin < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

 validates :name, length: {maximum: 48}
 validates :name, presence: true
 validates :approved, inclusion: [true, false]

 def approved?
   approved
 end
end
