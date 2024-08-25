require 'rails_helper'

RSpec.describe FlashcardsController, type: :request do
  let(:topic) { create(:topic) }
  let(:flashcard) { create(:flashcard, topic: topic) }

  it "should get index" do
    get topic_flashcards_url(topic)
    expect(response).to have_http_status(:success)
  end

  it "should get new" do
    get new_topic_flashcard_url(topic)
    expect(response).to have_http_status(:success)
  end

  it "should create flashcard" do
    flashcard
    expect {
      post topic_flashcards_url(topic), params: { flashcard: { answer: flashcard.answer, hint: flashcard.hint, question: flashcard.question, topic_id: topic.id } }
    }.to change(Flashcard, :count).by(1)

    expect(response).to redirect_to(topic_flashcards_url(topic))
  end

  it "should show flashcard" do
    get topic_flashcard_url(topic, flashcard)
    expect(response).to have_http_status(:success)
  end

  it "should get edit" do
    get edit_topic_flashcard_url(topic, flashcard)
    expect(response).to have_http_status(:success)
  end

  it "should update flashcard" do
    patch topic_flashcard_url(topic, flashcard), params: { flashcard: { answer: flashcard.answer, hint: flashcard.hint, question: flashcard.question, topic_id: topic.id } }
    expect(response).to redirect_to(topic_flashcards_url(topic))
  end

  it "should destroy flashcard" do
    flashcard
    expect {
      delete topic_flashcard_url(topic, flashcard)
    }.to change(Flashcard, :count).by(-1)

    expect(response).to redirect_to(topic_flashcards_url(topic))
  end

  context "with invalid params" do
    it "does not create a flashcard" do
      expect {
        post topic_flashcards_url(topic), params: { flashcard: { answer: nil, hint: nil, question: nil, topic_id: nil } }
      }.to change(Flashcard, :count).by(0)

      expect(response).to have_http_status(:unprocessable_entity)
    end

    it "does not update the flashcard" do
      patch topic_flashcard_url(topic, flashcard), params: { flashcard: { answer: nil, hint: nil, question: nil, topic_id: nil } }
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end
end
