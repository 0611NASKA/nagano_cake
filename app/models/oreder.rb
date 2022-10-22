class Oreder < ApplicationRecord
  belongs_to :customer
  has_many :order_details, dependent: :destroy

  enum payment_method: {
    credit: 0,
    bank: 1
  }
end
