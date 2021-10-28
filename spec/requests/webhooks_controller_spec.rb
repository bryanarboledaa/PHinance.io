require 'stripe_mock'

RSpec.describe 'Webhooks', type: :request do
  let(:stripe_helper) { StripeMock.create_test_helper }

  before { StripeMock.start }

  after { StripeMock.stop }

  it 'creates a stripe customer' do
    customer = Stripe::Customer.create(email: 'phinance@io.com', source: stripe_helper.generate_card_token)
    expect(customer.email).to eq('phinance@io.com')
  end

  it 'mocks a stripe webhook with customer id' do
    event = StripeMock.mock_webhook_event('customer.created')

    customer_object = event.data.object
    expect(customer_object.id).not_to be_nil
  end

  it 'mocks a stripe webhook with custober card' do
    event = StripeMock.mock_webhook_event('customer.created')

    customer_object = event.data.object
    expect(customer_object.default_card).not_to be_nil
  end

  it 'mocks stripe connect webhooks' do
    event = StripeMock.mock_webhook_event('customer.created', account: 'acc_424242')

    expect(event.account).to eq('acc_424242')
  end
end
