class PostsController < ApplicationController
  before_action :need_signed_in
  before_action :correct_user, only: [ :destroy ]

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      flash[:success] = "发布成功"
      redirect_to root_path
    else
      @feed_items = []
      render 'static_pages/home'
    end
  end

  def destroy
    @post.destroy
    redirect_to root_path
  end

  private 

    def post_params
      params.require(:post).permit(:content)
    end

    def correct_user 
      @post = current_user.posts.find params[:id]
      redirect_to root_path if @post.nil?
    end
end
