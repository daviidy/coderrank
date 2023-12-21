class Comment < ApplicationRecord
  validates :text, presence: true
  belongs_to :challenge
  belongs_to :user
end
