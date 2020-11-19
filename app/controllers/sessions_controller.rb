class SessionsController < ApplicationController
  def create
    user = User.find_by(email: params[:email])
    # user = User.find_by(name: params[:name])
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

  def guest_login
    user = User.guest
    #user = User.find_or_create_by!(name: 'guest') do |user|
    #  user.assign_attributes({
    #  email: "guest@example.com",
    #  birthday: "1990-01-01",
    #  sex: 3})
    #  user.password = SecureRandom.urlsafe_base64
    #end
    session[:user_id] = user.id
    redirect_to :root, notice: "ゲストユーザーとしてログインしました。"
  end
end
