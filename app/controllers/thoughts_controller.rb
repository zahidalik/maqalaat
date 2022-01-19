class ThoughtsController < ApplicationController
  before_action :user_constraints, only: [:new, :create, :edit, :update, :destroy]
  before_action :set_thought, only: [:show, :edit, :update, :destroy]
  before_action :logged_in_user, only: [:show]

  def index
    @thoughts = Thought.all.order(created_at: :desc)
  end

  def search
    if params.dig(:title_search).present?
      @thoughts = Thought.where('title ILIKE ?', "%#{params[:title_search]}%").order(created_at: :desc)
    else
      @thoughts = []
    end
    
    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: [
          turbo_stream.update("search_results",
          partial: "thoughts/search_results",
          locals: { thoughts: @thoughts })
        ]
      end
    end
  end

  def show
    @thought_comments = @thought.comments
  end

  def edit
    @user = User.friendly.find(params[:user_id])
  end

  def update
    @user = User.friendly.find(params[:user_id])
    if @thought.update(thought_params)
      flash[:notice] = "Edited successfully"
      redirect_to user_path(@user)
    else
      flash.now[:alert] = "Something went wrong"
      render :edit, status: :bad_request
    end
  end

  def new
    @user = User.friendly.find(params[:user_id])
    @thought = @user.thoughts.build
  end

  def create
    @user = User.friendly.find(params[:user_id])
    @thought = @user.thoughts.build(thought_params)
    if @thought.save
      respond_to do |format|
        format.turbo_stream
        format.html { redirect_to user_url(@user), notice: "Thought added successfully" }
      end
    else
      flash.now[:alert] = "Try again"
      render :new, status: :bad_request
    end
  end

  def destroy
    if @thought.delete
      respond_to do |format|
        format.turbo_stream
        format.html { redirect_to user_url(@thought.user), notice: "Thought deleted successfully" }
      end
    end
  end

  private

  def set_thought
    @thought = Thought.friendly.find(params[:id]) 
  end

  def thought_params
    params.require(:thought).permit(:related_to, :title, :content)
  end
end