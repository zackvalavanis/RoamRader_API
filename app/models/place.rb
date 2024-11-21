class Place < ApplicationRecord
  belongs_to :user
  belongs_to :home
end
