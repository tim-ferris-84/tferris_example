require 'countries'

class MarketController < ApplicationController
  include Countries

  FREE_ACCOUNT_COUNTRIES = ['Mexico', 'New Zealand', 'Sweden', 'Thailand']
  def index
    @countries = ISO3166::Country.all
    @markets = nil

    if params[:country] && params[:api_key]
      Rails.logger.info params: "#{params[:country]} and #{params[:api_key]}"
      country = params[:country]
      api_key = params[:api_key]

      api_service = MarketService.new
      response = api_service.get_markets(api_key)

      # Check if the response is successful (status code 200)
      if response.success?
        markets = JSON.parse(response.body)
        @markets = markets.detect { |market| market.dig('Country') == country }
      else
        @markets = {}
      end

      Rails.logger.info markets: @markets
    end
  end
end
