FactoryBot.define do
  factory :flashcard do
    question { "What is the capital of France?" }
    answer { "Paris" }
    hint { "It's known as the City of Light" }
    topic
  end
end
