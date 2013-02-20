require 'digest/md5'

module Dotpay
  class CancelRequest
    attr_reader :t_id, :amount, :control, :type

    TYPE_FULL = 1
    TYPE_PARTIAL = 2

    def initialize(t_id, amount, control, options = {})
      options = {
        type: TYPE_FULL
      }.merge(options)

      @t_id = t_id
      @amount = "%0.2f" % amount
      @control = control
      @type = options[:type]
    end

    def checksum
      calculate_checksum
    end

    private

    def calculate_checksum
      data = [ Dotpay.configuration.cancel_login,
               Dotpay.configuration.pin,
               type,
               Dotpay.configuration.account_id,
               t_id,
               amount,
               control ]

      data_string = data.join(':')

      Digest::MD5.hexdigest(data_string)
    end

  end
end
