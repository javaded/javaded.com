class ApplicationMailer < ActionMailer::Base
  default from: ENV.fetch("RESEND_FROM", "javaded.com <onboarding@resend.dev>")
  layout "mailer"
end
