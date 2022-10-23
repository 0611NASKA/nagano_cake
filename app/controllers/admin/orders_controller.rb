class Admin::OrdersController < ApplicationController
  before_action :authenticate_admin!

  def index
    @orders = Order.all
  end

  def show
    @order = Order.find(params[:id])
    @order_details = @order.order_details
  end

  def update
    @order = Order.find(params[:id])
    @order.update(order_params)
    @order_details = @order.order_details

    if @order.status = 1
      @order_details.each do |order_detail|
        order_detail.making_status = 1
        order_detail.save
      end
    end
    redirect_to admin_order_path, notice: "注文ステータスを更新しました"
  end

  private

  def order_params
    params.require(:order).permit(:status)
  end
end
