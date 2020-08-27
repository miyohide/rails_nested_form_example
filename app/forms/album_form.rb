class AlbumForm < Reform::Form
  property :album_title
  validates :album_title, presence: true

  property :artist do
    property :full_name
    validates :full_name, presence: true
  end

  collection :songs, populate_if_empty: Song do
    property :title
  end
end
