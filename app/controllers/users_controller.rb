class UsersController < ApplicationController

  def new
    @user = User.new
    render :new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      login_user!(@user)
      render :show
    else
      flash.now[:errors] = @user.errors.full_messages
      render :new
      @user = nil
    end
  end

  def show
    @user = User.find_by(id: params[:id])
    if @user.nil?
      redirect_to bands_url
    else
      render :show
    end
  end
  
  private

  def user_params
    params.require(:user).permit(:email, :password)
  end
end