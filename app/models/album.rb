class Album < ApplicationRecord
  has_one :artist, dependent: :destroy
  has_many :songs, dependent: :destroy
end
