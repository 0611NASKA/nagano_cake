class Public::OrdersController < ApplicationController
  before_action :authenticate_customer!

  def new
    @order = Order.new
    @addresses = Address.where(customer_id: current_customer.id)
  end

  def create
    cart_items = current_customer.cart_items.all
    @order = current_customer.orders.new(order_params)
    if @order.save
      @cart_items.each do |cart|
        order_item = OrderItem.new
        order_item.item_id = cart.item_id
        order_item.order_id = @order.id
        order_item.order_quantity = cart.quantity
        order_item.order_price = cart.item.price
        order_item.save
      end
      redirect_to 遷移したいページのパス
      cart_items.destroy_all
    else
      @order = Order.new(order_params)
      render :new
    end
  end

  def confirm
  end

  private

  def order_params
    params.require(:order).permit(:posta_code,:address, :name, :shipping_cost,
      :address, :total_payment, :payment_method, :status)
  end

  def address_params
    params.require(:address).permit(:name, :postal_code, :address)
  end
end
