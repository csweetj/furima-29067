class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :category
  belongs_to_active_hash :condition
  belongs_to_active_hash :delivery_day
  belongs_to_active_hash :delivery_fee
  belongs_to_active_hash :prefecture

  #空の出品を保存できないようにする
  validates :name, :describe, :price, :image, presence: true
  #カテゴリ、商品の状態、配送料の負担、発送元の地域、発送までの日数の選択が「--」の時は保存できないようにする
  validates :category_id, :condition_id, :delivery_day_id, :delivery_fee_id, :prefecture_id, numericality: { other_than: 1, message: "can't be blank"} 

  validates :price, format: { with: /\A[0-9]+\z/, message:"must be number"}, numericality:{ greater_than_or_equal_to: 300, less_than_or_equal_to: 9999999, message: "between ¥300〜¥9,999,999" }

  belongs_to :user
  has_one_attached :image
end
