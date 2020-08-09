module PersonHelper
  def ability_name_prefix(index)
    "person[abilities_attributes][#{index}]"
  end
end