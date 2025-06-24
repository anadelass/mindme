require "test_helper"

class AiChatMessagesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get ai_chat_messages_index_url
    assert_response :success
  end

  test "should get new" do
    get ai_chat_messages_new_url
    assert_response :success
  end

  test "should get create" do
    get ai_chat_messages_create_url
    assert_response :success
  end
end
