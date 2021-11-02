require 'rails_helper'

RSpec.describe MiniBook, type: :model do
  context 'when user is creating a minibook' do
    it 'is not allowed without a name' do
      minibook = described_class.new(user_id: nil, minibook_name: nil, minibook_price: 100)
      expect(minibook).not_to be_valid
    end
  end

  context 'when validating presence' do
    it { is_expected.to validate_presence_of(:user_id) }
    it { is_expected.to validate_presence_of(:minibook_name) }
  end

  context 'when validating associations' do
    it { is_expected.to belong_to(:user) }
  end
end
