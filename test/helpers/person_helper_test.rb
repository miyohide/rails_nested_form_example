require 'test_helper'

class PersonHelperTest < ActionView::TestCase
  test "when call ability_name_prefix, return person + abilities_attributes string" do
    assert_equal("person[abilities_attributes][1]", ability_name_prefix(1))
  end

  test "when call ability_id_prefix, return person_abilities_attributes_index" do
    assert_equal("person_abilities_attributes_1", ability_id_prefix(1))
  end

  test "return hidden tag" do
    assert_equal(
        '<input type="hidden" id="person_abilities_attributes_1_id" name="person[abilities_attributes][1][id]">',
        ability_hidden_tag(1, nil))
  end

  test "return hidden tag with value" do
    mock = MiniTest::Mock.new.expect(:try, 1, [:id])
    actual = ability_hidden_tag(1, mock)
    assert_equal(
        '<input type="hidden" id="person_abilities_attributes_1_id" name="person[abilities_attributes][1][id]" value="1">',
        actual)
  end

  test "return check box tag with no checked" do
    person_mock = MiniTest::Mock.new.expect(:checked?, false, [:ability1])
    actual = ability_checkbox_tag(1, :ability1, person_mock)
    assert_equal(
        '<input type="checkbox" id="person_abilities_attributes_1_ability_name" name="person[abilities_attributes][1][ability_name]" value="ability1">',
        actual
    )
  end

  test "return check box tag with checked" do
    person_mock = MiniTest::Mock.new.expect(:checked?, true, [:ability1])
    actual = ability_checkbox_tag(1, :ability1, person_mock)
    assert_equal(
        '<input type="checkbox" id="person_abilities_attributes_1_ability_name" name="person[abilities_attributes][1][ability_name]" value="ability1" checked="checked">',
        actual
    )
  end

  test "return label and input form" do
    actual = ability_form(:ability1, 1)
    assert_equal(
        '<label class="form-check-label">ability1</label>',
        actual
    )
  end
end
