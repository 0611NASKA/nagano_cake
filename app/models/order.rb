class Order < ApplicationRecord
  belongs_to :customer
  has_many :order_details, dependent: :destroy

  enum payment_method: {
    credit: 0,
    bank: 1
  }

  enum status: {
    waiting: 0,
    confirmation: 1,
    production: 2,
    preparing: 3,
    shipped: 4
  }
end
