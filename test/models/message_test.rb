require "test_helper"

class MessageTest < ActiveSupport::TestCase
  test "should satisfy validation" do
    message = Message.new(content: "Hello")
    assert message.valid?
  end

  test "should not save message without content" do
    message = Message.new(content: nil)
    assert_not message.valid?
    assert_not message.save
  end
end
