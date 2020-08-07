class Person < ApplicationRecord
  has_many :addresses, dependent: :destroy
  has_many :abilities, dependent: :destroy
  accepts_nested_attributes_for :addresses, allow_destroy: true, reject_if: :all_blank
  accepts_nested_attributes_for :abilities, allow_destroy: true, reject_if: :all_blank

  validates :first_name, presence: true
  validates :last_name, presence: true
end
