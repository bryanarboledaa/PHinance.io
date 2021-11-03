module StaticPagesHelper
  def api_stripe_price_fetch
    Stripe::Price.list(lookup_keys: %w[minibook_year minibook_month], expand: ['data.product']).data.sort_by(&:unit_amount)
  end
end
