class UserMailer < ApplicationMailer

  def housing_inquiry_email(user, sender_email, message)
    @user = user
    @sender_email = sender_email
    @message = message
    mail(from: 'nvssproductions@gmail.com', to: @user.email, subject: "You got a reply for your ad on _____")
  end
end
