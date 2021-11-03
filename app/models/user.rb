class User < ApplicationRecord
  has_many :main_books, dependent: :destroy
  has_many :mini_books, dependent: :destroy
  has_many :minibook_entries, dependent: :destroy
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable
  validates :username, :full_name, :company, presence: true
  validates :username, length: { minimum: 6 }
  validates :email, presence: true, uniqueness: true

  enum status: { free: 0, paid: 1 }
end
