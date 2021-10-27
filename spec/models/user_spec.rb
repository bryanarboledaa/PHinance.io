require 'rails_helper'

RSpec.describe User, type: :model do
  context 'when validating user' do
    it 'is not valid without username' do
      user1 = described_class.new(username: nil, email: 'test.dev@gmail.com', full_name: 'Bryan Dev', company: 'Bryan Technologies Inc.', password: 'password1234')

      expect(user1).not_to be_valid
    end

    it 'is not valid if username is less than 6 characters' do
      user2 = described_class.new(username: 'piggy', email: 'test.dev@gmail.com', full_name: 'Bryan Dev', company: 'Bryan Technologies Inc.', password: 'password1234')

      expect(user2).not_to be_valid
    end

    it 'is not valid without email' do
      user5 = described_class.new(username: 'piggyoink', email: nil, full_name: 'Piggy Oink', company: 'Piggy Ventures', password: 'piggyoink1234')

      expect(user5).not_to be_valid
    end
  end

  context 'when email is not unique' do
    before { described_class.new(email: 'test.dev@gmail.com') }

    it 'is not valid using email multiple times' do
      user1 = described_class.new(email: 'text.dev@gmail.com')

      expect(user1).not_to be_valid
    end
  end
end
