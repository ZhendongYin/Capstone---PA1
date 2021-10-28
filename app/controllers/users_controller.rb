class UsersController < ApplicationController
  def new
  end

  def create
    @course = User.new(user_params)

    respond_to do |format|
      if @course.save
        format.html { redirect_to @course, notice: "Course was successfully created." }
        format.json { render :show, status: :created, location: @course }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @course.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit
  end

  def update
  end

  def validate
    validate_code = @email_redis_client.get(@user.id)
    if validate_code.blank?
      validate_code = Array.new(6){[*"A".."Z", *"0".."9"].sample}.join
      @email_redis_client.set(@user.id, validate_code)
    end
  end

  def validated
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password)
  end
end
