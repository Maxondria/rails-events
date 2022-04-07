class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:email])

    if user&.authenticate(params[:password])
      session[:user_id] = user.id

      # previous_url gets set during the require_signin before_action in users_controller.rb
      previous_url = session[:previous_url]

      if previous_url
        session[:previous_url] = nil
        redirect_to previous_url, notice: "Welcome back, #{user.name}!"
      else
        redirect_to user, notice: "Welcome back, #{user.name}!"
      end
    else
      flash.now[:alert] = "Invalid email/password combination!"
      render :new
    end
  end

  def destroy
    session[:user_id] = nil

    redirect_to signin_path, notice: "You've been signed out!"
  end
end
