class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      log_in(user)
      flash[:notice] = "Successfully signed in"
      redirect_to user
    else
      flash.now[:alert] = "Invalid email/password combination"
      render :new, status: :bad_request
    end
  end
  
  def destroy
    log_out
    redirect_to root_url
  end
end