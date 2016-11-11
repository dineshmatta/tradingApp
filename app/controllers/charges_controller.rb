class ChargesController < ApplicationController
    
    def new
      trade = PaxfulService.new(entity: 'fetchTrade').fetch_trade(params[:trade_hash])
      @trade_hash = params[:trade_hash]
      @trade = JSON.parse(trade.body)["data"]["trade"]
    end
    
    def create
      @amount = params[:amount]
      
      @amount = @amount.gsub('$', '').gsub(',', '')
      
      @amount = @amount.to_i * 100 # Must be an integer!
    
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

      if(charge.status === 'succeeded')
        ## Write code to release bitcoins
        #PaxfulService.new(entity: 'tradeRelease').fetch_trade(params[:trade_hash])
      end
    rescue Stripe::CardError => e
      flash[:error] = e.message
      redirect_to new_charge_path
    end
end
