class MessagesController < ApplicationController
  allow_unauthenticated_access

  def create
    if message_params.values.any?(&:present?)
      # Send synchronously: a contact form is low-volume and Resend replies in
      # well under a second, so a background job isn't worth the Solid Queue
      # worker dependency (the ONCE container doesn't run one).
      ContactMailer.with(message_params.to_h.symbolize_keys).submission.deliver_now
      redirect_to contact_path, notice: "Thanks — your message is on its way."
    else
      redirect_to contact_path, alert: "Please fill in the form before sending."
    end
  end

  private
    def message_params
      params.expect(message: [ :name, :email, :message ])
    end
end
