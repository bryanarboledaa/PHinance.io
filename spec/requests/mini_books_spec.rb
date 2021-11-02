require 'rails_helper'

RSpec.describe 'MiniBooks', type: :request do
  let(:confirmed_user) { create(:confirmed_user) }
  let!(:minibook) { MiniBook.create(user_id: confirmed_user.id, minibook_name: 'Avion School') }

  describe 'confirmed user gets to access minibooks page' do
    before do
      sign_in confirmed_user
    end

    it 'returns the mainbook entries page' do
      get mini_books_path
      expect(response).to have_http_status(:ok)
    end

    it 'renders the mainbook entries page' do
      get mini_books_path
      expect(response).to render_template('index')
    end
  end

  describe 'User gets to create a new minibook' do
    before do
      sign_in confirmed_user
    end

    it 'direct users to new minibook entry form' do
      get new_mini_book_path
      expect(response).to have_http_status(:ok)
    end

    it 'renders the form for creating new minibook' do
      get new_mini_book_path
      expect(response).to render_template('new')
    end

    it 'allows user to post create minibook' do
      post mini_books_path, params: { mini_book: { user_id: confirmed_user.id, minibook_name: 'Avion School' } }
      expect(response).to redirect_to mini_books_path
    end
  end

  describe 'User gets to edit a minibook' do
    before do
      sign_in confirmed_user
    end

    it 'allows user to edit minibook' do
      get edit_mini_book_path(minibook.id), params: { mini_book: { user_id: confirmed_user.id, minibook_name: 'Avion School' } }
      expect(response).to have_http_status(:ok)
    end

    it 'renders minibook edit form' do
      get edit_mini_book_path(minibook.id)
      expect(response).to render_template('edit')
    end

    it 'allows user to update/put minibook' do
      put mini_book_path(minibook.id), params: { mini_book: { user_id: confirmed_user.id, minibook_name: 'Avion School' } }
      expect(response).to redirect_to mini_books_path
    end

    it 'allows user to update/patch minibook' do
      patch mini_book_path(minibook.id), params: { mini_book: { user_id: confirmed_user.id, minibook_name: 'Avion School' } }
      expect(response).to redirect_to mini_books_path
    end
  end

  describe 'user gets to delete a minibook' do
    before do
      sign_in confirmed_user
    end

    it 'allows user to delete a minibook' do
      delete mini_book_path(minibook.id), params: { mini_book: { user_id: confirmed_user.id, minibook_name: 'Avion School' } }
      expect(response).to redirect_to mini_books_path
    end
  end

  describe 'user gets to export minibooks table to pdf' do
    before do
      sign_in confirmed_user
    end

    it 'renders export to pdf template' do
      get minibook_export_path
      expect(response).to render_template('export_pdf')
    end

    it 'allows user to export pdf' do
      get minibook_export_path
      expect(response).to have_http_status(:ok)
    end
  end
end
