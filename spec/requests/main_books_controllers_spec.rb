require 'rails_helper'

RSpec.describe 'MainBooks', type: :request do
  let!(:confirmed_user) { create(:confirmed_user) }
  let(:mainbook_entries) { MainBook.create(user_id: confirmed_user.id, date_mainb: DateTime.now, mainbook_description: 'Payment for electricity', or_vat_reg_tin_mainb: 'tin12345', debit_mainb: rand(100..5000), credit_mainb: rand(100..5000)) }

  describe 'confirmed user gets to access mainbook page' do
    before do
      sign_in confirmed_user
    end

    it 'returns the mainbook index page' do
      get mainbook_path
      expect(response).to have_http_status(:ok)
    end

    it 'renders the mainbook index page' do
      get mainbook_path
      expect(response).to render_template('index')
    end

    it 'returns the mainbook entries page' do
      get mainbook_entries_path
      expect(response).to have_http_status(:ok)
    end

    it 'renders the mainbook entries page' do
      get mainbook_entries_path
      expect(response).to render_template('mainbook_entries')
    end
  end

  describe 'User gets to create a mainbook entry' do
    before do
      sign_in confirmed_user
    end

    it 'direct users to main book entry form' do
      get mainbook_new_path
      expect(response).to have_http_status(:ok)
    end

    it 'renders main book entry form' do
      get mainbook_new_path
      expect(response).to render_template('new')
    end

    it 'allows users to post create mainbook entry' do
      post mainbook_entry_path, params: { main_book: { user_id: confirmed_user.id, date_mainb: DateTime.now, mainbook_description: 'Payment for electricity', or_vat_reg_tin_mainb: 'tin12345', debit_mainb: rand(100..5000), credit_mainb: rand(100..5000) } }
      expect(response).to redirect_to mainbook_entries_path
    end
  end

  describe 'User gets to edit a mainbook entry' do
    before do
      sign_in confirmed_user
    end

    it 'renders mainbook edit entry form' do
      get edit_mainbook_path(mainbook_entries.id)
      expect(response).to render_template('edit')
    end

    it 'allows user to edit a mainbook entry' do
      get edit_mainbook_path(mainbook_entries.id), params: { main_book: { user_id: confirmed_user.id, date_mainb: DateTime.now, mainbook_description: 'Payment for electricity', or_vat_reg_tin_mainb: 'tin12345', debit_mainb: rand(100..5000), credit_mainb: rand(100..5000) } }
      expect(response).to have_http_status(:ok)
    end

    it 'allows user to update/put mainbook entry' do
      put update_mainbook_path(mainbook_entries.id), params: { main_book: { user_id: confirmed_user.id, date_mainb: DateTime.now, mainbook_description: 'Payment for electricity', or_vat_reg_tin_mainb: 'tin12345', debit_mainb: rand(100..5000), credit_mainb: rand(100..5000) } }
      expect(response).to redirect_to mainbook_entries_path
    end
  end

  describe 'User gets to delete a mainbook entry' do
    before do
      sign_in confirmed_user
    end

    it 'allows user to delete a mainbook entry' do
      post delete_entry_path(mainbook_entries.id), params: { main_book: { user_id: confirmed_user.id, date_mainb: DateTime.now, mainbook_description: 'Payment for electricity', or_vat_reg_tin_mainb: 'tin12345', debit_mainb: rand(100..5000), credit_mainb: rand(100..5000) } }
      expect(response).to redirect_to redirect_to mainbook_entries_path
    end
  end

  describe 'user gets to export mainbook table to pdf' do
    before do
      sign_in confirmed_user
    end

    it 'renders export to pdf template' do
      get mainbook_export_path
      expect(response).to render_template('export_pdf')
    end

    it 'allows user to export pdf' do
      get mainbook_export_path
      expect(response).to have_http_status(:ok)
    end
  end
end
