class TracksController < ApplicationController
  def index
    @tracks = Track.all
  end

  def show
    @track = Track.find(params[:id])
  end

  def new
    @track = Track.new
  end

  def create
    @track = Track.new(track_params)
    @track.user = User.find_by(username: "Twhite")
    if @track.save
      redirect_to @track, notice: "Track Created!"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @track = Track.find(params[:id])
  end

  def update
    @track = Track.find(params[:id])
    @track.user = User.find_by(username: "Twhite")
    if @track.update(track_params)
      redirect_to @track, notice: "Track Updated"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @track = Track.find(params[:id])
    @track.destroy
    redirect_to dashboard_path, notice: "Track Deleted"
  end

  def track_params
    params.require(:track).permit(:title, :artist_id, :year, :bpm, :key, :notes)
  end
end
