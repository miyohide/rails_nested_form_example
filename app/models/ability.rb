class Ability < ApplicationRecord
  AbilityList = %i(ability1 ability2 ability3)

  belongs_to :person
end
