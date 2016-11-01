json.extract! trade, :id, :amount, :url, :created_at, :updated_at
json.url trade_url(trade, format: :json)