class ItemsController < ApplicationController
  before_action :move_to_index, except: [:index, :show,]

  def index
    @items = Item.includes(:user).order("created_at DESC")
  end

private
  def move_to_index
    unless user_signed_in?
      redirect_to action: :index
    end
  end
end
