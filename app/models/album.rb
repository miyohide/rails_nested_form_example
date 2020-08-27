class Album < ApplicationRecord
  has_one :artist
  has_many :songs
end
