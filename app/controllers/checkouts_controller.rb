class CheckoutsController < ApplicationController
  after_action :set_stripe_customer_id, only: [:create]

  def create
    @session = Stripe::Checkout::Session.create(
      {
        success_url: root_url,
      cancel_url: pricing_url,
      payment_method_types: ['card'],
      line_items: [
        { price: params[:price], quantity: 1 }
      ],
      mode: 'subscription'
      }
    )

    respond_to do |format|
      format.js
    end
  end

  private

  def to_s
    email
  end

  def set_stripe_customer_id
    @users = User.all
    customer = Stripe::Customer.create(email: current_user.email)
    current_user.update(stripe_customer_id: customer.id)
  end
end
