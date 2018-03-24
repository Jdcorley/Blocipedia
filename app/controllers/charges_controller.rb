class ChargesController < ApplicationController
  before_action :amount_to_be_charged, :set_description, :authenticate_user!

  def new
  end

  def thanks
  end 

  def create
    customer = StripeTool.create_customer(email: params[:stripeEmail], 
                                          stripe_token: params[:stripeToken])

    charge = StripeTool.create_charge(customer_id: customer.id, 
                                      amount: @amount, 
                                      description: @description)
      current_user.role = 'premium'
      current_user.save!
      puts current_user[:role]
      redirect_to thanks_path 
  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to new_charge_path
  end

  private 

  def set_description
    @description = "One month premium membership fee."
  end

  def amount_to_be_charged 
    @amount = 1500
  end 
end
