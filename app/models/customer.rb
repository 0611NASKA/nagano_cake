class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :addresses, dependent: :destroy
  has_many :cart_items, dependent: :destroy
  has_many :orders, dependent: :destroy

  validates :last_name, presence: true
  validates :first_name, presence: true
  validates :last_name_kana, presence: true
  validates :first_name_kana, presence: true
  validates :postal_code, presence: true
  validates :address, presence: true
  validates :telephone_number, presence: true

  def active_for_authentication?
    super && (is_deleted == false)
  end
  def full_name
    self.last_name + self.first_name + "（" + self.last_name_kana + self.first_name_kana + "）"
  end

  def full_name_a
    self.last_name + self.first_name
  end

  def address_display
    '〒' + self.postal_code + ' ' + self.address + ' ' + self.full_name_a
  end
end
