class PostsController < ApplicationController
  def index
    @posts = Post.newest_first
  end

  def show
    @post = Post.find(params[:id])
  end
end
