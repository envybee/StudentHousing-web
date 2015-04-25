class UserMailer < ApplicationMailer

  def housing_inquiry_email(user, sender_email, message)
    @user = user
    @sender_email = sender_email
    @message = message
    mail(from: 'EpitHome <hello@epithome.com>', to: @user.email, subject: "You got a reply for your ad on EpitHome")
  end
end
