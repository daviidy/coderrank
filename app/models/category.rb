class Category < ApplicationRecord
    validates :title, presence: true
    validates :description, allow_blank: true

    has_many :challenge_categories
    has_many :challenges, through: :challenge_categories
end
