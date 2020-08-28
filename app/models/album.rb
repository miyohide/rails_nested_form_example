class Album < ApplicationRecord
  has_one :artist
  has_many :songs

  accepts_nested_attributes_for :artist
  accepts_nested_attributes_for :songs
end