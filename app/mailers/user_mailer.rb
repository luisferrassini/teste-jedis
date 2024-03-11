class UserMailer < ApplicationMailer
  def welcome_email(municipe, subject, content)
    send_email(municipe, subject, content)
  end

  def update_email(municipe, subject, content)
    send_email(municipe, subject, content)
  end

  private

  def send_email(municipe, subject, content)
    @municipe = municipe
    @content = content
    mail(to: @municipe.email, subject:)
  end
end
