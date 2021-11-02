class SessionsController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:destroy]

  def new
  end

  def create
    if login_params[:email].blank?
      @error_message = "Email must be filled in!"
    else
      user = User.find_by_email(login_params[:email])
      if user and user.authenticate(login_params[:password])
        reset_session
        params[:session][:remember_me] == '1' ? remember(user) : forget(user)
        log_in(user)
        remember(user)
        @courses = Course.all.order(:id).page(params[:page]).per(10)
      else
        @error_message = "Password is incorrect!"
      end
    end
  end

  def login
  end

  def destroy
    log_out if logged_in?
    redirect_to root_path
  end

  private
  def login_params
    params.require(:session).permit(:email, :password)
  end
end
