class CheckoutsController < ApplicationController
  before_action :set_stripe_customer_id, only: [:create]

  def create
    @session = Stripe::Checkout::Session.create(
      { customer: current_user.stripe_customer_id,
        success_url: root_url,
      cancel_url: pricing_url,
      payment_method_types: ['card'],
      line_items: [
        { price: params[:price], quantity: 1 }
      ],
      mode: 'subscription' }
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
    return unless current_user.stripe_customer_id.nil?

    customer = Stripe::Customer.create(email: current_user.email)
    current_user.update(stripe_customer_id: customer.id)
  end
end
