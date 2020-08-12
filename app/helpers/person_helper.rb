module PersonHelper
  def ability_name_prefix(index)
    "person[abilities_attributes][#{index}]"
  end

  def ability_hidden_tag(index, ability_selection)
    tag.hidden name: ability_name_prefix(index) + "[id]", value: ability_selection.try(:id)
  end
end