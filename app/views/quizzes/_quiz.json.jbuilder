json.extract! quiz, :id, :question, :answer, :hint, :topic_id, :created_at, :updated_at
json.url quiz_url(quiz, format: :json)
