class MessagesController < ApplicationController
  allow_unauthenticated_access

  def create
    if message_params.values.any?(&:present?)
      ContactMailer.with(message_params.to_h.symbolize_keys).submission.deliver_later
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
