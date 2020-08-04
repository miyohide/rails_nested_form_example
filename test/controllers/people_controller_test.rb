require 'test_helper'

class PeopleControllerTest < ActionDispatch::IntegrationTest
  test "GET /people" do
    p = FactoryBot.create(:person)
    get "/people"
    assert_response(:success)
    assert_equal("/people", path)
    assert_match(p.first_name, @response.body)
    assert_match(p.last_name, @response.body)
  end
end