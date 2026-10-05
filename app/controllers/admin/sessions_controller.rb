class Admin::SessionsController < ApplicationController
  def new; end

  def create
    if valid_password?(params[:password])
      session[:admin_authenticated] = true
      redirect_to admin_posts_path, notice: "管理画面にログインしました。"
    else
      flash.now[:alert] = "パスワードが正しくありません。"
      render :new, status: :unprocessable_content
    end
  end

  def destroy
    reset_session
    redirect_to root_path, notice: "ログアウトしました。"
  end

  private

  def valid_password?(password)
    configured_password = ENV.fetch("ADMIN_PASSWORD", "")
    return false if configured_password.blank? || password.blank?

    ActiveSupport::SecurityUtils.secure_compare(
      Digest::SHA256.hexdigest(password),
      Digest::SHA256.hexdigest(configured_password)
    )
  end
end
