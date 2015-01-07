class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update]

  def index
    @posts = Post.all
  end

  def show
    @comment = Comment.new
  end

  def new
    @post = Post.new
  end

  def edit
  end

  def create
    @post = Post.new(post_params)

    if @post.save
      flash[:notice] = "Your post was created."
      redirect_to posts_path
    else
      render 'new'
    end
  end

  def update
    if @post.update(post_params)
      flash[:notice] = "Your post was updated."
      redirect_to posts_path(@post)
    else
      render 'edit'
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :url, :description, :user_id)
  end

  def set_post
    @post = Post.find(params[:id])
  end
end
