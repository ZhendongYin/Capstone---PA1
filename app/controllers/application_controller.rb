class ApplicationController < ActionController::Base

  def login?
    if current_user.nil?
    end
  end

  def validated?
    if !current_user.validated
    end
  end

  def current_user
    @current_user = User.find_by_id(session[:user_id])
  end
end
