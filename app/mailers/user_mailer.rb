class UserMailer < ActionMailer::Base
  default :from => "pedroherub@riderstate.com"

  def welcome_email(user)
    mail(:to => user.email, :subject => "Invitation Request Received")
  end
end
