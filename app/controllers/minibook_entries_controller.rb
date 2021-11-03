class MinibookEntriesController < ApplicationController
  before_action :authenticate_user!
  before_action :correct_minibook
  before_action :correct_user, only: %i[edit update destroy]

  def index
    @mini_book_id = params[:mini_book_id]
    @minibook_entries = MiniBook.find(params[:mini_book_id]).minibook_entries
  end

  def export_pdf
    @mini_book_id = params[:mini_book_id]
    @minibook_entries = MiniBook.find(params[:mini_book_id]).minibook_entries
    respond_to do |format|
      format.html
      format.pdf do
        render pdf: "Minibook entry #{@mini_book.minibook_name} as of: #{Time.zone.today}", template: 'minibook_entries/export_pdf.html.erb'
      end
    end
  end

  def new
    @minibook_entry = @mini_book.minibook_entries.build
  end

  def create
    @minibook_entry = @mini_book.minibook_entries.build(minibook_entries_params)
    if @minibook_entry.save
      redirect_to mini_book_minibook_entries_path
    else
      render :new
    end
  end

  def edit
    @minibook_entry = MinibookEntry.find(params[:id])
  end

  def update
    @minibook_entry = MinibookEntry.find(params[:id])
    if @minibook_entry.update(minibook_entries_params)
      flash[:notice] = 'Sucessfully updated Minibook entry'
      redirect_to mini_book_minibook_entries_path(@minibook_entry.mini_book_id)
    else
      render :edit
    end
  end

  def destroy
    @minibook_entry = MinibookEntry.find(params[:id])
    if @minibook_entry.destroy
      flash[:notice] = 'Sucessfully deleted Minibook Entry'
      redirect_to mini_book_minibook_entries_path(@minibook_entry.mini_book_id)
    else
      render :mini_book_minibook_entries_path
    end
  end

  def correct_user
    @minibook_entry = current_user.minibook_entries.find_by(id: params[:id])
    redirect_to mini_book_minibook_entries_path, notice: 'Not Authorized to access this page' if @minibook_entry.nil?
  end

  private

  def correct_minibook
    @mini_book = MiniBook.find(params[:mini_book_id])
  end

  def minibook_entries_params
    params.require(:minibook_entry).permit(:mini_book_id, :date_minib_entry, :minibook_entry_description, :or_vat_reg_tin_minib, :debit_minib, :credit_minib, :minibook_balance, :user_id)
  end
end
