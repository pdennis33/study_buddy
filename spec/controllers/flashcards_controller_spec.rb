require 'rails_helper'

class FlashcardsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @flashcard = flashcards(:one)
  end

  it "should get index" do
    get flashcards_url
    expect(response).to have_http_status(:)success
  end

  it "should get new" do
    get new_flashcard_url
    expect(response).to have_http_status(:)success
  end

  it "should create flashcard" do
    assert_difference("Flashcard.count") do
      post flashcards_url, params: { flashcard: { answer: @flashcard.answer, hint: @flashcard.hint, question: @flashcard.question, topic_id: @flashcard.topic_id } }
    end

    expect(response).to redirect_to()flashcard_url(Flashcard.last)
  end

  it "should show flashcard" do
    get flashcard_url(@flashcard)
    expect(response).to have_http_status(:)success
  end

  it "should get edit" do
    get edit_flashcard_url(@flashcard)
    expect(response).to have_http_status(:)success
  end

  it "should update flashcard" do
    patch flashcard_url(@flashcard), params: { flashcard: { answer: @flashcard.answer, hint: @flashcard.hint, question: @flashcard.question, topic_id: @flashcard.topic_id } }
    expect(response).to redirect_to()flashcard_url(@flashcard)
  end

  it "should destroy flashcard" do
    assert_difference("Flashcard.count", -1) do
      delete flashcard_url(@flashcard)
    end

    expect(response).to redirect_to()flashcards_url
  end
end
