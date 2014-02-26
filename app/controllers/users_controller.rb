class UsersController < ApplicationController
  before_action :signed_in_user_not_signup, only: [ :new, :create ]
  before_action :need_signed_in,            only: [ :edit, :update, :index, :destroy, :following, :followers ]
  before_action :correct_user,              only: [ :edit, :update ]
  before_action :admin_user,                only: [ :destroy ]
  before_action :set_user,                  only: [ :show ]

  def new
    @user = User.new
  end

  def show
    @posts = @user.posts.page(params[:page])
  end

  def edit
  end

  def index
    @users = User.paginate(page: params[:page])
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

  def destroy
    user = User.find(params[:id])
    if current_user?(user)
      flash[:warning] = "不能删除自己"
    else
      user.destroy
      flash[:success] = "用户已删除"
    end
    redirect_to users_path
  end

  def following
    @title = '我关注的人'
    @user  = User.find params[:id]
    @users = @user.followed_users.page(params[:page])
    render 'show_follow'
  end

  def followers
    @title = '我的粉丝'
    @user  = User.find params[:id]
    @users = @user.followers.page(params[:page])
    render 'show_follow'
  end

  private
    
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end

    def set_user
      @user = User.find(params[:id])
    end

    def correct_user
      @user = User.find(params[:id])
      redirect_to root_path unless current_user?(@user)
    end

    def admin_user
      redirect_to root_path unless current_user.admin?
    end

    def signed_in_user_not_signup 
      redirect_to root_path if signed_in? 
    end
end
