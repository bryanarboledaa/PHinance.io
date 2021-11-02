class MinibookEntry < ApplicationRecord
  belongs_to :mini_book
  belongs_to :user

  validates :user_id, presence: true
  validates :date_minib_entry, presence: true
  validates :minibook_entry_description, presence: true
  validates :or_vat_reg_tin_minib, presence: true
end
