class User < ApplicationRecord
  has_many :cities
  has_secure_password
  has_many :comments
  validates :email, presence: true, uniqueness: true

end
