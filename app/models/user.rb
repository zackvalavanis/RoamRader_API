class User < ApplicationRecord
  has_many :places
  has_many :homes, through: :places
end
