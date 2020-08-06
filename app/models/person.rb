class Person < ApplicationRecord
  has_many :addresses, dependent: :destroy
  has_many :abilities, dependent: :destroy
  accepts_nested_attributes_for :addresses, allow_destroy: true, reject_if: :all_blank
  accepts_nested_attributes_for :abilities, allow_destroy: true, reject_if: :all_blank

  # after_initialize do
  #   # Personが未保存でかつabilitiesが存在しなかった場合はabilitiesを作成する
  #   abilities.build unless self.persisted? || abilities.present?
  # end

  validates :first_name, presence: true
  validates :last_name, presence: true

  def self.new_with_ability(params)
    person = self.new(first_name: params[:first_name], last_name: params[:last_name])
    params[:abilities].each do |ability|
      next if ability.empty?
      person.abilities << Ability.new(ability_name: ability)
    end
    person
  end
end
