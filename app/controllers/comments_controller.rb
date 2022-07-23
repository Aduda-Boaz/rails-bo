class CommentsController < ApplicationController
  def new
    @user = User.find(params[:user_id])
    @post = User.includes(:posts, :comments).find(params[:user_id]).post.find(params[:post_id])
    @comment = @post.recent_comments
  end

  def create
    parameters = comment_params
    puts parameters
    comment = Comment.new(post_id: params[:post_id], author_id: current_user_id, text: parameters[:text])
    comment.save
    if comment.save
      redirect_to user_post_path(id: params[:user_id], post_id: params[:post_id])
    else
      redirect_to new_user_post_path
    end
  end

  def comment_params
    params.require(:comment).permit(:text)
  end
end
