class Public::CartItemsController < ApplicationController

  def index
    @cart_item = CartItem.where(customer_id: current_customer.id)
  end

  def create
    @cart_item = CartItem.new(cart_item_params)
    @cart_item.customer_id = current_customer.id

    if @cart_item.save
      redirect_to cart_items_path, notice: "商品をカートに入れました"
    else
      session[:cart_item] = @cart_item.attributes.slice(*cart_item_params.keys)
      @item = Item.find_by(id:@cart_item.item_id)
      render item_path(@item.id)
    end
  end

  def cart_item_params
    params.require(:cart_item).permit(:item_id, :amount)
  end
end
