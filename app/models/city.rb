class City < ApplicationRecord
  has_many :comments
  belongs_to :user
end
