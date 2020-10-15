class OrderAddress
  include ActiveModel::Model
  attr_accessor :postal_code, :prefecture_id, :city, :house_number, :building_name, :phone_number, :token, :item_id, :user_id

  with_options presence: true do
    validates :postal_code, format: {with: /\A[0-9]{3}-[0-9]{4}\z/, message: "にハイフン(ー)を入れてください"}
    validates :prefecture_id, numericality: { other_than: 1, message: "を選択してください" }
    validates :city, :house_number, :token
    validates :phone_number, format: {with: /\A[0-9]+\z/, message: "は半角数字で入力してください"}, length: { maximum: 11}
    end

    def save
      order = Order.create(item_id: item_id, user_id: user_id)
      Address.create(postal_code: postal_code, prefecture: prefecture_id, city: city, house_number: house_number, building_name: building_name, phone_number: phone_number, order_id: order.id)
    end
end