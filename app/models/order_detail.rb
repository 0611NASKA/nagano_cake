class OrderDetail < ApplicationRecord
  belongs_to :item
  belongs_to :order

  enum making_status: {
    impossible: 0,
    waiting: 1,
    production: 2,
    completion: 3
  }

  def subtotal
    price * amount
  end
end
