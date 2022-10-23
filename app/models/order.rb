class Order < ApplicationRecord
  belongs_to :customer
  has_many :order_details, dependent: :destroy

  enum payment_method: {
    credit_card: 0,
    transfer: 1
  }

  enum status: {
    waiting: 0,
    confirmation: 1,
    production: 2,
    preparing: 3,
    shipped: 4
  }

  def self.cart_items_total_price(cart_items)
    array = []
    cart_items.each do |cart_item|
      array << cart_item.item.price * cart_item.amount
    end
    return (array.sum * 1.1).floor
  end
end
