class Home < ApplicationRecord
  has_many :places
  has_many :users, through: :places
end
