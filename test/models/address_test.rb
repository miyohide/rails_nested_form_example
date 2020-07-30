require 'test_helper'

class AddressTest < ActiveSupport::TestCase
  test "if kind is blank, validation is false" do
    person = Person.new(first_name: 'first', last_name: 'last')
    address = Address.new(kind: '', street: 'street', person: person)
    assert_not(address.valid?)
  end

  test "if street is blank, validation is false" do
    person = Person.new(first_name: 'first', last_name: 'last')
    address = Address.new(kind: 'kind', street: '', person: person)
    assert_not(address.valid?)
  end

  test "if person is nil, validation is false" do
    address = Address.new(kind: 'kind', street: '', person: nil)
    assert_not(address.valid?)
  end

  test "if all attributes are not blank or nil, validation is true" do
    person = Person.new(first_name: 'first', last_name: 'last')
    address = Address.new(kind: 'kind', street: 'street', person: person)
    assert(address.valid?)
  end
end
