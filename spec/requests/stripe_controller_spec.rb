require 'stripe_mock'

describe 'Card API' do
  let(:stripe_helper) { StripeMock.create_test_helper }
  let(:customer) { Stripe::Customer.create(id: 'test_customer_sub') }
  let(:card_token) { stripe_helper.generate_card_token(last4: '1123', exp_month: 12, exp_year: 2015) }
  let(:card) { customer.sources.create(card: card_token) }

  before do
    StripeMock.start
  end

  after do
    StripeMock.stop
  end

  it 'creates a customer' do
    expect(card.customer).to eq 'test_customer_sub'
  end

  it 'creates a card with last 4 digits' do
    expect(card.last4).to eq '1123'
  end

  it 'creates a card with expiry month' do
    expect(card.exp_month).to eq 12
  end

  it 'creates a card with expiry year' do
    expect(card.exp_year).to eq 2015
  end
end
