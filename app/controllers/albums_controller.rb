
class AlbumsController < ApplicationController
  def index
    @albums = Album.all
  end

  def new
    album = Album.new
    album.build_artist
    @form = AlbumForm.new(album)
  end
end
