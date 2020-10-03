class OrdersController < ApplicationController
  def index
  end

  def new
    @order_address = OrderAddress.new
  end

  def create
    @order_address = OrderAddress.new(order_params)
    if @order_address.valid?
      @order_address.save
      return redirect_to root_path
    else
      render "index"
    end
  end

  private

  def order_params
    params.permit(:postal_code, :prefecture, :city, :house_number, :building_name, :phone_number)
  end
end
