class MainBook < ApplicationRecord
  belongs_to :user
  validates :user_id, presence: true
  validates :date_mainb, presence: true
  validates :mainbook_description, presence: true
  validates :or_vat_reg_tin_mainb, presence: true
end
