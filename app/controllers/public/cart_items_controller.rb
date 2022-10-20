class Public::CartItemsController < ApplicationController
  before_action :authenticate_customer!

  def index
    @cart_items = CartItem.where(customer_id: current_customer.id)
    @total = @cart_items.inject(0) { |sum, item| sum + item.sum_of_price }
  end

  def create
    @cart_item = current_customer.cart_items.build(cart_item_params)
    @cart_items = current_customer.cart_items.all

    @cart_items.each do |cart_item|
      if cart_item.item_id == @cart_item.item_id
        new_amount = cart_item.amount + @cart_item.amount
        cart_item.update_attribute(:amount, new_amount)
        @cart_item.delete
      end
    end
    @cart_item.save
    redirect_to cart_items_path, notice: "商品をカートに追加しました"
  end

  def update
    @cart_item = CartItem.find(params[:id])
    @cart_items = CartItem.where(customer_id: current_customer.id)
    @total = @cart_items.inject(0) { |sum, item| sum + item.sum_of_price }
    if @cart_item.update(cart_item_params)
      redirect_to cart_items_path, notice: "カート内容を変更しました"
    else
      @cart_items = current_customer.cart_items.all
      render 'index', notice: "カートを編集できませんでした"
    end
  end

  def destroy
    @cart_item = CartItem.find(params[:id])
    @cart_item.destroy
    redirect_to cart_items_path
  end

  def destroy_all
    current_customer.cart_items.destroy_all
    redirect_to cart_items_path
  end

  private

  def cart_item_params
    params.require(:cart_item).permit(:item_id, :amount)
  end
end
