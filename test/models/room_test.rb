require "test_helper"

class RoomTest < ActiveSupport::TestCase
  test "should be valid with a name" do
    room = Room.new(name: "General")
    assert room.valid?
  end

  test "should be invalid without a name" do
    room = Room.new(name: nil)
    assert_not room.valid?
  end
end
