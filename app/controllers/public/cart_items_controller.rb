class Public::CartItemsController < ApplicationController

  def index
    @cart_item = CartItem.where(customer_id: current_customer.id)
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

  def cart_item_params
    params.require(:cart_item).permit(:item_id, :amount)
  end
end
