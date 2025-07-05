require "test_helper"

class PsychologistMessagesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get psychologist_messages_index_url
    assert_response :success
  end

  test "should get create" do
    get psychologist_messages_create_url
    assert_response :success
  end
end
