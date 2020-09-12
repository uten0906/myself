class AccountsController < ApplicationController
  before_action :login_required

  def show
    @user = current_user
    @posts = @user.posts.page(params[:page]).per(10)
    @likes = @user.liked_posts.page(params[:page]).per(10)
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    @user.assign_attributes(account_params)
    if @user.save
      redirect_to :account, notice: "アカウント情報を変更しました。"
    else
      render "edit"
    end
  end

  def destroy
    @user = current_user
    @user.destroy
    redirect_to :root, notice: "アカウント情報を削除しました。"
  end

  private def account_params
    params.require(:account).permit(
      :new_profile_picture,
      :name,
      :email,
      :birthday,
      :sex
    )
  end
end
