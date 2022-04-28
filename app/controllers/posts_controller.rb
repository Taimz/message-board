class PostsController < ApplicationController
  def index
    @posts = Post.order(id: :desc).all
  end
end
