require 'test_helper'

class AddressTest < ActiveSupport::TestCase
  test "if kind is blank, validation is false" do
    address = Address.new(kind: '', street: 'street')
    assert_not(address.valid?)
  end

  test "if street is blank, validation is false" do
    address = Address.new(kind: 'kind', street: '')
    assert_not(address.valid?)
  end
end
