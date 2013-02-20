require 'digest/md5'

module Dotpay
  class Response
    CHECKSUM_KEYS = %w(id control t_id amount email service code username password t_status)

    STATUS_NEW          = 1
    STATUS_DONE         = 2
    STATUS_REJECTED     = 3
    STATUS_REFUND       = 4
    STATUS_COMPLAINT    = 5

    attr_reader :params

    def initialize(params)
      @params = params
    end

    def t_id
      params['t_id']
    end

    def control
      params['control']
    end

    def amount
      params['amount']
    end

    def authorized?
      params['md5'] == calculate_checksum
    end

    def status
      params['t_status'].to_i
    end

    def status_new?
      status == STATUS_NEW
    end

    def status_done?
      status == STATUS_DONE
    end

    def status_rejected?
      status == STATUS_REJECTED
    end

    def status_refund?
      status == STATUS_REFUND
    end

    def status_complaint?
      status == STATUS_COMPLAINT
    end

    private

    def calculate_checksum
      data = [ Dotpay.configuration.pin ]

      CHECKSUM_KEYS.each { |key| data << params[key] }

      data_string = data.join(':')

      Digest::MD5.hexdigest(data_string)
    end

  end
end
