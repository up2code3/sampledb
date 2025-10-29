class SessionsController < ApplicationController
  def new
    # renders the login form
  end

  def create
    user = User.find_by(username: params[:username])

    if user&.authenticate(params[:password])
      session[:user_id] = user.id
      session[:role] = user.role
      redirect_to dashboard_path, notice: "Logged in as #{user.username}"
    else
      flash.now[:alert] = "Invalid username or password"
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    reset_session
    redirect_to root_path, notice: "Logged out"
  end
end
