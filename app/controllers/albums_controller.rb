
class AlbumsController < ApplicationController
  def index
    @albums = Album.all
  end

  def new
    album = Album.new
    # artistとsongの入力フォームを生成する
    album.build_artist
    album.songs.build
    @form = AlbumForm.new(album)
  end

  def create
    album = Album.new
    @form = AlbumForm.new(album)
    if @form.validate(album_params)
      @form.save
      redirect_to albums_path, notice: 'アルバムを作成しました'
    else
      render :new
    end
  end

  def edit
    @form = AlbumForm.new(Album.find(params[:id]))
  end

  def update
    @form = AlbumForm.new(Album.find(params[:id]))
    if @form.validate(album_params)
      @form.save
      redirect_to albums_path, notice: 'アルバムを更新しました'
    else
      render :edit
    end
  end

  def show
    @album = Album.find(params[:id])
  end

  def destroy
    Album.find(params[:id]).destroy
    redirect_to albums_path, notice: 'アルバムを削除しました'
  end

  private
  def album_params
    params.require(:album).permit(:album_title,
                                  artist_attributes: [:id, :full_name],
                                  songs_attributes: [:id, :title, :_destroy]
    )
  end

end
