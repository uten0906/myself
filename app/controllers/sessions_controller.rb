class SessionsController < ApplicationController
  def create
    user = User.find_by(name: params[:name])
    if user&.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to :root, notice: "ログインしました。"
    else
      flash.alert = "名前とパスワードが一致しません"
      render template: "users/login_form"
    end
  end

  def destroy
    session.delete(:user_id)
    redirect_to :root, notice: "ログアウトしました。"
  end
end
