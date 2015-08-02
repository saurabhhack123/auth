class UsersController < ApplicationController
  def new
  	@user = User.new
  end

  def create
  	@user = User.new(user_params)
  	if @user.save
  		UserNotifier.send_signup_email(@user).deliver
  		redirect_to root_url, :notice => "Signed up!"
  	else
  		render "new"
  	end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_salt, :password_hash, :password_confirmation)
  end

end
