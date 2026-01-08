require "application_system_test_case"

class RoomsTest < ApplicationSystemTestCase
  setup do
    # Assuming we handle user name in session or via a form if not present
  end

  test "visiting the index" do
    visit root_url
    assert_selector "h1", text: "チャットルーム一覧"
  end

  test "creating a new room" do
    visit root_url

    # Enter user name if required (the current app requires it)
    fill_in "user_name", with: "Test User"
    click_on "チャットを始める"

    fill_in "room[name]", with: "New Room"
    click_on "部屋を作る"

    assert_text "New Room"
  end

  test "chatting in a room" do
    room = Room.create!(name: "Chat Room")

    visit root_url
    fill_in "user_name", with: "Alice"
    click_on "チャットを始める"

    click_on "Chat Room"

    fill_in "message_content", with: "Hello World"
    # Wait for the button to be clickable or form submission
    click_on "送信"

    assert_text "Hello World"
  end
end
