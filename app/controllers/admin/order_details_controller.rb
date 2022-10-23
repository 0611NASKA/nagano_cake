class Admin::OrderDetailsController < ApplicationController
  before_action :authenticate_admin!

  def update
    @order_detail = OrderDetail.find(params[:id])
    @order = @order_detail.order
    @order_details = @order.order_details
    @order_detail.update(order_detail_params)

    if @order_details.where(making_status: 2).count >= 1
      @order.status = 2
      @order.save
    end

     if @order.order_details.count == @order_details.where(making_status: 3).count
       @order.status = 3
       @order.save
     end
    redirect_to admin_order_path(@order_detail.order.id), notice: "制作ステータスを更新しました"
  end

  private

  def order_detail_params
    params.require(:order_detail).permit(:making_status)
  end
end
