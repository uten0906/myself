class PasswordsController < ApplicationController
  before_action :login_required

  def show
    redirect_to :account
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    current_password = account_params[:current_password]

    if current_password.present?
      if @user.authenticate(current_password)
        @user.assign_attributes(account_params)
        if @user.save
          redirect_to :account, notice: "パスワードを変更しました。"
        else
          flash.alert = "エラーがあります。"
          render "edit"
        end
      else
        @user.errors.add(:current_password, :wrong)
        flash.alert = "エラーがあります。"
        render "edit"
      end
    else
      @user.errors.add(:current_password, :empty)
      flash.alert = "エラーがあります。"
      render "edit"
    end
  end

  private def account_params
    params.require(:account).permit(
      :current_password,
      :password,
      :password_confirmation
    )
  end
end
