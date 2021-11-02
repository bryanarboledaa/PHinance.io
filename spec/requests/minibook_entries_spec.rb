require 'rails_helper'

RSpec.describe 'MinibookEntries', type: :request do
  let!(:confirmed_user) { create(:confirmed_user) }
  let!(:minibook) { MiniBook.create(user_id: confirmed_user.id, minibook_name: 'Avion School') }
  let!(:minibook_entry) { MinibookEntry.create(mini_book_id: minibook.id, user_id: confirmed_user.id, date_minib_entry: DateTime.now, minibook_entry_description: 'Payment for something', or_vat_reg_tin_minib: 'tin12345', debit_minib: 1000, credit_minib: 500) }

  describe 'confirmed user gets to access minibook entries page' do
    before do
      sign_in confirmed_user
    end

    it 'returns the /mini_books/:mini_book_id/minibook_entries page' do
      get mini_book_minibook_entries_path(minibook_entry.mini_book_id)
      expect(response).to have_http_status(:ok)
    end

    it 'renders the minibook entries page' do
      get mini_book_minibook_entries_path(minibook_entry.mini_book_id)
      expect(response).to render_template('index')
    end

    it 'renders the page list of all minibook entries' do
      get mini_book_minibook_entries_path(minibook_entry.mini_book_id)
      expect(response).to render_template('_all_minibook_entries')
    end
  end

  describe 'User gets to create a minibook entry' do
    before do
      sign_in confirmed_user
    end

    it 'direct users to minibook entry form' do
      get new_mini_book_minibook_entry_path(minibook_entry.mini_book_id)
      expect(response).to have_http_status(:ok)
    end

    it 'renders minibook entry form' do
      get new_mini_book_minibook_entry_path(minibook_entry.mini_book_id)
      expect(response).to render_template('new')
    end

    it 'allows user to post create minibook entry' do
      post mini_book_minibook_entries_path(minibook_entry.mini_book_id), params: { minibook_entry: { mini_book_id: minibook.id, user_id: confirmed_user.id, date_minib_entry: DateTime.now, minibook_entry_description: 'Payment for something', or_vat_reg_tin_minib: 'tin12345', debit_minib: 1000, credit_minib: 500 } }
      expect(response).to redirect_to mini_book_minibook_entries_path(minibook_entry.mini_book_id)
    end
  end

  describe 'User gets to edit a minibook entry' do
    before do
      sign_in confirmed_user
    end

    it 'renders minibook edit entry form' do
      get edit_mini_book_minibook_entry_path(minibook_entry.mini_book_id, minibook_entry.id)
      expect(response).to render_template('edit')
    end

    it 'allows user to edit minibook entry' do
      get edit_mini_book_minibook_entry_path(minibook_entry.mini_book_id, minibook_entry.id), params: { minibook_entry: { mini_book_id: minibook.id, user_id: confirmed_user.id, date_minib_entry: DateTime.now, minibook_entry_description: 'Payment for something', or_vat_reg_tin_minib: 'tin12345', debit_minib: 1000, credit_minib: 500 } }
      expect(response).to have_http_status(:ok)
    end

    it 'allows user to update minibook entry' do
      put mini_book_minibook_entry_path(minibook_entry.mini_book_id, minibook_entry.id), params: { minibook_entry: { mini_book_id: minibook.id, user_id: confirmed_user.id, date_minib_entry: DateTime.now, minibook_entry_description: 'Payment for something', or_vat_reg_tin_minib: 'tin12345', debit_minib: 1000, credit_minib: 500 } }
      expect(response).to redirect_to mini_book_minibook_entries_path(minibook_entry.mini_book_id)
    end

    it 'allows user to update/patch minibook entry' do
      patch mini_book_minibook_entry_path(minibook_entry.mini_book_id, minibook_entry.id), params: { minibook_entry: { mini_book_id: minibook.id, user_id: confirmed_user.id, date_minib_entry: DateTime.now, minibook_entry_description: 'Payment for something', or_vat_reg_tin_minib: 'tin12345', debit_minib: 1000, credit_minib: 500 } }
      expect(response).to redirect_to mini_book_minibook_entries_path(minibook_entry.mini_book_id)
    end
  end

  describe 'User gets to delete a minibook entry' do
    before do
      sign_in confirmed_user
    end

    it 'allows user to delete a minibook entry' do
      delete mini_book_minibook_entry_path(minibook_entry.mini_book_id, minibook_entry.id), params: { minibook_entry: { mini_book_id: minibook.id, user_id: confirmed_user.id, date_minib_entry: DateTime.now, minibook_entry_description: 'Payment for something', or_vat_reg_tin_minib: 'tin12345', debit_minib: 1000, credit_minib: 500 } }
      expect(response).to redirect_to mini_book_minibook_entries_path(minibook_entry.mini_book_id)
    end
  end

  describe 'user gets to export minibook entries table to pdf' do
    before do
      sign_in confirmed_user
    end

    it 'renders export to pdf template' do
      get minibook_entries_export_path(minibook_entry.mini_book_id)
      expect(response).to render_template('export_pdf')
    end

    it 'allows user to export pdf' do
      get minibook_entries_export_path(minibook_entry.mini_book_id)
      expect(response).to have_http_status(:ok)
    end
  end
end
