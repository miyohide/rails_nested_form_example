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

  test "PUT /people/:id" do
    p = FactoryBot.create(:person)
    assert_difference('Person.count', 0) do
      put "/people/#{p.id}", params: { person: { first_name: 'updated_f', last_name: 'updated_l' }}
    end
    assert_redirected_to person_path(p)
  end

  test "DELETE /people/:id" do
    p = FactoryBot.create(:person)
    assert_difference('Person.count', -1) do
      delete "/people/#{p.id}"
    end
    assert_redirected_to people_path
  end
end