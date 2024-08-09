class Flashcard < ApplicationRecord
  belongs_to :topic

  validates :question, :answer, presence: true
end
