class Admin::ItemsController < ApplicationController
  before_action :authenticate_admin!

  def index
    @items = Item.all
  end

  def edit
    @item = Item.find(params[:id])
    @genres= Genre.all
  end

  def update
    @item = Item.find(params[:id])
    if @item.update(item_params)
      redirect_to admin_item_path(@item), notice: "商品の編集に成功しました"
    else
      render "edit"
    end
  end

  def new
    @item = Item.new
    @genres= Genre.all
  end

  def show
    @item = Item.find(params[:id])
  end

  def create
    @item = Item.new(item_params)
    @genres = Genre.all
    if @item.save
      redirect_to admin_item_path(@item.id), notice: "商品の作成に成功しました"
    else
      render 'new'
    end
  end

  def search
    @items = Item.search(params[:keyword])
    @keyword = params[:keyword]
    render "index"
  end

  private

  def item_params
    params.require(:item).permit(:name, :introduction, :price, :is_active, :image, :genre_id)
  end
end
