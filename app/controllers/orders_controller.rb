class OrdersController < ApplicationController
  before_action :set_item
  before_action :move_to_new_user_session
  before_action :move_to_index_session

  def index
    @order_address = OrderAddress.new
  end

  def create
    
    @order_address = OrderAddress.new(order_params)
    if @order_address.valid?
      pay_item
      @order_address.save
      return redirect_to root_path
    else
      render action: :index
    end
  end

  private

  def set_item
    @item = Item.find(params[:item_id])
  end

  def order_params
    params.require(:order_address).permit(:postal_code, :prefecture_id, :city, :house_number, :building_name, :phone_number).merge(token: params[:token], user_id: current_user.id, item_id: params[:item_id])
  end

  def pay_item
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
    Payjp::Charge.create(
      amount: @item.price,
      card: order_params[:token],   
      currency: 'jpy'              
    )
  end

  def move_to_new_user_session
    unless user_signed_in?
      redirect_to new_user_session_path
    end
  end

  def move_to_index_session
    if current_user.id == @item.user.id || @item.order.present?
      redirect_to root_path
    end
  end
end
