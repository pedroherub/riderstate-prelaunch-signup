# -*- encoding : utf-8 -*-
class UserMailer < ActionMailer::Base
  default :from => "info@riderstate.com"

  def welcome_email(user)
    mail(:to => user.email, :subject => "Invitation Request Received")
  end
end
