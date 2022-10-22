class Public::OrdersController < ApplicationController
  before_action :authenticate_customer!

  def new
    @order = Order.new
    @addresses = Address.where(customer_id: current_customer.id)
    @customer = current_customer
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
    @order = Order.new(order_params)
  if params[:order][:address_option] == "0"
    @order.name = current_customer.full_name_a
    @order.address = current_customer.address_display
  elsif params[:order][:address_option] == "1"
    if Address.exists?(name: params[:order][:address])
      @order.name = Address.find(params[:order][:address]).full_name_a
      @order.address = Address.find(params[:order][:address]).address_display
    else
      render :new
    end
  elsif params[:order][:address_option] == "2"
    @address_new = current_customer.addresses.new(address_params)
    if @address_new.save
    else
      render :new
    end
  else
    redirect_to root_path
  end
  @cart_items = current_customer.cart_items.all
  @total = @cart_items.inject(0) { |sum, item| sum + item.sum_of_price }
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
