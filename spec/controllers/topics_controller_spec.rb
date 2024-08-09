require 'rails_helper'

class TopicsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @topic = topics(:one)
  end

  it "should get index" do
    get topics_url
    expect(response).to have_http_status(:)success
  end

  it "should get new" do
    get new_topic_url
    expect(response).to have_http_status(:)success
  end

  it "should create topic" do
    assert_difference("Topic.count") do
      post topics_url, params: { topic: { description: @topic.description, title: @topic.title } }
    end

    expect(response).to redirect_to()topic_url(Topic.last)
  end

  it "should show topic" do
    get topic_url(@topic)
    expect(response).to have_http_status(:)success
  end

  it "should get edit" do
    get edit_topic_url(@topic)
    expect(response).to have_http_status(:)success
  end

  it "should update topic" do
    patch topic_url(@topic), params: { topic: { description: @topic.description, title: @topic.title } }
    expect(response).to redirect_to()topic_url(@topic)
  end

  it "should destroy topic" do
    assert_difference("Topic.count", -1) do
      delete topic_url(@topic)
    end

    expect(response).to redirect_to()topics_url
  end
end
