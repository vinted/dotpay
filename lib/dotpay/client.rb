require 'uri'
require 'net/http'
require 'net/https'

module Dotpay
  class Client
    def initialize(configuration)
      @configuration = configuration
    end

    def cancel_transaction(cancel_request)
      params = {
        id:       @configuration.account_id,
        t_id:     cancel_request.t_id,
        control:  cancel_request.control,
        amount:   cancel_request.amount,
        type:     cancel_request.type,
        login:    @configuration.cancel_login,
        passwd:   @configuration.cancel_password,
        md5:      cancel_request.checksum
      }

      response = post(@configuration.cancel_endpoint, params)

      raise Error.new(response.body) unless response.body.strip == "OK"

      return true
    end

    private

    def post(url, params)
      uri = URI.parse(url)

      https = Net::HTTP.new(uri.host,uri.port)
      https.use_ssl = true

      request = Net::HTTP::Post.new(uri.request_uri)
      request.set_form_data(params)

      https.request(request)
    end
  end
end
