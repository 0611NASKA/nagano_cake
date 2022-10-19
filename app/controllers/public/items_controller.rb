class Public::ItemsController < ApplicationController
  before_action :authenticate_customer!, except: [:index]
  
  def index
    @items = Item.all
  end
end
