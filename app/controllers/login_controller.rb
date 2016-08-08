class LoginController < ApplicationController

  skip_before_action :authenticate, only: [:create]

  # POST /login
  def create
    @user = User.find_by_username(user_params[:username]).try(:authenticate, user_params[:password])

    if @user
      render json: {"username": @user.username, "token": @user.token}
    else
      render json: {msg: 'Unknown credentials'}, status: :forbidden
    end
  end

  private
    # Only allow a trusted parameter "white list" through.
    def user_params
      params.require(:user).permit(:username, :password)
    end

end
