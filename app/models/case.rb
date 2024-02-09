class Case < ApplicationRecord
  validates :input, presence: true
  validates :output, presence: true
  belongs_to :challenge
end
