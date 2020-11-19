class UsersController < ApplicationController
  before_action :login_required, only: [:edit, :update, :destroy]

  def index
    @users = User.all.page(params[:page]).per(10)
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.page(params[:page]).per(10)
    @likes = @user.liked_posts.page(params[:page]).per(10)
  end

  def new
    @user = User.new(birthday: Date.new(1980, 1, 1))
  end

  def edit
    @user = User.find(params[:id])
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to account_path, notice: "ユーザー情報を登録しました。"
    else
      flash.alert = "エラーがあります。"
      render "new"
    end
  end

  def update
    @user = User.find(params[:id])
    @user.assign_attributes(user_params)
    if @user.save
      redirect_to @user, notice: "ユーザー情報を更新しました。"
    else
      flash.alert = "エラーがあります。"
      render "edit"
    end
  end

  def destroy
    @user = User.find(params[:user])
    @user.destroy
    redirect_to :users, notice: "ユーザー情報を削除しました。"
  end

  def search
    @users = User.search(params[:q]).page(params[:page]).per(10)
    render "index"
  end

  def login_form
  end

  def followings
    @user = User.find(params[:id])
    @users = @user.followings.page(params[:page]).per(10)
    render "show_followings"
  end

  def followers
    @user = User.find(params[:id])
    @users = @user.followers.page(params[:page]).per(10)
    render "show_followers"
  end

  private def user_params
    attrs = [
      :new_profile_picture,
      :name,
      :email,
      :birthday,
      :sex
    ]

    attrs << :password if params[:action] == "create"

    params.require(:user).permit(attrs)
  end
end
