require 'rails_helper'

RSpec.describe TopicsController, type: :request do
  let(:topic) { create(:topic) }

  it "should get index" do
    get topics_url
    expect(response).to have_http_status(:success)
  end

  it "should get new" do
    get new_topic_url
    expect(response).to have_http_status(:success)
  end

  it "should create topic" do
    topic
    expect {
      post topics_url, params: { topic: { description: topic.description, title: topic.title } }
    }.to change(Topic, :count).by(1)

    expect(response).to redirect_to(topic_url(Topic.last))
  end

  it "should show topic" do
    get topic_url(topic)
    expect(response).to have_http_status(:success)
  end

  it "should get edit" do
    get edit_topic_url(topic)
    expect(response).to have_http_status(:success)
  end

  it "should update topic" do
    patch topic_url(topic), params: { topic: { description: topic.description, title: topic.title } }
    expect(response).to redirect_to(topic_url(topic))
  end

  it "should destroy topic" do
    topic
    expect {
      delete topic_url(topic)
    }.to change(Topic, :count).by(-1)

    expect(response).to redirect_to(topics_url)
  end
end
