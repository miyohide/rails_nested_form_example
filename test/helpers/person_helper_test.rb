require 'test_helper'

class PersonHelperTest < ActionView::TestCase
  test "ability_name_prefixを呼び出したとき、person[abilities_attributes][番号]を返すこと" do
    assert_equal("person[abilities_attributes][1]", ability_name_prefix(1))
  end

  test "ability_id_prefixを呼び出したとき, person_abilities_attributes_番号を返すこと" do
    assert_equal("person_abilities_attributes_1", ability_id_prefix(1))
  end

  test "ability_hidden_tagを呼び出したとき、hiddenタグを生成すること" do
    person = Person.create(first_name: 'f', last_name: 'l')
    assert_equal(
        '<input type="hidden" id="person_abilities_attributes_1_id" name="person[abilities_attributes][1][id]">',
        ability_hidden_tag(1, :ability1, person))
  end

  test "対象のability_nameを持つAbilityと紐付けられたpersonが存在するとき、value付きでhiddenタグが生成されること" do
    ability_name = :ability1
    person = Person.create(first_name: 'f', last_name: 'l')
    ability = Ability.create(ability_name: ability_name)
    person.abilities << ability
    actual = ability_hidden_tag(1, ability_name, person)
    assert_equal(
        "<input type=\"hidden\" id=\"person_abilities_attributes_1_id\" name=\"person[abilities_attributes][1][id]\" value=\"#{ability.id}\">",
        actual)
  end

  test "checked?がfalseを返すとき、ability_checkbox_tagはチェック無しのchexboxタグを返すこと" do
    person_mock = MiniTest::Mock.new.expect(:checked?, false, [:ability1])
    actual = ability_checkbox_tag(1, :ability1, person_mock)
    assert_equal(
        '<input type="checkbox" id="person_abilities_attributes_1_ability_name" name="person[abilities_attributes][1][ability_name]" value="ability1">',
        actual
    )
  end

  test "checked?がtrueを返すとき、ability_checkbox_tagはチェックありのchexboxタグを返すこと" do
    person_mock = MiniTest::Mock.new.expect(:checked?, true, [:ability1])
    actual = ability_checkbox_tag(1, :ability1, person_mock)
    assert_equal(
        '<input type="checkbox" id="person_abilities_attributes_1_ability_name" name="person[abilities_attributes][1][ability_name]" value="ability1" checked="checked">',
        actual
    )
  end

  test "ability_formを呼び出したとき、abilityを登録するためのフォームを生成すること" do
    form_id = 1
    ability_name = :ability1
    person = Person.create(first_name: 'f', last_name: 'l')
    ability = Ability.create(ability_name: ability_name)
    person.abilities << ability
    actual = ability_form(form_id, ability_name, person)
    assert_equal(
        "<label class=\"form-check-label\">" +
            "<input type=\"hidden\" id=\"person_abilities_attributes_#{form_id}_id\" name=\"person[abilities_attributes][#{form_id}][id]\" value=\"#{ability.id}\">" +
            "<input type=\"checkbox\" id=\"person_abilities_attributes_#{form_id}_ability_name\" name=\"person[abilities_attributes][#{form_id}][ability_name]\" value=\"ability1\" checked=\"checked\">" +
            "#{ability_name}</label>",
        actual
    )
  end
end
