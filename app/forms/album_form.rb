class AlbumForm < Reform::Form
  property :album_title

  property :artist do
    property :full_name
  end

  # collection :songs, populate_if_empty: Song do
  #   property :title
  # end
end
