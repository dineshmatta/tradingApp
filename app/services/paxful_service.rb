require 'rest-client'
require 'openssl'
require 'Base64'

class PaxfulService

  BASE_ENDPOINTS = 'https://paxful.com/api/'

  ENDPOINTS = {
    'tradeList' => 'trade/list'
  }

  def initialize(params)
    @endpoint = ENDPOINTS[params[:entity]]
    @url = BASE_ENDPOINTS + @endpoint
  end

  def fetch_trades
    begin
      ## Make API call to paxful 
      response = RestClient::Request.execute(method: :post, url: @url, payload: get_request_payload)
    rescue RestClient::ExceptionWithResponse => e
      e.response
    end
  end

  private

  # attr_reader :card, :amount, :email

  def get_request_payload(req_params=nil)
    payload = "apikey="+configatron.apiKey+"&nonce="+Time.now.to_i.to_s
    if(req_params)
      payload += req_params.join('&')
    end
    final_payload = payload+calculate_api_seal(payload)
  end

  def calculate_api_seal(data)
    apiseal = '&apiseal='
    secret_key = configatron.secret
    final_api_seal = apiseal + Base64.encode64(OpenSSL::HMAC.digest(OpenSSL::Digest.new('sha256'), secret_key, data)).strip()
  end

  # def external_charge_service
  #   Stripe::Charge
  # end

  # def external_customer_service
  #   Stripe::Customer
  # end

  # def charge_attributes
  #   {
  #     amount: amount,
  #     card: card
  #   }
  # end

  # def customer_attributes
  #   {
  #     email: email,
  #     card: card
  #   }
  # end
end