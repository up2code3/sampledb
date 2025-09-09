class DashboardController < ApplicationController
  def index
    @recent_tracks = Track.order(created_at: :desc).limit(5)
    @recent_comments = Comment.order(created_at: :desc).limit(5)
  end
end
