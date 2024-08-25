require 'rails_helper'
require 'support/system_test_helper'

RSpec.describe "Flashcards", type: :system do
  let(:topic) { create(:topic) }
  let(:flashcard) { create(:flashcard, topic: topic) }

  it "visits the index" do
    visit topic_flashcards_path(topic)
    expect(page).to have_selector "h1", text: "Flashcards"
  end

  it "creates a flashcard" do
    visit topic_flashcards_path(topic)

    fill_in "Question", with: flashcard.question
    fill_in "Answer", with: flashcard.answer
    fill_in "Hint", with: flashcard.hint
    click_on "Create Flashcard"

    expect(page).to have_text "Flashcard was successfully created"
  end

  it "updates a flashcard" do
    flashcard
    visit topic_flashcards_path(topic)
    click_on "Edit this flashcard", match: :first

    fill_in "Question", with: flashcard.question
    fill_in "Answer", with: flashcard.answer
    fill_in "Hint", with: flashcard.hint
    click_on "Update Flashcard"

    expect(page).to have_text "Flashcard was successfully updated"
  end

  it "destroys a flashcard" do
    visit topic_flashcard_path(topic, flashcard)
    click_on "Destroy this flashcard", match: :first

    expect(page).to have_text "Flashcard was successfully destroyed"
  end
end
