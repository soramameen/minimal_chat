require "test_helper"

class MessagesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @room = rooms(:one)
    @message = messages(:one)
    # Simulate a logged-in user
    post set_name_url, params: { user_name: "TestUser" }
  end

  test "should create message with html format" do
    assert_difference("Message.count") do
      post room_messages_url(@room), params: { message: { content: "New message content" } }
    end

    assert_redirected_to room_url(@room)
    assert_equal "TestUser", Message.last.user_name
  end

  test "should create message with turbo_stream format" do
    assert_difference("Message.count") do
      post room_messages_url(@room), params: { message: { content: "Turbo message" } }, as: :turbo_stream
    end

    assert_response :success
    assert_match /turbo-stream action="replace" target="new_message"/, response.body
    assert_equal "TestUser", Message.last.user_name
  end

  test "should get edit" do
    get edit_message_url(@message)
    assert_response :success
  end

  test "should update message" do
    patch message_url(@message), params: { message: { content: "Updated content" } }
    assert_redirected_to room_url(@message.room)
  end

  test "should destroy message" do
    assert_difference("Message.count", -1) do
      delete message_url(@message)
    end

    assert_redirected_to room_url(@message.room)
  end
end
