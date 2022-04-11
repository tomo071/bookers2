class UsersController < ApplicationController
  before_action :session_url, only: [:edit,:update]
  def index
    @users=User.all
    @newbook=Book.new
  end

  def show
    @user=User.find(params[:id])
    @books=@user.books
    @newbook=Book.new
  end

  def edit
    @user=User.find(params[:id])
  end

  def update
    @user=User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] ="You have updated user successfully"
      redirect_to user_path(current_user.id)
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction)
  end

  def session_url
    @user=User.find(params[:id])
    unless @user==current_user
      redirect_to user_path(current_user.id)
    end
  end
end
