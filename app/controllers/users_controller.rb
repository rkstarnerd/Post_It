class UsersController < ApplicationController
  def index

  end

  def show
	@user = User.find(params[:id])
  end

  def new
    @user = User.new	
  end

  def edit
  end

  def create
    @user = User.new(user_params)

    if @user.save
      flash[:notice] = "You have successfully registered."
      redirect_to root_path
    else
      render 'new'
    end
  end

  def update
    @user = User.update(user_params)

    if @user.save
      flash[:notice] = "You have successfully updated your profie."
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
end
