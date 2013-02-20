require "dotpay/version"
require "dotpay/configuration"
require "dotpay/error"
require "dotpay/response"
require "dotpay/client"
require "dotpay/cancel_request"

module Dotpay
  class << self
    attr_writer :configuration

    ##
    # Used to configure Dotpay.
    #
    # = Example
    #
    #   Dotpay.configure do |config|
    #     config.account_id            = 0000
    #     config.pin                   = 'aaaabbbbccccdddd'
    #     config.cancel_login          = 'cancelapilogin'
    #     config.cancel_password       = 'cancelapipassword'
    #   end
    def configure
      yield(configuration)
    end

    ##
    # The configuration object.
    # Recommended to use Dotpay.configure
    def configuration
      @configuration ||= Configuration.new
    end

    # Cancel transaction
    def cancel_transaction(t_id, amount, control, options = {})
      cancel_request = CancelRequest.new(t_id, amount, control, options)

      client.cancel_transaction(cancel_request)
    end

    private

    ##
    # Dotpay Client.
    def client
      @client ||= Client.new(configuration)
    end

  end
end
