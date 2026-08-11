require "net/http"
require "uri"

# Action Mailer delivery method that sends through Mailgun's HTTP API.
# Registered in config/environments/production.rb as :mailgun. The API key
# comes from ENV (never the repo); domain/host are non-secret and configurable.
#
#   config.action_mailer.mailgun_settings = { api_key:, domain:, host: }
class MailgunDelivery
  class DeliveryError < StandardError; end

  def initialize(settings = {})
    @api_key = settings[:api_key]
    @domain  = settings[:domain]
    @host    = settings[:host] || "api.mailgun.net"
  end

  def deliver!(mail)
    uri = URI("https://#{@host}/v3/#{@domain}/messages")
    request = Net::HTTP::Post.new(uri)
    request.basic_auth("api", @api_key)
    request.set_form_data(
      from:    header(mail, "from"),
      to:      header(mail, "to"),
      subject: mail.subject.to_s,
      text:    mail_text(mail),
      "h:Reply-To" => header(mail, "reply-to")
    )

    response = Net::HTTP.start(uri.hostname, uri.port, use_ssl: true, open_timeout: 10, read_timeout: 20) do |http|
      http.request(request)
    end

    unless response.is_a?(Net::HTTPSuccess)
      raise DeliveryError, "Mailgun API #{response.code}: #{response.body}"
    end
  end

  private
    def header(mail, name)
      mail[name]&.value
    end

    def mail_text(mail)
      mail.multipart? ? mail.text_part&.body&.decoded : mail.body&.decoded
    end
end
