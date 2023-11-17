class Challenge < ApplicationRecord
    validates :title, presence: true
    validates :description, presence: true

    has_many :challenge_categories
    has_many :categories, through: :challenge_categories
end
