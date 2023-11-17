class ChallengeCategory < ApplicationRecord
  belongs_to :challenge
  belongs_to :category
end
