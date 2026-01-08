require "application_system_test_case"

class MessagesTest < ApplicationSystemTestCase
  test "visiting the index and logging in" do
    visit messages_url
    assert_selector "h1", text: "チャットルーム"

    fill_in "user_name", with: "SystemUser"
    click_on "チャットを始める"

    assert_text "ようこそ、SystemUser さん"
  end

  test "should create message" do
    visit messages_url

    fill_in "user_name", with: "Chatter"
    click_on "チャットを始める"

    fill_in "message_content", with: "Hello System Test"
    click_on "送信"

    assert_text "Hello System Test", wait: 5
  end
end
