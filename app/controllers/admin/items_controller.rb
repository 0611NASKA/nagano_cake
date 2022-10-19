class Admin::ItemsController < ApplicationController
  before_action :authenticate_admin!

  def index
    @items = Item.all
  end

  def new
    @item = Item.new
  end

  def show
    @item = Item.find(params[:id])
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to admin_item_path, notice: "商品の作成に成功しました"
    else
      render 'new'
    end
  end

  private

  def item_params
    params.require(:item).permit(:name, :introduction, :price, :is_active)
  end
end
