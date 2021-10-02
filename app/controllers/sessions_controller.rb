class SessionsController < ApplicationController
  def new
  end
  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      redirect_to user_path(user.id)
    else
      flash.now[:donger] = 'ログインに失敗しました'
      render :new
    end
  end
end