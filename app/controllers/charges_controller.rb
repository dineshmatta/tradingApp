class ChargesController < ApplicationController
    
    def new
      trade = PaxfulService.new(entity: 'fetchTrade').fetch_trade(params[:trade_hash])
      @trade = JSON.parse(trade.body)["data"]["trade"]
    end
    
    def create
      p 'LLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLL\n'
      
      # Amount in cents
      @amount = params[:stripeAmount].to_i * 100
      #@amount = @trade['fiat_amount_requested'].to_i * 100#500
    
      customer = Stripe::Customer.create(
        :email => params[:stripeEmail],
        :source  => params[:stripeToken]
      )
    
      charge = Stripe::Charge.create(
        :customer    => customer.id,
        :amount      => @amount,
        :description => 'Rails Stripe customer',
        :currency    => 'usd'
      )
    
    rescue Stripe::CardError => e
      flash[:error] = e.message
      redirect_to new_charge_path
    end
end
