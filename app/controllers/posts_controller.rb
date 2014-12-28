class PostsController < ApplicationController
  def index
    @posts = Post.all
  end

  def show
    @post = Post.find(params[:post_id])
  end

  def new

  end

  def edit

  end

  def create

  end

  def update

  end

  def destroy

  end
end
