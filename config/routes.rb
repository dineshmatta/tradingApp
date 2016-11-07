Rails.application.routes.draw do
  resources :trades
  root to: "trades#index"
  match 'generate_trade_url/:trade_hash', to: 'trades#generate_url', as: 'generate_trade_url', via: [:get]
end
