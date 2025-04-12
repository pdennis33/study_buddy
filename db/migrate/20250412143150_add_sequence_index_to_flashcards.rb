class AddSequenceIndexToFlashcards < ActiveRecord::Migration[7.1]
  def up
    add_column :flashcards, :sequence_index, :integer

    # Populate sequence_index
    Topic.find_each do |topic|
      topic.flashcards.order(:created_at).each_with_index do |flashcard, index|
        flashcard.update_columns(sequence_index: index + 1)
      end
    end

    change_column_null :flashcards, :sequence_index, false
    add_index :flashcards, [:topic_id, :sequence_index], unique: true
  end

  def down
    remove_index :flashcards, [:topic_id, :sequence_index]
    remove_column :flashcards, :sequence_index
  end
end
