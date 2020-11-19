class TopController < ApplicationController
  def index
    if current_user
      @users = current_user.followings
      @posts = Post.where(user_id: @users.ids).page(params[:page]).per(10)
    else
      @posts = Post.all.page(params[:page]).per(10)
    end
  end
end
