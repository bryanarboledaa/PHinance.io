class User < ApplicationRecord
  has_many :main_books, dependent: :destroy
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  # after_create :set_stripe_customer_id

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable
  validates :username, :full_name, :company, presence: true
  validates :username, length: { minimum: 6 }

  enum status: { free: 0, paid: 1 }

  # def to_s
  #   email
  # end

  # def set_stripe_customer_id
  #   customer = Stripe::Customer.create(email: email)
  #   update(stripe_customer_id: customer.id)
  # end
end
