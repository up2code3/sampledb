class ArtistsController < ApplicationController
  def index
    @artists = Artist.alphabetical
  end

  def show
    @artist = Artist.find(params[:id])
  end

  def new
    @artist = Artist.new
  end

  def create
    @artist = Artist.new(artist_params)
    if @artist.save
      redirect_to new_track_path(artist_id: @artist.id), notice: "Artist Created"
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

    def artist_params
      params.require(:artist).permit(:name)
    end
end
