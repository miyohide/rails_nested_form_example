module PersonHelper
  # Personモデルと1対多の関係にあるAbilityモデルに対してaccepts_nested_attributes_forとして
  # 指定した際に生成されるname属性の文字列を返す。
  # @param [String] index 対象のAbilityモデルのインスタンスの番号
  # @return [String] "person[abilities_attributes][" + index + "]"
  def ability_name_prefix(index)
    "person[abilities_attributes][#{index}]"
  end

  # Personモデルと1対多の関係にあるAbilityモデルに対してaccepts_nested_attributes_forとして
  # 指定した際に生成されるid属性の文字列を返す。
  # @param [String] index 対象のAbilityモデルのインスタンスの番号
  # @return [String] "person_abilities_attributes_" + index
  def ability_id_prefix(index)
    "person_abilities_attributes_#{index}"
  end

  def ability_hidden_tag(index, ability_selection)
    tag.input type: 'hidden',
              id: "#{ability_id_prefix(index)}_id",
              name: "#{ability_name_prefix(index)}[id]",
              value: ability_selection.try(:id)
  end

  def ability_checkbox_tag(index, ability_name, person)
    tag.input type: 'checkbox',
              id: "#{ability_id_prefix(index)}_ability_name",
              name: "#{ability_name_prefix(index)}[ability_name]",
              value: ability_name,
              checked: person.checked?(ability_name)
  end

  def ability_form(ability_name, index, person)
    tag.label class: 'form-check-label' do
      ability_hidden_tag(index, person.ability_selections[ability_name]) + ability_checkbox_tag(index, ability_name, person)+ "#{ability_name}"
    end
  end
end