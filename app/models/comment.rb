class Comment < ApplicationRecord
  belongs_to :city
  belongs_to :user
end
