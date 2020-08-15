module PersonHelper
  def ability_name_prefix(index)
    "person[abilities_attributes][#{index}]"
  end

  def ability_id_prefix(index)
    "person_abilities_attributes_#{index}"
  end

  def ability_hidden_tag(index, ability_selection)
    tag.input type: 'hidden',
              id: "#{ability_id_prefix(index)}_id",
              name: "#{ability_name_prefix(index)}[id]",
              value: ability_selection.try(:id)
  end

  def ability_checkbox_tag(index, ability, person)
    tag.input type: 'checkbox',
              id: "#{ability_id_prefix(index)}_ability_name",
              name: "#{ability_name_prefix(index)}[ability_name]",
              value: ability,
              checked: person.checked?(ability)
  end
end