require 'test_helper'

class PersonHelperTest < ActionView::TestCase
  test "when call ability_name_prefix, return person + abilities_attributes string" do
    assert_equal("person[abilities_attributes][1]", ability_name_prefix(1))
  end
end
