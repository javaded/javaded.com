class ContactMailer < ApplicationMailer
  # Params come from MessagesController#create via `ContactMailer.with(...).submission`.
  # Delivered to the site owner; reply-to is the visitor so the owner can respond directly.
  def submission
    @name    = params[:name]
    @email   = params[:email]
    @message = params[:message]
    mail to: "j.effatdoost@gmail.com",
         from: "javaded.com contact form <no-reply@#{ENV.fetch('MAILGUN_DOMAIN', 'javaded.com')}>",
         reply_to: @email,
         subject: "New message from #{@name.presence || 'someone'}"
  end
end
