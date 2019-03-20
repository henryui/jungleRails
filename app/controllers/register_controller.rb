class RegisterController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      session[:user_id] = @user.email
      redirect_to [:products], notice: 'User created!'
    else
      render :new
    end
  end

  private

  def user_params
    params.require(:register).permit(
      :first_name,
      :last_name,
      :email,
      :password
    )
  end
end
