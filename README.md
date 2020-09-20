# README

# テーブル設計
## users テーブル
| Column   | Type   | Options     |
| -------- | ------ | ----------- |
| nickname     | string | null: false |
| email    | string | null: false |
| password | string | null: false |
| first_name | string | null: false |
| last_name | string | null: false |
| first_name_kana | string | null: false |
| last_name_kana | string | null: false |
| birthday | date | null: false |

### Association
- has_many :items
- has_many :purchases


## items テーブル
| Column   | Type   | Options     |
| -------- | ------ | ----------- |
| name | string | null: false |
| user_id | int | null: false, foreign_key: true|
| describe      |string | null: false |
| category_id      | int   | null: false |
| condition_id   | int   | null: false |
| price      | int | null: false | 
| delivery_fee_id      | int | null: false | 
| shipping_from_id     | int | null: false | 
| delivery_day_id    | int | null: false | 



### Association
- belongs_to :user
- has_one :purchase
- belongs_to_active_hash :category
- belongs_to_active_hash :condition
- belongs_to_active_hash :delivery_fee
- belongs_to_active_hash :prefecture
- belongs_to_active_hash :delivery_day

 

## purchases テーブル
| Column | Type       | Options                        |
| ------ | ---------- | ------------------------------ |
| user   | references | null: false, foreign_key: true |
| item   | references | null: false, foreign_key: true |

### Association
- belongs_to :user
- belongs_to :item
- has_one :shipping


## shippings テーブル
| Column | Type       | Options                        |
| ------ | ---------- | ------------------------------ |
| purchase   | references | null: false, foreign_key: true |
| postal_code| string | null: false |
| prefecture_id| int | null: false　|
| municipality| string | null: false |
| address_number | string | null: false |
| building_name| string |  |
| phone_number| string | null: false |

### Association
- belongs_to :purchase
- belongs_to_active_hash :prefecture
