class ItemsController < ApplicationController
  before_action :move_to_new_user_session, except: [:index, :show,]
  before_action :set_item, only: [:show, :desytroy, :edit, :update]

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

  def edit
  end

  def update
    if @item.update(item_params)
      redirect_to action: :show
    else
      render :edit
    end
  end

  def destroy
    if @item.destroy
      redirect_to action: :index
    else
      render :show
    end
  end

  private

  def set_item
    @item = Item.find(params[:id])
  end
  
  def item_params
    params.require(:item).permit(:name, :image, :describe, :price, :category_id, :condition_id, :delivery_day_id, :delivery_fee_id, :prefecture_id).merge(user_id: current_user.id)
  end

  def move_to_new_user_session
    unless user_signed_in?
      redirect_to new_user_session_path
    end
  end
end
