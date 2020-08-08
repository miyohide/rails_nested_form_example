require 'test_helper'

class PeopleControllerTest < ActionDispatch::IntegrationTest
  def generate_param
    {
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
            },
            abilities_attributes: {
                '0' => {id: '', ability_name: 'ability1', _destroy: 'false'}
            }
        }
    }
  end

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
      post '/people', params: generate_param
    end
    assert_redirected_to person_path(Person.last)
  end

  test "POST /people with address data" do
    post '/people', params: generate_param
    addresses = Person.last.addresses
    # _destroyに'1'が入っているものは作られないため、addressesは2レコードのみ
    assert_equal(2, addresses.size)
    assert_equal('k1', addresses[0].kind)
    assert_equal('k2', addresses[1].kind)
  end

  test "PUT /people/:id" do
    p = FactoryBot.create(:person)
    assert_difference('Person.count', 0) do
      params = generate_param
      params[:person][:first_name] = 'updated_f'
      params[:person][:last_name] = 'updated_l'
      put "/people/#{p.id}", params: params
    end
    assert_redirected_to person_path(p)
  end

  test "PUT /people/:id with addresses params" do
    a = FactoryBot.create(:address)
    params = generate_param
    params[:person][:addresses_attributes]['0'] = { _destroy: '1', kind: 'd_k', street: 'd_s', id: a.id }
    params[:person][:addresses_attributes]['1'] = { _destroy: false , kind: 'k1', street: 's1' }
    params[:person][:addresses_attributes]['2'] = { _destroy: false , kind: 'k2', street: 's2' }
    put "/people/#{a.person.id}", params:  params
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