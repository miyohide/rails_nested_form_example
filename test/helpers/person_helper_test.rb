require 'test_helper'

class PersonHelperTest < ActionView::TestCase
  test "when call ability_name_prefix, return person + abilities_attributes string" do
    assert_equal("person[abilities_attributes][1]", ability_name_prefix(1))
  end

  test "return hidden tag" do
    assert_equal('<hidden name="person[abilities_attributes][1]"></hidden>', ability_hidden_tag(1, nil))
  end

  test "return hidden tag with value" do
    mock = MiniTest::Mock.new.expect(:try, 1, [:id])
    actual = ability_hidden_tag(1, mock)
    assert_equal('<hidden name="person[abilities_attributes][1]" value="1"></hidden>', actual)
  end
end
