class UsersController < ApplicationController
  before_action :set_user, only: [ :show ]
  before_action :need_signed_in, only: [ :edit, :update ]
  before_action :correct_user, only: [ :edit, :update ]

  def new
    @user = User.new
  end

  def show
  end

  def edit
  end

  def update
    if @user.update_attributes(user_params)
      flash[:success] = "用户资料已更改"
      redirect_to @user
    else
      render 'edit'
    end
  end

  def create
    @user = User.new(user_params)

    if @user.save
      sign_in @user
      flash[:success] = "#{@user.name}，欢迎使用易博！"
      redirect_to @user
    else
      render 'new'
    end
  end

  private
    
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end

    def set_user
      @user = User.find(params[:id])
    end

    def need_signed_in
      unless signed_in?
        store_location
        flash[:warning] = "权限不足，请登录"
        redirect_to signin_path
      end
    end

    def correct_user
      @user = User.find(params[:id])
      redirect_to root_path unless current_user?(@user)
    end
end
