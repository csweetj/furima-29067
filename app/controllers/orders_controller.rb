class OrdersController < ApplicationController
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
      render "index"
    end
  end

  private

  def order_params
    params.require(:order_address).permit(:postal_code, :prefecture, :city, :house_number, :building_name, :phone_number).merge(token: params[:token], item_id: params[:item_id])
  end

  def pay_item
    @item = Item.find_by(params[:id])
    Payjp.api_key = "" 
      Payjp::Charge.create(
        amount: @item.price,
        card: order_params[:token],   
        currency: 'jpy'              
      )
  end
end
