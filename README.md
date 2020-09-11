# README

# テーブル設計
## users テーブル
| Column   | Type   | Options     |
| -------- | ------ | ----------- |
| nickname     | text | null: false |
| email    | text | null: false |
| password | text | null: false |
| first_name | text | null: false |
| last_name | text | null: false |
| first_name_kana | text | null: false |
| last_name_kana | text | null: false |
| birthday | int | null: false |

### Association
- has_many :comments
- has_many :items, through: user_item
- has_many :likes
- has_many :purchase


## item テーブル
| Column   | Type   | Options     |
| -------- | ------ | ----------- |
| image       | text | null: false |
| item_name | text | null: false |
| item_describe      |text | null: false |
| category      | text   | null: false |
| condition   | text   | null: false |
| price      | int | null: false | 
| delivery_fee      | text | null: false | 
| shipping_from      | text | null: false | 
| delivery_day    | text | null: false | 
| stock     | int |     | 


### Association
- has_many :comments
- has_many :likes
- has_many :purchase
- has_one :users, through: user_item

## user_item テーブル
| Column | Type       | Options                        |
| ------ | ---------- | ------------------------------ |
| user   | references | null: false, foreign_key: true |
| item   | references | null: false, foreign_key: true |

### Association
- belongs_to :users
- belongs_to :items


## comment テーブル
| Column | Type       | Options                        |
| ------ | ---------- | ------------------------------ |
| text   | text       |                                |
| user   | references | null: false, foreign_key: true |
| item   | references | null: false, foreign_key: true |

### Association
- belongs_to :users
- belongs_to :items


## like テーブル
| Column | Type       | Options                        |
| ------ | ---------- | ------------------------------ |
| user   | references | null: false, foreign_key: true |
| item   | references | null: false, foreign_key: true |

### Association
- belongs_to :users
- belongs_to :items


## purchase テーブル
| Column | Type       | Options                        |
| ------ | ---------- | ------------------------------ |
| user   | references | null: false, foreign_key: true |
| item   | references | null: false, foreign_key: true |

### Association
- belongs_to :users
- belongs_to :items
- has_one :shipping


## shipping テーブル
| Column | Type       | Options                        |
| ------ | ---------- | ------------------------------ |
| purchase   | references | null: false, foreign_key: true |
| address   | string | null: false |

### Association
- belongs_to :purchase
