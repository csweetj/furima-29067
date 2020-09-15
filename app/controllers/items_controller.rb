class ItemsController < ApplicationController

  def index
    @item = Item.order("created_at DESC")
  end
end
