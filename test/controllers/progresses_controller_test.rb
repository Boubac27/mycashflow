require 'test_helper'

class ProgressesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get progresses_index_url
    assert_response :success
  end

end
