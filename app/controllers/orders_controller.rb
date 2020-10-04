class OrdersController < ApplicationController
  def index
    @order_address = OrderAddress.new
    @item = Item.find_by(params[:id])
  end

  def create
    @order_address = OrderAddress.new(order_params)
    if @order_address.valid?
      @order_address.save
      return redirect_to root_path
    else
      @item = Item.find_by(params[:id])
      render action: :index
    end
  end

  private

  def order_params
    params.permit(:postal_code, :prefecture, :city, :house_number, :building_name, :phone_number).merge(token: params[:token], item_id: params[:item_id])
  end
end
