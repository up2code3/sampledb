class DashboardController < ApplicationController
  before_action :require_login

  def index
    @recent_tracks = Track.order(created_at: :desc).limit(5)
    @recent_comments = Comment.order(created_at: :desc).limit(5)
  end

  private

  def require_login
    unless logged_in?
      flash[:alert] = "Please log in to access the dashboard"
      redirect_to login_path
    end
  end
end
