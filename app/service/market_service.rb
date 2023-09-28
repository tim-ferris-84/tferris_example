# app/services/api_service.rb

class MarketService
  include HTTParty
  base_uri 'https://api.tradingeconomics.com'
  API_KEY_DEFAULT = 'd8c9454c8d114f6:bo39jgr6rh5880r'

  def get_markets(api_key)
    options = {
      query: {
        c: (api_key.present? ? api_key : API_KEY_DEFAULT)
      }
    }
    Rails.logger.info get_data: options
    self.class.get('/markets/index', options) || []
  end
end
