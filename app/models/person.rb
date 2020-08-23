class Person < ApplicationRecord
  has_many :addresses, dependent: :destroy
  has_many :abilities, dependent: :destroy
  accepts_nested_attributes_for :addresses, allow_destroy: true, reject_if: :all_blank
  accepts_nested_attributes_for :abilities, allow_destroy: true, reject_if: :all_blank

  validates :first_name, presence: true
  validates :last_name, presence: true

  # personが持っている各Abilityのインスタンスに対して、以下のキーと値から成る
  # Hashをかえす
  #   キー : ability_nameをシンボル化したもの
  #   値 : Abilityのインスタンス
  # @return [Hash] キーはability_nameのシンボル、値はAbilityのインスタンス
  def ability_selections
    abilities.map do |record|
      [record.ability_name.to_sym, record]
    end.to_h
  end

  # データが存在しており、かつ削除対象となっていない（marked_for_destruction?がfalse）
  # である場合はtrueを、それ以外はfalseを返す。
  # @param ability_name [Symbol] 対象のability名
  # @return [Boolean] データが存在し、削除対象となっていない場合はtrue、それ以外はfalse
  def checked?(ability_name)
    ability_selection = ability_selections[ability_name.to_sym]
    ability_selection.present? && !ability_selection.marked_for_destruction?
  end
end
