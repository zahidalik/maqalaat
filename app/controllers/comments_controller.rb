class CommentsController < ApplicationController
  before_action :user_should_be_logged_in

  def new
    @thought = Thought.friendly.find(params[:thought_id])
    @comment = @thought.comments.build
  end
  
  def create
    @thought = Thought.friendly.find(params[:thought_id])
    @comment = @thought.comments.build(comment_params)
    @comment.commented_by = current_user.name

    if @comment.save
      respond_to do |format|
        format.turbo_stream
        format.html { redirect_to thought_url(@thought), notice: "Successfully commented"}
      end
    else
      flash.now[:alert] = "Something went wrong"
      render :new, status: :bad_request
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:content, :thought_id)
  end

  def user_should_be_logged_in
    unless logged_in?
      flash[:alert] = "Action Prohibited!"
      redirect_to root_url
    end
  end
end