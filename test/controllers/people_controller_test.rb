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

  test "POST /people with address data" do
    post '/people', params: {
        person: {
            first_name: 'f', last_name: 'l',
            addresses_attributes: {
                '0' => {
                    _destroy: false, kind: 'k1', street: 's1'
                },
                '1' => {
                    _destroy: '1', kind: 'non-kind', street: 'non-street'
                },
                '2' => {
                    _destroy: false, kind: 'k2', street: 's2'
                }
            }
        }}
    addresses = Person.last.addresses
    # _destroyに'1'が入っているものは作られないため、addressesは2レコードのみ
    assert_equal(2, addresses.size)
    assert_equal('k1', addresses[0].kind)
    assert_equal('k2', addresses[1].kind)
  end

  test "PUT /people/:id" do
    p = FactoryBot.create(:person)
    assert_difference('Person.count', 0) do
      put "/people/#{p.id}", params: { person: { first_name: 'updated_f', last_name: 'updated_l' }}
    end
    assert_redirected_to person_path(p)
  end

  test "PUT /people/:id with addresses params" do
    a = FactoryBot.create(:address)
    put "/people/#{a.person.id}", params:  {
        person: {
            first_name: 'f', last_name: 'l',
            addresses_attributes: {
                '0' => {
                    _destroy: '1', kind: 'deleted_kind', street: 'deleted_street', id: a.id
                },
                '1' => {
                    _destroy: false , kind: 'k1', street: 's1'
                },
                '2' => {
                    _destroy: false, kind: 'k2', street: 's2'
                }
            }
        }}
    assert_nil(Address.find_by(id: a.id))
    assert_equal(2, Address.all.size)
  end

  test "DELETE /people/:id" do
    p = FactoryBot.create(:person)
    assert_difference('Person.count', -1) do
      delete "/people/#{p.id}"
    end
    assert_redirected_to people_path
  end
end