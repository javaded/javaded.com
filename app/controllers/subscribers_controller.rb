class SubscribersController < ApplicationController
  allow_unauthenticated_access
  rate_limit to: 10, within: 1.minute, only: :create

  def create
    email = params.expect(subscriber: [ :email ])[:email]

    case Resend::Audience.add_contact(email)
    when :added
      redirect_back(fallback_location: root_path, notice: "You're subscribed — thanks!")
    when :already_subscribed
      redirect_back(fallback_location: root_path, notice: "You're already on the list.")
    when :invalid
      redirect_back(fallback_location: root_path, alert: "Please enter a valid email address.")
    else
      redirect_back(fallback_location: root_path, alert: "Couldn't subscribe right now — try again in a moment.")
    end
  end
end
