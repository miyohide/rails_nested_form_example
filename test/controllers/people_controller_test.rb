require 'test_helper'

class PeopleControllerTest < ActionDispatch::IntegrationTest
  test "GET /people" do
    get "/people"
    assert_response(:success)
  end
end