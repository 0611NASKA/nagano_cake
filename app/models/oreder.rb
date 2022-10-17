class Oreder < ApplicationRecord
  belongs_to :customer
  has_many :order_details, dependent: :destroy
end
