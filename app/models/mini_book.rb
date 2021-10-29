class MiniBook < ApplicationRecord
  has_many :minibook_entries, dependent: :destroy
  belongs_to :user
  # has_many :checkouts #, dependent: :destroy
  validates :minibook_name, presence: true
end
