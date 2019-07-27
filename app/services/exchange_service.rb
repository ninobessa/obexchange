require 'rest-client'
require 'json'

class ExchangeService
  def initialize(source_currency, target_currency, amount)
    @source_currency = source_currency
    @target_currency = target_currency
    @amount = amount.to_f
  end

 
  def perform
    begin
      currency_has_bitcoin ? convert_exchange_with_bitcoin : convert_exchange
    rescue RestClient::ExceptionWithResponse => e
      e.response
    end
  end

  private

  def currency_has_bitcoin
    (@source_currency.include? 'BTC') || (@target_currency.include? 'BTC')
  end

  def convert_exchange
    exchange_api_url = Rails.application.credentials[Rails.env.to_sym][:currency_api_url]
    exchange_api_key = Rails.application.credentials[Rails.env.to_sym][:currency_api_key]
    url = "#{exchange_api_url}?token=#{exchange_api_key}&currency=#{@source_currency}/#{@target_currency}"
    res = RestClient.get url
    value = JSON.parse(res.body)['currency'][0]['value'].to_f
    value * @amount
  end

  def convert_exchange_with_bitcoin
    exchange_api_url = Rails.application.credentials[Rails.env.to_sym][:coin_api_url]
    exchange_api_key = Rails.application.credentials[Rails.env.to_sym][:coin_api_key]
    url = "#{exchange_api_url}/#{@source_currency}/#{@target_currency}?apikey=#{exchange_api_key}"
    res = RestClient.get url
    value = JSON.parse(res.body)['rate'].to_f
    value * @amount
  end

end

