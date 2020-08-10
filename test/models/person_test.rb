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

  test "if all attributes are not blank, validation is true" do
    person = Person.new(first_name: 'first', last_name: 'last')
    assert(person.valid?)
  end

  test "if person is deleted, addresses are deleted" do
    person = Person.create(first_name: 'f', last_name: 'l')
    person.abilities.create(kind: 'k1', street: 's1')
    person.abilities.create(kind: 'k2', street: 's2')
    person.destroy
    assert_empty(person.addresses)
  end

  test "return hash includes key is ability name and value is record" do
    person = Person.create(first_name: 'f', last_name: 'l')
    ability1 = Ability.create(ability_name: 'a1', person: person)
    ability2 = Ability.create(ability_name: 'a2', person: person)
    assert_equal(
        {ability1.ability_name.to_sym => ability1,
         ability2.ability_name.to_sym => ability2}, person.ability_selections)
  end

  test "return true when has a record that ability_name is 'a1'" do
    ability_name = 'a1'
    person = Person.create(first_name: 'f', last_name: 'l')
    person.abilities.create(ability_name: ability_name)
    person.abilities.create(ability_name: 'a2')
    assert_equal(true, person.checked?(ability_name))
  end

  test "return false when has not a record that ability_name is 'a1' and 'a2'" do
    person = Person.create(first_name: 'f', last_name: 'l')
    person.abilities.create(ability_name: 'a1')
    person.abilities.create(ability_name: 'a2')
    assert_equal(false, person.checked?('a3'))
  end

  test "return false when has a record that ability_name is 'a1' and mark for destruction" do
    ability_name = 'a1'
    person = Person.create(first_name: 'f', last_name: 'l')
    person.abilities.create(ability_name: ability_name)
    person.abilities.create(ability_name: 'a2')
    # 一度レコードの内容を全部読み込ませる。DBからの読み込みが発生すると
    # mark_for_destructionが初期化されてしまう
    person.abilities.to_a
    person.abilities.first.mark_for_destruction
    assert_equal(false, person.checked?(ability_name))
  end
end
