class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:email])

    if user&.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to (session[:previous_url] || user), notice: "Welcome back, #{user.name}!"
      session[:previous_url] = nil
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
