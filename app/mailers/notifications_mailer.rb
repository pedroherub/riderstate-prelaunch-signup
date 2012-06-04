class NotificationsMailer < ActionMailer::Base

  default :from => "pedroherub@riderstate.com"
  default :to => "info@riderstate.com"

  def new_message(message)
    @message = message
    mail(:subject => "[RiderState] #{message.subject}")
  end

end
