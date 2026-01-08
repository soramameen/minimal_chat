require "test_helper"

class MessageTest < ActiveSupport::TestCase
  setup do
    @room = rooms(:one)
  end

  test "should satisfy validation" do
    message = Message.new(content: "Hello", room: @room)
    assert message.valid?
  end

  test "should not save message without content" do
    message = Message.new(content: nil, room: @room)
    assert_not message.valid?
    assert_not message.save
  end

  test "should not save message without room" do
    message = Message.new(content: "Hello", room: nil)
    assert_not message.valid?
  end
end
