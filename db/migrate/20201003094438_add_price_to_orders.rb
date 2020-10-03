class AddPriceToOrders < ActiveRecord::Migration[6.0]
  def change
    add_column :orders, :price, :integer, null: false
  end
end
