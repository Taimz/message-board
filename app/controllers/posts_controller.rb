class PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_post, only: %i[show]

  def index
    @posts = Post.order(id: :desc).page(params[:page] || 1)
  end

  def show
    @comments = @post.comments.page(params[:page] || 1)
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.author = current_user
    respond_to do |format|
      if @post.save
        format.html { redirect_to post_path(@post), notice: 'Post created successfully' }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.turbo_stream { render :form_update, status: :unprocessable_entity }
      end
    end
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :body)
  end
end
