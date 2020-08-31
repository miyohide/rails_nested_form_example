class AlbumForm < Reform::Form
  property :album_title
  validates :album_title, presence: true

  # populate_if_empty は対象のproperty/collectionが存在しないときに生成する
  # この記述がなく、validateメソッドを実行すると
  # RuntimeError ([Reform] Your :populator did not return a Reform::Form instance for `artist`.)
  # というエラーが発生する
  # see. http://trailblazer.to/2.1/docs/reform.html#reform-populators-populate_if_empty
  property :artist, populate_if_empty: Artist do
    property :full_name
    validates :full_name, presence: true
  end

  SongPrepopulator = -> (options) {
    if songs.size == 0
      songs << Song.new
    end
  }

  SongPopulator = -> (options) {
    fragment, collection, index = options[:fragment], options[:model], options[:index]

    if fragment[:id].to_s == ""
      item = nil
    else
      item = collection.find { |item| item.id.to_s == fragment[:id].to_s }
    end

    if fragment["_destroy"] == "1"
      collection.delete_at(index)
      return skip!
    else
      item ? item : collection.append(Song.new)
    end
  }

  collection :songs, prepopulator: SongPrepopulator, populator: SongPopulator do
    include NestedForm

    property :title
    validates :title, presence: true
  end
end
