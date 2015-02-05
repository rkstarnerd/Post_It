class CommentsController < ApplicationController
  before_action :require_user

  def create
    @post = Post.find_by(slug: params[:post_id])
    @comment = @post.comments.build(params.require(:comment).permit(:body))
    @comment.creator = current_user

    if @comment.save
      flash[:notice] = "Your comment was added."
      redirect_to post_path(@post)
    else
      render 'posts/show'
    end
  end

  def vote
    @comment = Comment.find(params[:id])
    @vote = Vote.create(voteable: @comment, creator: current_user, vote: params[:vote])

    if !@vote.valid?
      flash[:error] = "You've already voted on this comment"
    elsif @vote.vote == true
      flash[:notice] = "Voted up!"
    else
      flash[:notice] = "Voted down.."
    end

    respond_to do |format|
      format.html { redirect_to :back }
      format.js
    end
  end
end