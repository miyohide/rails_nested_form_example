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
end