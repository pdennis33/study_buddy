json.extract! flashcard, :id, :question, :answer, :hint, :topic_id, :created_at, :updated_at
json.url flashcard_url(flashcard, format: :json)
