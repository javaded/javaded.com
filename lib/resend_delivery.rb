require "net/http"
require "uri"
require "json"

# Action Mailer delivery method that sends through Resend's HTTP API.
# Registered in config/environments/production.rb as :resend. The API key
# comes from ENV (never the repo); the from address is configurable via
# RESEND_FROM so we can use onboarding@resend.dev (no DNS) until javaded.com
# is verified in Resend.
#
#   config.action_mailer.resend_settings = { api_key: }
class ResendDelivery
  class DeliveryError < StandardError; end

  ENDPOINT = "https://api.resend.com/emails"

  def initialize(settings = {})
    @api_key = settings[:api_key]
  end

  def deliver!(mail)
    uri = URI(ENDPOINT)
    request = Net::HTTP::Post.new(uri)
    request["Authorization"] = "Bearer #{@api_key}"
    request["Content-Type"]  = "application/json"
    request.body = JSON.dump(payload(mail))

    response = Net::HTTP.start(uri.hostname, uri.port, use_ssl: true, open_timeout: 10, read_timeout: 20) do |http|
      http.request(request)
    end

    unless response.is_a?(Net::HTTPSuccess)
      raise DeliveryError, "Resend API #{response.code}: #{response.body}"
    end
  end

  private
    def payload(mail)
      {
        from:     mail["from"]&.value,
        to:       mail["to"]&.value,
        reply_to: mail["reply-to"]&.value,
        subject:  mail.subject.to_s,
        text:     mail_text(mail)
      }.compact
    end

    def mail_text(mail)
      mail.multipart? ? mail.text_part&.body&.decoded : mail.body&.decoded
    end
end
