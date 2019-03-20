class SessionsController < ApplicationController
  def new
    @user = User.new
  end

  def create
    params = session_params

    @user = User.find_by_email(params['email'])
    # If the user exists AND the password entered is correct.
    if @user
      if @user.authenticate(params['password'])
        # Save the user id inside the browser cookie. This is how we keep the user
        # logged in when they navigate around our website.
        session[:user_id] = @user.email
        redirect_to [:products]
      else
        # If user's login doesn't work, send them back to the login form.
        @user.errors.add(:password, 'is incorrect')
        render :new
      end
    else
      @user = User.new
      @user.errors.add(:email, 'do not exist')
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to [:products]
  end

  private

  def session_params
    params.require(:login).permit(
      :email,
      :password
    )
  end
end
