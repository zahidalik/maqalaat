module SessionsHelper
  def log_in(user)
    session[:user_id] = user.id
  end

  def current_user  
    @current_user ||= User.find_by(id: session[:user_id])
  end

  def logged_in?
    !current_user.nil?
  end

  def log_out
    session.delete(:user_id)
    @current_user = nil
  end

  def authenticate_user!
    unless logged_in? && current_user == @user
      flash[:alert] = "Prohibited action"
      redirect_to root_url
    end
  end

  def user_constraints
    user = User.friendly.find(params[:user_id])
    unless logged_in? && current_user == user
      flash[:alert] = "Prohibited action"
      redirect_to root_url
    end
  end
end
