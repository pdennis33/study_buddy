class Flashcard < ApplicationRecord
  belongs_to :topic

  validates :question, :answer, presence: true

  before_create :set_sequence_index

  private

  def set_sequence_index
    self.sequence_index = (topic.flashcards.maximum(:sequence_index) || 0) + 1
  end
end
