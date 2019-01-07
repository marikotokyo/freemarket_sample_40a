class CommentsController < ApplicationController

  def create
    @comment = Comment.create(comment_params)
    redirect_to item_path(params[:item_id])
  end

  private
  def comment_params
    params.permit(:text, :item_id).merge(user_id: current_user.id)
  end

end
