require 'test_helper'

class PersonTest < ActiveSupport::TestCase
  test "if first_name is blank, validation is false" do
    person = Person.new(first_name: '', last_name: 'last_name')
    assert_not(person.valid?)
  end

  test "if last_name is blank, validation is false" do
    person = Person.new(first_name: 'first', last_name: '')
    assert_not(person.valid?)
  end
end
