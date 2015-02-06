class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update]
  def index

  end

  def show

  end

  def new
    @user = User.new
  end

  def edit

  end

  def create
    @user = User.new(user_params)

    if @user.save
      session[:user_id] = @user.id
      flash[:notice] = "You have successfully registered."
      redirect_to root_path
    else
      render 'new'
    end
  end

  def update

    if @user.update(user_params)
      flash[:notice] = "You have successfully updated your profile."
      redirect_to user_path(@user)
    else
      render 'edit'
    end
  end

  def destroy

  end

  private

  def user_params
    params.require(:user).permit(:username, :password, :time_zone)
  end

  def set_user
    @user = User.find_by(slug: params[:id])
  end
end
