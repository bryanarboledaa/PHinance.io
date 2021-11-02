module StaticPagesHelper
  def api_stripe_price_fetch
    Stripe::Price.list(lookup_keys: ["minibook_year", "minibook_month"], expand: ['data.product']).data.sort_by {|p| p.unit_amount}
  end
end
