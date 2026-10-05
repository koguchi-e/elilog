class Admin::BaseController < ApplicationController
  before_action :require_admin

  private

  def require_admin
    return if session[:admin_authenticated]

    redirect_to admin_login_path, alert: "管理画面を開くにはパスワードが必要です。"
  end
end
