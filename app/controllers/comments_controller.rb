class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_comment, only: %i[show]

  def new
    @comment = Comment.new(post_id: params[:post_id].to_i)
  end

  def create
    @comment = Comment.new(comment_params)
    @comment.author = current_user
    respond_to do |format|
      if @comment.save
        format.html { redirect_to post_path(@comment.post), notice: 'Comment added successfully' }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.turbo_stream { render :form_update, status: :unprocessable_entity }
      end
    end
  end

  private

  def set_comment
    @post = Post.find(params[:id])
  end

  def comment_params
    params.require(:comment).permit(:post_id, :body)
  end
end
