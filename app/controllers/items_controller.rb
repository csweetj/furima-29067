class ItemsController < ApplicationController
  before_action :move_to_index, except: [:index, :show,]
  before_action :set_item, only: [:show]

  def index
    @items = Item.all.order("created_at DESC")
  end

  def show
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path
    else
      render :new
    end
  end

  private

  def set_item
    @item = Item.find(params[:id])
  end
  
  def item_params
    params.require(:item).permit(:name, :image, :describe, :price, :category_id, :condition_id, :delivery_day_id, :delivery_fee_id, :prefecture_id).merge(user_id: current_user.id)
  end

  def move_to_index
    unless user_signed_in?
      redirect_to action: :index
    end
  end
end
