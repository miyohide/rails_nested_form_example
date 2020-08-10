class Person < ApplicationRecord
  has_many :addresses, dependent: :destroy
  has_many :abilities, dependent: :destroy
  accepts_nested_attributes_for :addresses, allow_destroy: true, reject_if: :all_blank
  accepts_nested_attributes_for :abilities, allow_destroy: true, reject_if: :all_blank

  validates :first_name, presence: true
  validates :last_name, presence: true

  def ability_selections
    abilities.map do |record|
      [record.ability_name.to_sym, record]
    end.to_h
  end

  def checked?(ability)
    ability_selection = ability_selections[ability.to_sym]
    ability_selection.present? && !ability_selection.marked_for_destruction?
  end
end
