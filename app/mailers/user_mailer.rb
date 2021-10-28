class UserMailer < ApplicationMailer

  def validation_email
    @user = params[:user]
    @validate_code = params[:validate_code]
    mail(to: @user.email, subject: 'Validation Code' )
  end
end
