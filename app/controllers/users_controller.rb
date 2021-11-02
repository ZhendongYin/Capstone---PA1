class UsersController < ApplicationController
  before_action :set_user, only: %i[ show edit update ]

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      reset_session
      log_in @user
    else
      @error_message = @user.errors.full_messages.first
    end
  end

  def edit
  end

  def register_course
    @course = Course.find_by_id(params[:course_id])
    if @course
      current_user.courses << @course
    end
    render template: 'users/update_course_status'
  end

  def drop_course
    @course = Course.find_by_id(params[:course_id])
    if @course
      current_user.enrollments.find_by(course_id: @course.id).delete
    end
    render template: 'users/update_course_status'
  end

  # def validate
  #   validate_code = @email_redis_client.get(@user.id)
  #   if validate_code.blank?
  #     validate_code = Array.new(6){[*"A".."Z", *"0".."9"].sample}.join
  #     @email_redis_client.set(@user.id, validate_code)
  #   end
  # end

  def validated
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
