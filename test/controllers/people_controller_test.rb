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

  test "POST /people" do
    assert_difference('Person.count', 1) do
      post '/people', params: { person: { first_name: 'f', last_name: 'l' }}
    end
    assert_redirected_to person_path(Person.last)
  end
end