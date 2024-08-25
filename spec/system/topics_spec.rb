require 'rails_helper'
require 'support/system_test_helper'

RSpec.describe "Topics", type: :system do
  let(:topic) { create(:topic) }

  it "visits the index" do
    visit topics_path
    expect(page).to have_selector "h1", text: "Topics"
  end

  it "creates a topic" do
    visit topics_path
    click_on "New topic"

    fill_in "Title", with: "New Topic Title"
    fill_in "Description", with: "A description for the new topic"
    click_on "Create Topic"

    expect(page).to have_text "Topic was successfully created"
    click_on "Back"
  end

  it "updates a topic" do
    visit topic_path(topic)
    click_on "Edit this topic", match: :first

    fill_in "Title", with: "Updated Topic Title"
    fill_in "Description", with: "An updated description for the topic"
    click_on "Update Topic"

    expect(page).to have_text "Topic was successfully updated"
    click_on "Back"
  end

  it "destroys a topic" do
    visit topic_path(topic)
    click_on "Destroy this topic", match: :first

    expect(page).to have_text "Topic was successfully destroyed"
  end
end
