class Item < ApplicationRecord
  has_one_attached :image
  has_many :cart_items, dependent: :destroy
  belongs_to :genre
  has_many :order_details, dependent: :destroy

  def get_image
    (image.attached?) ? image : 'no_image.jpg'
  end

  def add_tax_price
    (self.price * 1.1).floor
  end
end
