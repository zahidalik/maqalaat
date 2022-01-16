class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update]
  before_action :authenticate_user!, only: [:edit, :update]

  def index
    @users = User.all
  end

  def show
    @user_thoughts = @user.thoughts.order(:created_at)
  end

  def edit
  end

  def update
    if @user.update(user_params)
      flash[:notice] = "Edited successfully"
      redirect_to user_path(@user)
    else
      flash.now[:alert] = "Something went wrong"
      render :edit, status: :bad_request
    end
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in(@user)
      respond_to do |format|
        format.html { redirect_to @user, notice: "Registration done successfully!" }
      end
    else
      flash.now[:alert] = "Registration failed!"
      render :new, status: :bad_request
    end
  end

  private

  def set_user
    @user = User.friendly.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :email, :nationality, :qualifications, :avatar, :password, :password_confirmation)
  end
end
