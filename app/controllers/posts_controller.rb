class PostsController < ApplicationController
  before_action :set_post, only: %i[show]

  def index
    @posts = Post.order(id: :desc).all
  end

  def show; end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.author = current_user
    if @post.save
      redirect_to post_path(@post), notice: 'Post created successfully'
    else
      render :new
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
