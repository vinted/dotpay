module Dotpay
  class Configuration
    # Account ID in Dotpay system, for which payment is made (Seller's account ID)
    attr_accessor :account_id

    # URLC PIN
    # 16-character alphanumeric string defined in section: Settings → URLC parameters
    attr_accessor :pin

    # Language
    #
    # Defaults to :pl
    #
    # :pl → Polish
    # :en → English
    # :de → German
    # :it → Italian
    # :fr → French
    # :es → Spanish
    # :cz → Czech
    # :ru → Russian
    # :bg → Bulgarian
    attr_accessor :language

    # service hostname
    attr_accessor :endpoint

    # provider's email
    attr_accessor :email

    # Cancel API endpoint
    attr_accessor :cancel_endpoint

    # Cancel API login
    attr_accessor :cancel_login

    # Cancel API password
    attr_accessor :cancel_password

    def initialize
      @language = :pl
      @endpoint = 'https://ssl.dotpay.pl/'
      @cancel_endpoint = 'https://ssl.dotpay.pl/api/cancel/'
    end

    ##
    # Allows config options to be read like a hash
    #
    # option: Key for a given attribute
    def [](option)
      send(option)
    end
  end
end
