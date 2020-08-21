class Ability < ApplicationRecord
  AbilityNameList = %i(ability1 ability2 ability3)

  belongs_to :person
end
