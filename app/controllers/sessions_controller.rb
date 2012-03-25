class SessionsController < ApplicationController
  skip_before_filter :require_login, only: %w(activated)

  def activate
    @user = User.load_from_activation_token(params[:activation_token])
    if @user
      @user.activate!
      redirect_to dashboard_path, notice: 'User was successfully activated.'
    else
      not_authenticated
    end
  end

  def destroy
    logout
    redirect_to root_path, notice: 'Logged out.'
  end
end
