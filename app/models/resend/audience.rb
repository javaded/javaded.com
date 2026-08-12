require "net/http"
require "uri"
require "json"

module Resend
  # Thin wrapper around Resend's Contacts API for adding a subscriber to an
  # audience. The sending-only API key used for mail can't manage contacts, so
  # production needs a key with contacts access (or full access). See deploy.yml
  # for RESEND_AUDIENCE_ID.
  class Audience
    ENDPOINT = URI("https://api.resend.com/contacts")

    class << self
      # Adds +email+ to the configured audience.
      # Returns :added, :already_subscribed, :invalid, or :error.
      def add_contact(email)
        return :invalid unless email.to_s.match?(/\A[^@\s]+@[^@\s]+\z/)

        response = post(email: email, audience_id: ENV["RESEND_AUDIENCE_ID"])
        return :error if response.nil?

        case response
        when Net::HTTPSuccess  then :added
        when Net::HTTPConflict then :already_subscribed
        else                        :error
        end
      end

      private
        def post(body)
          request = Net::HTTP::Post.new(ENDPOINT)
          request["Authorization"] = "Bearer #{ENV['RESEND_API_KEY']}"
          request["Content-Type"]  = "application/json"
          request.body = JSON.dump(body)
          Net::HTTP.start(ENDPOINT.hostname, ENDPOINT.port, use_ssl: true, open_timeout: 10, read_timeout: 15) do |http|
            http.request(request)
          end
        rescue Net::OpenTimeout, Net::ReadTimeout, Errno::ECONNREFUSED, SocketError, OpenSSL::SSL::SSLError, IOError
          nil
        end
    end
  end
end
